//
//  kouqiGeometry.h
//  TestTest
//
//  Created by 程海峰 on 2016/12/16.
//  Copyright © 2016年 海峰. All rights reserved.
//
@import Foundation;
@import CoreGraphics;

BOOL floatEqual(CGFloat a, CGFloat b);
CGFloat degrees(CGFloat radians);
CGFloat radians(CGFloat degrees);

CGFloat dotproduct (CGPoint v1, CGPoint v2);
CGFloat distance (CGPoint p1, CGPoint p2);

CGFloat dx(CGPoint p1, CGPoint p2);
CGFloat dy(CGPoint p1, CGPoint p2);

NSInteger sign(CGFloat x);

CGPoint pointWithOrigin(CGPoint pt, CGPoint origin);

#define RECTSTRING(_aRect_)		NSStringFromCGRect(_aRect_)
#define POINTSTRING(_aPoint_)	NSStringFromCGPoint(_aPoint_)
#define SIZESTRING(_aSize_)		NSStringFromCGSize(_aSize_)

// Centering
CGPoint GEORectGetCenter(CGRect rect);
CGRect	GEORectAroundCenter(CGPoint center, float dx, float dy);
CGRect	GEORectCenteredInRect(CGRect rect, CGRect mainRect);
