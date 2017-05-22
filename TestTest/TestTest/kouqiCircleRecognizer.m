//
//  kouqiCircleRecognizer.m
//  TestTest
//
//  Created by 程海峰 on 2016/12/16.
//  Copyright © 2016年 海峰. All rights reserved.
//
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "kouqiCircleRecognizer.h"
#import "kouqiGeometry.h"

#define SHOWDEBUG NO

#define POINT(_INDEX_) [(NSValue *)[points objectAtIndex:_INDEX_] CGPointValue]


#pragma mark - Helper Functions
CGRect boundingRect(NSArray *points)
{
    CGRect rect = CGRectZero;
    CGRect ptRect;
    
    for (NSUInteger i = 0; i < points.count; i++)
    {
        CGPoint pt = POINT(i);
        ptRect = CGRectMake(pt.x, pt.y, 0.0f, 0.0f);
        rect = (CGRectEqualToRect(rect, CGRectZero)) ? ptRect : CGRectUnion(rect, ptRect);
    }
    
    return rect;
}

CGRect testForCircle(NSArray *points, NSDate *firstTouchDate)
{
    if (points.count < 2)
    {
        if (SHOWDEBUG) NSLog(@"Too few points (2) for circle");
        return CGRectZero;
    }
    
    // Test 1: duration tolerance
    float duration = [[NSDate date] timeIntervalSinceDate:firstTouchDate];
    if (SHOWDEBUG) NSLog(@"Transit duration: %0.2f", duration);
    
    float maxDuration = 2.0f;
    if (duration > maxDuration) // allows longer time for use in simulator
    {
        if (SHOWDEBUG) NSLog(@"Excessive touch duration: %0.2f seconds vs %0.1f seconds", duration, maxDuration);
        return CGRectZero;
    }
    
    // Test 2: The number of direction changes should be limited to near 4
    int inflections = 0;
    for (NSUInteger i = 2; i < (points.count - 1); i++)
    {
        float deltx = dx(POINT(i), POINT(i-1));
        float delty = dy(POINT(i), POINT(i-1));
        float px = dx(POINT(i-1), POINT(i-2));
        float py = dy(POINT(i-1), POINT(i-2));
        
        if ((sign(deltx) != sign(px)) || (sign(delty) != sign(py)))
            inflections++;
    }
    
    if (inflections > 5)
    {
        if (SHOWDEBUG) NSLog(@"Excessive number of inflections (%d vs 4). Fail.", inflections);
        return CGRectZero;
    }
    
    // Test 3: The start and end points must be between some number of points of each other
    float tolerance = [[[UIApplication sharedApplication] keyWindow] bounds].size.width / 3.0f;
    if (distance(POINT(0), POINT(points.count - 1)) > tolerance)
    {
        if (SHOWDEBUG) NSLog(@"Start and end points too far apart. Fail.");
        return CGRectZero;
    }
    
    // Test 4: Count the distance traveled in degrees.
    CGRect circle = boundingRect(points);
    CGPoint center = GEORectGetCenter(circle);
    float distance = ABS(acos(dotproduct(pointWithOrigin(POINT(0), center), pointWithOrigin(POINT(1), center))));
    for (NSUInteger i = 1; i < (points.count - 1); i++)
        distance += ABS(acos(dotproduct(pointWithOrigin(POINT(i), center), pointWithOrigin(POINT(i+1), center))));
    
    float transitTolerance = distance - 2 * M_PI;
    
    if (transitTolerance < 0.0f) // fell short of 2 PI
    {
        if (transitTolerance < - (M_PI / 4.0f)) // 45 degrees or more
        {
            if (SHOWDEBUG) NSLog(@"Transit was too short, under 315 degrees");
            return CGRectZero;
        }
    }
    
    if (transitTolerance > M_PI) // additional 180 degrees
    {
        if (SHOWDEBUG) NSLog(@"Transit was too long, over 540 degrees");
        return CGRectZero;
    }
    
    return circle;
}


#pragma mark - CircleRecognizer

@interface kouqiCircleRecognizer ()
@property (nonatomic, strong) NSMutableArray *points;
@property (nonatomic, strong) NSDate *firstTouchDate;
@end

@implementation kouqiCircleRecognizer
-(void)reset
{
    [super reset];
    self.points = nil;
    self.firstTouchDate = nil;
    self.state = UIGestureRecognizerStatePossible;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (touches.count > 1) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    self.points = [NSMutableArray array];
    self.firstTouchDate = [NSDate date];
    UITouch *touch = [touches anyObject];
    [self.points addObject:[NSValue valueWithCGPoint:[touch locationInView:self.view]]];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    [self.points addObject:[NSValue valueWithCGPoint:[touch locationInView:self.view]]];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    BOOL detectionSucess = !CGRectEqualToRect(CGRectZero, testForCircle(self.points, self.firstTouchDate));
    if (detectionSucess) {
        self.state = UIGestureRecognizerStateRecognized;
    }else{
        self.state = UIGestureRecognizerStateFailed;
    }
}

@end
