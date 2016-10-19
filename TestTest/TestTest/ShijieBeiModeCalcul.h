//
//  ShijieBeiModeCalcul.h
//  TestTest
//
//  Created by 程海峰 on 2016/10/18.
//  Copyright © 2016年 海峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif
@interface ShijieBeiModeCalcul : NSObject
+(NSMutableDictionary *) saiChengSaiGuoWithMdic:(NSMutableArray *) xiaozuArray;
+(NSMutableDictionary *) biSaiJieGuoWithCity:(NSString *) city1 andCity:(NSString *) city2;
+(NSMutableDictionary *) sasanduiJinruJuesaiWithMdic:(NSMutableArray *) xiaozuArray;
+(NSMutableArray *) fenzuArrayWithAllArray:(NSMutableArray *) allArray andArrayNumber:(NSInteger) number;
@end
