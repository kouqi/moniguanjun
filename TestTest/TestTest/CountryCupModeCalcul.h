//
//  CountryCupModeCalcul.h
//  TestTest
//
//  Created by 程海峰 on 2017/3/1.
//  Copyright © 2017年 海峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif
@interface CountryCupModeCalcul : NSObject
+(NSMutableDictionary *) saiChengSaiGuoWithMdic:(NSMutableArray *) xiaozuArray;
+(NSMutableDictionary *) biSaiJieGuoWithCity:(NSDictionary *) city1 andCity:(NSDictionary *) city2;
+(NSMutableDictionary *) sasanduiJinruJuesaiWithMdic:(NSMutableArray *) xiaozuArray;
+(NSMutableArray *) fenzuArrayWithAllArray:(NSMutableArray *) allArray andArrayNumber:(NSInteger) number;
+(NSMutableArray *) lianSaiRiCheng:(NSMutableArray *) cansaiArray;
@end
