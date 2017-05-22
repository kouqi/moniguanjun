//
//  CalculationGameTool.h
//  TestTest
//
//  Created by 程海峰 on 16/8/30.
//  Copyright © 2016年 海峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif
@interface CalculationGameTool : NSObject
+(NSMutableDictionary *) saiChengSaiGuoWithMdic:(NSMutableArray *) xiaozuArray;
+(NSMutableDictionary *) biSaiJieGuoWithCity:(NSString *) city1 andCity:(NSString *) city2;
+(NSMutableDictionary *) biSaiJieGuoWithCityDic:(NSMutableDictionary *) cityDic1 andCityDic:(NSMutableDictionary *) cityDic2;
+(NSMutableDictionary *) sasanduiJinruJuesaiWithMdic:(NSMutableArray *) xiaozuArray;
+(NSMutableArray *) fenzuArrayWithAllArray:(NSMutableArray *) allArray andArrayNumber:(NSInteger) number;
@end
