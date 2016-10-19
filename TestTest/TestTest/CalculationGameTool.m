//
//  CalculationGameTool.m
//  TestTest
//
//  Created by 程海峰 on 16/8/30.
//  Copyright © 2016年 海峰. All rights reserved.
//

#import "CalculationGameTool.h"

@implementation CalculationGameTool
+(NSMutableDictionary *) saiChengSaiGuoWithMdic:(NSMutableArray *) xiaozuArray{
    NSMutableArray *shengchuQiudui = [NSMutableArray array];
    NSMutableString *returnString = [NSMutableString string];
    NSString *fCity = [xiaozuArray objectAtIndex:0];
    NSString *sCity = [xiaozuArray objectAtIndex:1];
    NSString *tCity = [xiaozuArray objectAtIndex:2];
    NSString *foCity = [xiaozuArray objectAtIndex:3];
    NSInteger fjifen = 0,sjifen = 0,tjifen = 0,fojifen = 0;
    NSInteger fjingsheng = 0,sjingsheng = 0,tjingsheng = 0,fojingsheng = 0;
    NSInteger fjinqiushu = 0,sjinqiushu = 0,tjinqiushu = 0,fojinqiushu = 0;
    NSMutableString *fyingle = [NSMutableString string];
    NSMutableString *syingle = [NSMutableString string];
    NSMutableString *tyingle = [NSMutableString string];
    NSMutableString *foyingle = [NSMutableString string];
    NSLog(@"赛程赛果");
    [returnString appendFormat:@"赛程赛果\n\n"];
    NSLog(@"第一轮");
    [returnString appendFormat:@"第一轮\n"];
    //1v2
    NSMutableDictionary *dic12 = [self biSaiJieGuoWithCity:fCity andCity:sCity];
    NSArray *arr12 = [dic12 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic12 valueForKey:@"rString"]];
    switch ([[arr12 objectAtIndex:0] integerValue]) {
        case 0:
            fjifen += 3;
            [fyingle appendFormat:@"2"];
            break;
        case 1:
            fjifen += 1;
            sjifen += 1;
            break;
        case 2:
            sjifen += 3;
            [syingle appendFormat:@"1"];
            break;
            
        default:
            break;
    }
    fjinqiushu += [[arr12 objectAtIndex:1] integerValue];
    sjinqiushu += [[arr12 objectAtIndex:2] integerValue];
    fjingsheng += ([[arr12 objectAtIndex:1] integerValue] - [[arr12 objectAtIndex:2] integerValue]);
    sjingsheng += ([[arr12 objectAtIndex:2] integerValue] - [[arr12 objectAtIndex:1] integerValue]);
    //3v4
    NSMutableDictionary *dic34 = [self biSaiJieGuoWithCity:tCity andCity:foCity];
    NSArray *arr34 = [dic34 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic34 valueForKey:@"rString"]];
    switch ([[arr34 objectAtIndex:0] integerValue]) {
        case 0:
            tjifen += 3;
            [tyingle appendFormat:@"4"];
            break;
        case 1:
            tjifen += 1;
            fojifen += 1;
            break;
        case 2:
            fojifen += 3;
            [foyingle appendFormat:@"3"];
            break;
            
        default:
            break;
    }
    tjinqiushu += [[arr34 objectAtIndex:1] integerValue];
    fojinqiushu += [[arr34 objectAtIndex:2] integerValue];
    tjingsheng += ([[arr34 objectAtIndex:1] integerValue] - [[arr34 objectAtIndex:2] integerValue]);
    fojingsheng += ([[arr34 objectAtIndex:2] integerValue] - [[arr34 objectAtIndex:1] integerValue]);
    NSLog(@"\n第一轮积分排名");
    [returnString appendFormat:@"\n第一轮"];
    [returnString appendFormat:@"%@",[self jifenPaimingWithCity:fCity andCity:sCity andCity:tCity andCity:foCity andJifen:fjifen andJifen:sjifen andJifen:tjifen andJifen:fojifen andJinqiushu:fjinqiushu andJinqiushu:sjinqiushu andJinqiushu:tjinqiushu andJinqiushu:fojinqiushu andJingsheng:fjingsheng andJingsheng:sjingsheng andJingsheng:tjingsheng andJingsheng:fojingsheng andYingle:fyingle andYingle:syingle andYingle:tyingle andYingle:foyingle]];
    NSLog(@"第二轮");
    [returnString appendFormat:@"第二轮\n"];
    //4v1
    NSMutableDictionary *dic41 = [self biSaiJieGuoWithCity:foCity andCity:fCity];
    NSArray *arr41 = [dic41 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic41 valueForKey:@"rString"]];
    switch ([[arr41 objectAtIndex:0] integerValue]) {
        case 2:
            fjifen += 3;
            [fyingle appendFormat:@"4"];
            break;
        case 1:
            fjifen += 1;
            fojifen += 1;
            break;
        case 0:
            fojifen += 3;
            [foyingle appendFormat:@"1"];
            break;
            
        default:
            break;
    }
    fojinqiushu += [[arr41 objectAtIndex:1] integerValue];
    fjinqiushu += [[arr41 objectAtIndex:2] integerValue];
    fojingsheng += ([[arr41 objectAtIndex:1] integerValue] - [[arr41 objectAtIndex:2] integerValue]);
    fjingsheng += ([[arr41 objectAtIndex:2] integerValue] - [[arr41 objectAtIndex:1] integerValue]);
    //2v3
    NSMutableDictionary *dic23 = [self biSaiJieGuoWithCity:sCity andCity:tCity];
    NSArray *arr23 = [dic23 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic23 valueForKey:@"rString"]];
    switch ([[arr23 objectAtIndex:0] integerValue]) {
        case 0:
            sjifen += 3;
            [syingle appendFormat:@"3"];
            break;
        case 1:
            sjifen += 1;
            tjifen += 1;
            break;
        case 2:
            tjifen += 3;
            [tyingle appendFormat:@"2"];
            break;
            
        default:
            break;
    }
    sjinqiushu += [[arr23 objectAtIndex:1] integerValue];
    tjinqiushu += [[arr23 objectAtIndex:2] integerValue];
    sjingsheng += ([[arr23 objectAtIndex:1] integerValue] - [[arr23 objectAtIndex:2] integerValue]);
    tjingsheng += ([[arr23 objectAtIndex:2] integerValue] - [[arr23 objectAtIndex:1] integerValue]);
    NSLog(@"\n第二轮积分排名");
    [returnString appendFormat:@"\n第二轮"];
    [returnString appendFormat:@"%@",[self jifenPaimingWithCity:fCity andCity:sCity andCity:tCity andCity:foCity andJifen:fjifen andJifen:sjifen andJifen:tjifen andJifen:fojifen andJinqiushu:fjinqiushu andJinqiushu:sjinqiushu andJinqiushu:tjinqiushu andJinqiushu:fojinqiushu andJingsheng:fjingsheng andJingsheng:sjingsheng andJingsheng:tjingsheng andJingsheng:fojingsheng andYingle:fyingle andYingle:syingle andYingle:tyingle andYingle:foyingle]];
    NSLog(@"第三轮");
    [returnString appendFormat:@"第三轮\n"];
    //1v3
    NSMutableDictionary *dic13 = [self biSaiJieGuoWithCity:fCity andCity:tCity];
    NSArray *arr13 = [dic13 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic13 valueForKey:@"rString"]];
    switch ([[arr13 objectAtIndex:0] integerValue]) {
        case 0:
            fjifen += 3;
            [fyingle appendFormat:@"3"];
            break;
        case 1:
            fjifen += 1;
            tjifen += 1;
            break;
        case 2:
            tjifen += 3;
            [tyingle appendFormat:@"1"];
            break;
            
        default:
            break;
    }
    fjinqiushu += [[arr13 objectAtIndex:1] integerValue];
    tjinqiushu += [[arr13 objectAtIndex:2] integerValue];
    fjingsheng += ([[arr13 objectAtIndex:1] integerValue] - [[arr13 objectAtIndex:2] integerValue]);
    tjingsheng += ([[arr13 objectAtIndex:2] integerValue] - [[arr13 objectAtIndex:1] integerValue]);
    //2v4
    NSMutableDictionary *dic24 = [self biSaiJieGuoWithCity:sCity andCity:foCity];
    NSArray *arr24 = [dic24 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic24 valueForKey:@"rString"]];
    switch ([[arr24 objectAtIndex:0] integerValue]) {
        case 0:
            sjifen += 3;
            [syingle appendFormat:@"4"];
            break;
        case 1:
            sjifen += 1;
            fojifen += 1;
            break;
        case 2:
            fojifen += 3;
            [foyingle appendFormat:@"2"];
            break;
            
        default:
            break;
    }
    sjinqiushu += [[arr24 objectAtIndex:1] integerValue];
    fojinqiushu += [[arr24 objectAtIndex:2] integerValue];
    sjingsheng += ([[arr24 objectAtIndex:1] integerValue] - [[arr24 objectAtIndex:2] integerValue]);
    fojingsheng += ([[arr24 objectAtIndex:2] integerValue] - [[arr24 objectAtIndex:1] integerValue]);
    
    NSLog(@"\n第三轮积分排名");
    [returnString appendFormat:@"\n第三轮"];
    [returnString appendFormat:@"%@",[self jifenPaimingWithCity:fCity andCity:sCity andCity:tCity andCity:foCity andJifen:fjifen andJifen:sjifen andJifen:tjifen andJifen:fojifen andJinqiushu:fjinqiushu andJinqiushu:sjinqiushu andJinqiushu:tjinqiushu andJinqiushu:fojinqiushu andJingsheng:fjingsheng andJingsheng:sjingsheng andJingsheng:tjingsheng andJingsheng:fojingsheng andYingle:fyingle andYingle:syingle andYingle:tyingle andYingle:foyingle]];
    
    NSLog(@"第四轮轮");
    [returnString appendFormat:@"第四轮\n"];
    //3v1
    NSMutableDictionary *dic31 = [self biSaiJieGuoWithCity:tCity andCity:fCity];
    NSArray *arr31 = [dic31 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic31 valueForKey:@"rString"]];
    switch ([[arr31 objectAtIndex:0] integerValue]) {
        case 2:
            fjifen += 3;
            [fyingle appendFormat:@"3"];
            break;
        case 1:
            fjifen += 1;
            tjifen += 1;
            break;
        case 0:
            tjifen += 3;
            [tyingle appendFormat:@"1"];
            break;
            
        default:
            break;
    }
    tjinqiushu += [[arr31 objectAtIndex:1] integerValue];
    fjinqiushu += [[arr31 objectAtIndex:2] integerValue];
    tjingsheng += ([[arr31 objectAtIndex:1] integerValue] - [[arr31 objectAtIndex:2] integerValue]);
    fjingsheng += ([[arr31 objectAtIndex:2] integerValue] - [[arr31 objectAtIndex:1] integerValue]);
    //4v2
    NSMutableDictionary *dic42 = [self biSaiJieGuoWithCity:foCity andCity:sCity];
    NSArray *arr42 = [dic42 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic42 valueForKey:@"rString"]];
    switch ([[arr42 objectAtIndex:0] integerValue]) {
        case 2:
            sjifen += 3;
            [syingle appendFormat:@"4"];
            break;
        case 1:
            sjifen += 1;
            fojifen += 1;
            break;
        case 0:
            fojifen += 3;
            [foyingle appendFormat:@"2"];
            break;
            
        default:
            break;
    }
    fojinqiushu += [[arr42 objectAtIndex:1] integerValue];
    sjinqiushu += [[arr42 objectAtIndex:2] integerValue];
    fojingsheng += ([[arr42 objectAtIndex:1] integerValue] - [[arr42 objectAtIndex:2] integerValue]);
    sjingsheng += ([[arr42 objectAtIndex:2] integerValue] - [[arr42 objectAtIndex:1] integerValue]);
    
    NSLog(@"\n第四轮积分排名");
    [returnString appendFormat:@"\n第四轮"];
    [returnString appendFormat:@"%@",[self jifenPaimingWithCity:fCity andCity:sCity andCity:tCity andCity:foCity andJifen:fjifen andJifen:sjifen andJifen:tjifen andJifen:fojifen andJinqiushu:fjinqiushu andJinqiushu:sjinqiushu andJinqiushu:tjinqiushu andJinqiushu:fojinqiushu andJingsheng:fjingsheng andJingsheng:sjingsheng andJingsheng:tjingsheng andJingsheng:fojingsheng andYingle:fyingle andYingle:syingle andYingle:tyingle andYingle:foyingle]];
    NSLog(@"第五轮");
    [returnString appendFormat:@"第五轮\n"];
    //2v1
    NSMutableDictionary *dic21 = [self biSaiJieGuoWithCity:sCity andCity:fCity];
    NSArray *arr21 = [dic21 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic21 valueForKey:@"rString"]];
    switch ([[arr21 objectAtIndex:0] integerValue]) {
        case 2:
            fjifen += 3;
            [fyingle appendFormat:@"2"];
            break;
        case 1:
            fjifen += 1;
            sjifen += 1;
            break;
        case 0:
            sjifen += 3;
            [syingle appendFormat:@"1"];
            break;
            
        default:
            break;
    }
    sjinqiushu += [[arr21 objectAtIndex:1] integerValue];
    fjinqiushu += [[arr21 objectAtIndex:2] integerValue];
    sjingsheng += ([[arr21 objectAtIndex:1] integerValue] - [[arr21 objectAtIndex:2] integerValue]);
    fjingsheng += ([[arr21 objectAtIndex:2] integerValue] - [[arr21 objectAtIndex:1] integerValue]);
    //4v3
    NSMutableDictionary *dic43 = [self biSaiJieGuoWithCity:foCity andCity:tCity];
    NSArray *arr43 = [dic43 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic43 valueForKey:@"rString"]];
    switch ([[arr43 objectAtIndex:0] integerValue]) {
        case 2:
            tjifen += 3;
            [tyingle appendFormat:@"4"];
            break;
        case 1:
            tjifen += 1;
            fojifen += 1;
            break;
        case 0:
            fojifen += 3;
            [foyingle appendFormat:@"3"];
            break;
            
        default:
            break;
    }
    fojinqiushu += [[arr43 objectAtIndex:1] integerValue];
    tjinqiushu += [[arr43 objectAtIndex:2] integerValue];
    fojingsheng += ([[arr43 objectAtIndex:1] integerValue] - [[arr43 objectAtIndex:2] integerValue]);
    tjingsheng += ([[arr43 objectAtIndex:2] integerValue] - [[arr43 objectAtIndex:1] integerValue]);
    NSLog(@"\n第五轮积分排名");
    [returnString appendFormat:@"\n第五轮"];
    [returnString appendFormat:@"%@",[self jifenPaimingWithCity:fCity andCity:sCity andCity:tCity andCity:foCity andJifen:fjifen andJifen:sjifen andJifen:tjifen andJifen:fojifen andJinqiushu:fjinqiushu andJinqiushu:sjinqiushu andJinqiushu:tjinqiushu andJinqiushu:fojinqiushu andJingsheng:fjingsheng andJingsheng:sjingsheng andJingsheng:tjingsheng andJingsheng:fojingsheng andYingle:fyingle andYingle:syingle andYingle:tyingle andYingle:foyingle]];
    
    NSLog(@"第六轮");
    [returnString appendFormat:@"第六轮\n"];
    //3v2
    NSMutableDictionary *dic32 = [self biSaiJieGuoWithCity:tCity andCity:sCity];
    NSArray *arr32 = [dic32 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic32 valueForKey:@"rString"]];
    switch ([[arr32 objectAtIndex:0] integerValue]) {
        case 2:
            sjifen += 3;
            [syingle appendFormat:@"3"];
            break;
        case 1:
            sjifen += 1;
            tjifen += 1;
            break;
        case 0:
            tjifen += 3;
            [tyingle appendFormat:@"2"];
            break;
            
        default:
            break;
    }
    tjinqiushu += [[arr32 objectAtIndex:1] integerValue];
    sjinqiushu += [[arr32 objectAtIndex:2] integerValue];
    tjingsheng += ([[arr32 objectAtIndex:1] integerValue] - [[arr32 objectAtIndex:2] integerValue]);
    sjingsheng += ([[arr32 objectAtIndex:2] integerValue] - [[arr32 objectAtIndex:1] integerValue]);
    //1v4
    NSMutableDictionary *dic14 = [self biSaiJieGuoWithCity:fCity andCity:foCity];
    NSArray *arr14 = [dic14 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic14 valueForKey:@"rString"]];
    switch ([[arr14 objectAtIndex:0] integerValue]) {
        case 0:
            fjifen += 3;
            [fyingle appendFormat:@"4"];
            break;
        case 1:
            fjifen += 1;
            fojifen += 1;
            break;
        case 2:
            fojifen += 3;
            [foyingle appendFormat:@"1"];
            break;
            
        default:
            break;
    }
    fjinqiushu += [[arr14 objectAtIndex:1] integerValue];
    fojinqiushu += [[arr14 objectAtIndex:2] integerValue];
    fjingsheng += ([[arr14 objectAtIndex:1] integerValue] - [[arr14 objectAtIndex:2] integerValue]);
    fojingsheng += ([[arr14 objectAtIndex:2] integerValue] - [[arr14 objectAtIndex:1] integerValue]);
    
    //排序
    NSMutableArray *jieeA = [NSMutableArray array];
    NSMutableDictionary *d1 = [NSMutableDictionary dictionary];
    [d1 setValue:fCity forKey:@"city"];
    [d1 setValue:[NSNumber numberWithInteger:fjifen] forKey:@"jifen"];
    [d1 setValue:[NSNumber numberWithInteger:fjinqiushu] forKey:@"jinqiushu"];
    [d1 setValue:[NSNumber numberWithInteger:fjingsheng] forKey:@"jingsheng"];
    [d1 setValue:@"1" forKey:@"bianhao"];
    [d1 setValue:fyingle forKey:@"yingle"];
    [jieeA addObject:d1];
    NSMutableDictionary *d2 = [NSMutableDictionary dictionary];
    [d2 setValue:sCity forKey:@"city"];
    [d2 setValue:[NSNumber numberWithInteger:sjifen] forKey:@"jifen"];
    [d2 setValue:[NSNumber numberWithInteger:sjinqiushu] forKey:@"jinqiushu"];
    [d2 setValue:[NSNumber numberWithInteger:sjingsheng] forKey:@"jingsheng"];
    [d2 setValue:@"2" forKey:@"bianhao"];
    [d2 setValue:syingle forKey:@"yingle"];
    [jieeA addObject:d2];
    NSMutableDictionary *d3 = [NSMutableDictionary dictionary];
    [d3 setValue:tCity forKey:@"city"];
    [d3 setValue:[NSNumber numberWithInteger:tjifen] forKey:@"jifen"];
    [d3 setValue:[NSNumber numberWithInteger:tjinqiushu] forKey:@"jinqiushu"];
    [d3 setValue:[NSNumber numberWithInteger:tjingsheng] forKey:@"jingsheng"];
    [d3 setValue:@"3" forKey:@"bianhao"];
    [d3 setValue:tyingle forKey:@"yingle"];
    [jieeA addObject:d3];
    NSMutableDictionary *d4 = [NSMutableDictionary dictionary];
    [d4 setValue:foCity forKey:@"city"];
    [d4 setValue:[NSNumber numberWithInteger:fojifen] forKey:@"jifen"];
    [d4 setValue:[NSNumber numberWithInteger:fojinqiushu] forKey:@"jinqiushu"];
    [d4 setValue:[NSNumber numberWithInteger:fojingsheng] forKey:@"jingsheng"];
    [d4 setValue:@"4" forKey:@"bianhao"];
    [d4 setValue:foyingle forKey:@"yingle"];
    [jieeA addObject:d4];
    
    BOOL isSanduitongjifen = YES;
    NSMutableSet *sets = [NSMutableSet set];
    [sets addObject:[NSNumber numberWithInteger:fjifen]];
    [sets addObject:[NSNumber numberWithInteger:sjifen]];
    [sets addObject:[NSNumber numberWithInteger:tjifen]];
    [sets addObject:[NSNumber numberWithInteger:fojifen]];
    if (sets.count == 1) {
        isSanduitongjifen = YES;
    }else if (sets.count == 2){
        NSInteger jifengeshu = 0;
        NSNumber *setNumber = [sets anyObject];
        if ([setNumber isEqualToNumber:[NSNumber numberWithInteger:fjifen]]) {
            jifengeshu++;
        }
        if ([setNumber isEqualToNumber:[NSNumber numberWithInteger:sjifen]]) {
            jifengeshu++;
        }
        if ([setNumber isEqualToNumber:[NSNumber numberWithInteger:tjifen]]) {
            jifengeshu++;
        }
        if ([setNumber isEqualToNumber:[NSNumber numberWithInteger:fojifen]]) {
            jifengeshu++;
        }
        if (jifengeshu != 2) {
            isSanduitongjifen = YES;
        }
    }
    
    
    
    NSArray *arra = [jieeA sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDictionary *d1 = obj1;
        NSDictionary *d2 = obj2;
        NSInteger ji1 = [[d1 valueForKey:@"jifen"] integerValue];
        NSInteger ji2 = [[d2 valueForKey:@"jifen"] integerValue];
        NSComparisonResult result;
        if (ji1 > ji2) {
            result = NSOrderedAscending;
        }else{
            if (ji1 == ji2) {
                if (isSanduitongjifen) {
                    NSInteger jingsheng1 = [[d1 valueForKey:@"jingsheng"] integerValue];
                    NSInteger jingsheng2 = [[d2 valueForKey:@"jingsheng"] integerValue];
                    if (jingsheng1 > jingsheng2) {
                        result = NSOrderedAscending;
                    }else{
                        if (jingsheng1 == jingsheng2) {
                            NSInteger jinqiushu1 = [[d1 valueForKey:@"jinqiushu"] integerValue];
                            NSInteger jinqiushu2 = [[d2 valueForKey:@"jinqiushu"] integerValue];
                            if (jinqiushu1 > jinqiushu2) {
                                result = NSOrderedAscending;
                            }else{
                                result = NSOrderedDescending;
                            }
                        }else{
                            result = NSOrderedDescending;
                        }
                    }
                }else{
                    NSString* yingle1 = [d1 valueForKey:@"yingle"];
                    NSString* bianhao2 = [d2 valueForKey:@"bianhao"];
                    if ([yingle1 containsString:bianhao2]) {
                        result = NSOrderedAscending;
                    }else{
                        NSString* yingle2 = [d2 valueForKey:@"yingle"];
                        NSString* bianhao1 = [d1 valueForKey:@"bianhao"];
                        if ([yingle2 containsString:bianhao1]) {
                            result = NSOrderedDescending;
                        }else{
                            NSInteger jingsheng1 = [[d1 valueForKey:@"jingsheng"] integerValue];
                            NSInteger jingsheng2 = [[d2 valueForKey:@"jingsheng"] integerValue];
                            if (jingsheng1 > jingsheng2) {
                                result = NSOrderedAscending;
                            }else{
                                if (jingsheng1 == jingsheng2) {
                                    NSInteger jinqiushu1 = [[d1 valueForKey:@"jinqiushu"] integerValue];
                                    NSInteger jinqiushu2 = [[d2 valueForKey:@"jinqiushu"] integerValue];
                                    if (jinqiushu1 > jinqiushu2) {
                                        result = NSOrderedAscending;
                                    }else{
                                        result = NSOrderedDescending;
                                    }
                                }else{
                                    result = NSOrderedDescending;
                                }
                            }
                        }
                    }
                }
            }else{
                result = NSOrderedDescending;
            }
        }
        return result;
    }];
    
    [shengchuQiudui addObject:[[arra objectAtIndex:0] valueForKey:@"city"]];
    [shengchuQiudui addObject:[[arra objectAtIndex:1] valueForKey:@"city"]];
    NSLog(@"\n最终积分排名");
    [returnString appendFormat:@"\n最终积分排名\n"];
    for (int i = 0 ;i < arra.count; i++) {
        NSDictionary *d1 = [arra objectAtIndex:i];
        NSInteger diuqiu = [[d1 valueForKey:@"jinqiushu"] integerValue] - [[d1 valueForKey:@"jingsheng"] integerValue];
        NSLog(@"%@ 积%@分 净胜%@球 进%@球 丢%ld球",[d1 valueForKey:@"city"],[d1 valueForKey:@"jifen"],[d1 valueForKey:@"jingsheng"],[d1 valueForKey:@"jinqiushu"],diuqiu);
        [returnString appendFormat:@"%@ 积%@分 净胜%@球 进%@球 丢%ld球\n",[d1 valueForKey:@"city"],[d1 valueForKey:@"jifen"],[d1 valueForKey:@"jingsheng"],[d1 valueForKey:@"jinqiushu"],diuqiu];
    }
    NSLog(@"\n");
    [returnString appendFormat:@"\n"];
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    [mdic setValue:returnString forKey:@"returnString"];
    [mdic setValue:shengchuQiudui forKey:@"teamArray"];
    return mdic;
}

+(NSMutableString *) jifenPaimingWithCity:(NSString *)fCity andCity:(NSString *)sCity andCity:(NSString *)tCity andCity:(NSString *)foCity andJifen:(NSInteger)fjifen andJifen:(NSInteger)sjifen andJifen:(NSInteger)tjifen andJifen:(NSInteger)fojifen andJinqiushu:(NSInteger)fjinqiushu andJinqiushu:(NSInteger)sjinqiushu andJinqiushu:(NSInteger)tjinqiushu andJinqiushu:(NSInteger)fojinqiushu andJingsheng:(NSInteger)fjingsheng andJingsheng:(NSInteger)sjingsheng andJingsheng:(NSInteger)tjingsheng andJingsheng:(NSInteger)fojingsheng andYingle:(NSString *)fyingle andYingle:(NSString *)syingle andYingle:(NSString *)tyingle andYingle:(NSString *)foyingle{
    
    NSMutableString *returnString = [NSMutableString string];
    
    NSMutableArray *jieeA = [NSMutableArray array];
    NSMutableDictionary *d1 = [NSMutableDictionary dictionary];
    [d1 setValue:fCity forKey:@"city"];
    [d1 setValue:[NSNumber numberWithInteger:fjifen] forKey:@"jifen"];
    [d1 setValue:[NSNumber numberWithInteger:fjinqiushu] forKey:@"jinqiushu"];
    [d1 setValue:[NSNumber numberWithInteger:fjingsheng] forKey:@"jingsheng"];
    [d1 setValue:@"1" forKey:@"bianhao"];
    [d1 setValue:fyingle forKey:@"yingle"];
    [jieeA addObject:d1];
    NSMutableDictionary *d2 = [NSMutableDictionary dictionary];
    [d2 setValue:sCity forKey:@"city"];
    [d2 setValue:[NSNumber numberWithInteger:sjifen] forKey:@"jifen"];
    [d2 setValue:[NSNumber numberWithInteger:sjinqiushu] forKey:@"jinqiushu"];
    [d2 setValue:[NSNumber numberWithInteger:sjingsheng] forKey:@"jingsheng"];
    [d2 setValue:@"2" forKey:@"bianhao"];
    [d2 setValue:syingle forKey:@"yingle"];
    [jieeA addObject:d2];
    NSMutableDictionary *d3 = [NSMutableDictionary dictionary];
    [d3 setValue:tCity forKey:@"city"];
    [d3 setValue:[NSNumber numberWithInteger:tjifen] forKey:@"jifen"];
    [d3 setValue:[NSNumber numberWithInteger:tjinqiushu] forKey:@"jinqiushu"];
    [d3 setValue:[NSNumber numberWithInteger:tjingsheng] forKey:@"jingsheng"];
    [d3 setValue:@"3" forKey:@"bianhao"];
    [d3 setValue:tyingle forKey:@"yingle"];
    [jieeA addObject:d3];
    NSMutableDictionary *d4 = [NSMutableDictionary dictionary];
    [d4 setValue:foCity forKey:@"city"];
    [d4 setValue:[NSNumber numberWithInteger:fojifen] forKey:@"jifen"];
    [d4 setValue:[NSNumber numberWithInteger:fojinqiushu] forKey:@"jinqiushu"];
    [d4 setValue:[NSNumber numberWithInteger:fojingsheng] forKey:@"jingsheng"];
    [d4 setValue:@"4" forKey:@"bianhao"];
    [d4 setValue:foyingle forKey:@"yingle"];
    [jieeA addObject:d4];
    
    BOOL isSanduitongjifen = YES;
    NSMutableSet *sets = [NSMutableSet set];
    [sets addObject:[NSNumber numberWithInteger:fjifen]];
    [sets addObject:[NSNumber numberWithInteger:sjifen]];
    [sets addObject:[NSNumber numberWithInteger:tjifen]];
    [sets addObject:[NSNumber numberWithInteger:fojifen]];
    if (sets.count == 1) {
        isSanduitongjifen = YES;
    }else if (sets.count == 2){
        NSInteger jifengeshu = 0;
        NSNumber *setNumber = [sets anyObject];
        if ([setNumber isEqualToNumber:[NSNumber numberWithInteger:fjifen]]) {
            jifengeshu++;
        }
        if ([setNumber isEqualToNumber:[NSNumber numberWithInteger:sjifen]]) {
            jifengeshu++;
        }
        if ([setNumber isEqualToNumber:[NSNumber numberWithInteger:tjifen]]) {
            jifengeshu++;
        }
        if ([setNumber isEqualToNumber:[NSNumber numberWithInteger:fojifen]]) {
            jifengeshu++;
        }
        if (jifengeshu != 2) {
            isSanduitongjifen = YES;
        }
    }
    
    NSArray *arra = [jieeA sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDictionary *d1 = obj1;
        NSDictionary *d2 = obj2;
        NSInteger ji1 = [[d1 valueForKey:@"jifen"] integerValue];
        NSInteger ji2 = [[d2 valueForKey:@"jifen"] integerValue];
        NSComparisonResult result;
        if (ji1 > ji2) {
            result = NSOrderedAscending;
        }else{
            if (ji1 == ji2) {
                if (isSanduitongjifen) {
                    NSInteger jingsheng1 = [[d1 valueForKey:@"jingsheng"] integerValue];
                    NSInteger jingsheng2 = [[d2 valueForKey:@"jingsheng"] integerValue];
                    if (jingsheng1 > jingsheng2) {
                        result = NSOrderedAscending;
                    }else{
                        if (jingsheng1 == jingsheng2) {
                            NSInteger jinqiushu1 = [[d1 valueForKey:@"jinqiushu"] integerValue];
                            NSInteger jinqiushu2 = [[d2 valueForKey:@"jinqiushu"] integerValue];
                            if (jinqiushu1 > jinqiushu2) {
                                result = NSOrderedAscending;
                            }else{
                                result = NSOrderedDescending;
                            }
                        }else{
                            result = NSOrderedDescending;
                        }
                    }
                }else{
                    NSString* yingle1 = [d1 valueForKey:@"yingle"];
                    NSString* bianhao2 = [d2 valueForKey:@"bianhao"];
                    if ([yingle1 containsString:bianhao2]) {
                        result = NSOrderedAscending;
                    }else{
                        NSString* yingle2 = [d2 valueForKey:@"yingle"];
                        NSString* bianhao1 = [d1 valueForKey:@"bianhao"];
                        if ([yingle2 containsString:bianhao1]) {
                            result = NSOrderedDescending;
                        }else{
                            NSInteger jingsheng1 = [[d1 valueForKey:@"jingsheng"] integerValue];
                            NSInteger jingsheng2 = [[d2 valueForKey:@"jingsheng"] integerValue];
                            if (jingsheng1 > jingsheng2) {
                                result = NSOrderedAscending;
                            }else{
                                if (jingsheng1 == jingsheng2) {
                                    NSInteger jinqiushu1 = [[d1 valueForKey:@"jinqiushu"] integerValue];
                                    NSInteger jinqiushu2 = [[d2 valueForKey:@"jinqiushu"] integerValue];
                                    if (jinqiushu1 > jinqiushu2) {
                                        result = NSOrderedAscending;
                                    }else{
                                        result = NSOrderedDescending;
                                    }
                                }else{
                                    result = NSOrderedDescending;
                                }
                            }
                        }
                    }
                }
            }else{
                result = NSOrderedDescending;
            }
        }
        return result;
    }];
    [returnString appendFormat:@"积分排名\n"];
    for (int i = 0 ;i < arra.count; i++) {
        NSDictionary *d1 = [arra objectAtIndex:i];
        NSInteger diuqiu = [[d1 valueForKey:@"jinqiushu"] integerValue] - [[d1 valueForKey:@"jingsheng"] integerValue];
        NSLog(@"%@ 积%@分 净胜%@球 进%@球 丢%ld球",[d1 valueForKey:@"city"],[d1 valueForKey:@"jifen"],[d1 valueForKey:@"jingsheng"],[d1 valueForKey:@"jinqiushu"],diuqiu);
        [returnString appendFormat:@"%@ 积%@分 净胜%@球 进%@球 丢%ld球\n",[d1 valueForKey:@"city"],[d1 valueForKey:@"jifen"],[d1 valueForKey:@"jingsheng"],[d1 valueForKey:@"jinqiushu"],diuqiu];
    }
    NSLog(@"\n");
    [returnString appendFormat:@"\n"];
    return returnString;
}

+(NSMutableString *) sanduijifenPaimingWithCity:(NSString *)fCity andCity:(NSString *)sCity andCity:(NSString *)tCity andJifen:(NSInteger)fjifen andJifen:(NSInteger)sjifen andJifen:(NSInteger)tjifen andJinqiushu:(NSInteger)fjinqiushu andJinqiushu:(NSInteger)sjinqiushu andJinqiushu:(NSInteger)tjinqiushu andJingsheng:(NSInteger)fjingsheng andJingsheng:(NSInteger)sjingsheng andJingsheng:(NSInteger)tjingsheng andYingle:(NSString *)fyingle andYingle:(NSString *)syingle andYingle:(NSString *)tyingle{
    
    NSMutableString *returnString = [NSMutableString string];
    
    NSMutableArray *jieeA = [NSMutableArray array];
    NSMutableDictionary *d1 = [NSMutableDictionary dictionary];
    [d1 setValue:fCity forKey:@"city"];
    [d1 setValue:[NSNumber numberWithInteger:fjifen] forKey:@"jifen"];
    [d1 setValue:[NSNumber numberWithInteger:fjinqiushu] forKey:@"jinqiushu"];
    [d1 setValue:[NSNumber numberWithInteger:fjingsheng] forKey:@"jingsheng"];
    [d1 setValue:@"1" forKey:@"bianhao"];
    [d1 setValue:fyingle forKey:@"yingle"];
    [jieeA addObject:d1];
    NSMutableDictionary *d2 = [NSMutableDictionary dictionary];
    [d2 setValue:sCity forKey:@"city"];
    [d2 setValue:[NSNumber numberWithInteger:sjifen] forKey:@"jifen"];
    [d2 setValue:[NSNumber numberWithInteger:sjinqiushu] forKey:@"jinqiushu"];
    [d2 setValue:[NSNumber numberWithInteger:sjingsheng] forKey:@"jingsheng"];
    [d2 setValue:@"2" forKey:@"bianhao"];
    [d2 setValue:syingle forKey:@"yingle"];
    [jieeA addObject:d2];
    NSMutableDictionary *d3 = [NSMutableDictionary dictionary];
    [d3 setValue:tCity forKey:@"city"];
    [d3 setValue:[NSNumber numberWithInteger:tjifen] forKey:@"jifen"];
    [d3 setValue:[NSNumber numberWithInteger:tjinqiushu] forKey:@"jinqiushu"];
    [d3 setValue:[NSNumber numberWithInteger:tjingsheng] forKey:@"jingsheng"];
    [d3 setValue:@"3" forKey:@"bianhao"];
    [d3 setValue:tyingle forKey:@"yingle"];
    [jieeA addObject:d3];
    
    BOOL isSanduitongjifen = YES;
    NSMutableSet *sets = [NSMutableSet set];
    [sets addObject:[NSNumber numberWithInteger:fjifen]];
    [sets addObject:[NSNumber numberWithInteger:sjifen]];
    [sets addObject:[NSNumber numberWithInteger:tjifen]];
    if (sets.count == 1) {
        isSanduitongjifen = YES;
    }else if (sets.count == 2){
        NSInteger jifengeshu = 0;
        NSNumber *setNumber = [sets anyObject];
        if ([setNumber isEqualToNumber:[NSNumber numberWithInteger:fjifen]]) {
            jifengeshu++;
        }
        if ([setNumber isEqualToNumber:[NSNumber numberWithInteger:sjifen]]) {
            jifengeshu++;
        }
        if ([setNumber isEqualToNumber:[NSNumber numberWithInteger:tjifen]]) {
            jifengeshu++;
        }
        if (jifengeshu != 2) {
            isSanduitongjifen = YES;
        }
    }
    
    NSArray *arra = [jieeA sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDictionary *d1 = obj1;
        NSDictionary *d2 = obj2;
        NSInteger ji1 = [[d1 valueForKey:@"jifen"] integerValue];
        NSInteger ji2 = [[d2 valueForKey:@"jifen"] integerValue];
        NSComparisonResult result;
        if (ji1 > ji2) {
            result = NSOrderedAscending;
        }else{
            if (ji1 == ji2) {
                if (isSanduitongjifen) {
                    NSInteger jingsheng1 = [[d1 valueForKey:@"jingsheng"] integerValue];
                    NSInteger jingsheng2 = [[d2 valueForKey:@"jingsheng"] integerValue];
                    if (jingsheng1 > jingsheng2) {
                        result = NSOrderedAscending;
                    }else{
                        if (jingsheng1 == jingsheng2) {
                            NSInteger jinqiushu1 = [[d1 valueForKey:@"jinqiushu"] integerValue];
                            NSInteger jinqiushu2 = [[d2 valueForKey:@"jinqiushu"] integerValue];
                            if (jinqiushu1 > jinqiushu2) {
                                result = NSOrderedAscending;
                            }else{
                                result = NSOrderedDescending;
                            }
                        }else{
                            result = NSOrderedDescending;
                        }
                    }
                }else{
                    NSString* yingle1 = [d1 valueForKey:@"yingle"];
                    NSString* bianhao2 = [d2 valueForKey:@"bianhao"];
                    if ([yingle1 containsString:bianhao2]) {
                        result = NSOrderedAscending;
                    }else{
                        NSString* yingle2 = [d2 valueForKey:@"yingle"];
                        NSString* bianhao1 = [d1 valueForKey:@"bianhao"];
                        if ([yingle2 containsString:bianhao1]) {
                            result = NSOrderedDescending;
                        }else{
                            NSInteger jingsheng1 = [[d1 valueForKey:@"jingsheng"] integerValue];
                            NSInteger jingsheng2 = [[d2 valueForKey:@"jingsheng"] integerValue];
                            if (jingsheng1 > jingsheng2) {
                                result = NSOrderedAscending;
                            }else{
                                if (jingsheng1 == jingsheng2) {
                                    NSInteger jinqiushu1 = [[d1 valueForKey:@"jinqiushu"] integerValue];
                                    NSInteger jinqiushu2 = [[d2 valueForKey:@"jinqiushu"] integerValue];
                                    if (jinqiushu1 > jinqiushu2) {
                                        result = NSOrderedAscending;
                                    }else{
                                        result = NSOrderedDescending;
                                    }
                                }else{
                                    result = NSOrderedDescending;
                                }
                            }
                        }
                    }
                }
            }else{
                result = NSOrderedDescending;
            }
        }
        return result;
    }];
    [returnString appendFormat:@"积分排名\n"];
    for (int i = 0 ;i < arra.count; i++) {
        NSDictionary *d1 = [arra objectAtIndex:i];
        NSInteger diuqiu = [[d1 valueForKey:@"jinqiushu"] integerValue] - [[d1 valueForKey:@"jingsheng"] integerValue];
        NSLog(@"%@ 积%@分 净胜%@球 进%@球 丢%ld球",[d1 valueForKey:@"city"],[d1 valueForKey:@"jifen"],[d1 valueForKey:@"jingsheng"],[d1 valueForKey:@"jinqiushu"],diuqiu);
        [returnString appendFormat:@"%@ 积%@分 净胜%@球 进%@球 丢%ld球\n",[d1 valueForKey:@"city"],[d1 valueForKey:@"jifen"],[d1 valueForKey:@"jingsheng"],[d1 valueForKey:@"jinqiushu"],diuqiu];
    }
    NSLog(@"\n");
    [returnString appendFormat:@"\n"];
    return returnString;
}


+(NSMutableDictionary *) sasanduiJinruJuesaiWithMdic:(NSMutableArray *) xiaozuArray{
    NSMutableArray *shengchuQiudui = [NSMutableArray array];
    NSMutableString *returnString = [NSMutableString string];
    NSString *fCity = [xiaozuArray objectAtIndex:0];
    NSString *sCity = [xiaozuArray objectAtIndex:1];
    NSString *tCity = [xiaozuArray objectAtIndex:2];
    NSInteger fjifen = 0,sjifen = 0,tjifen = 0;
    NSInteger fjingsheng = 0,sjingsheng = 0,tjingsheng = 0;
    NSInteger fjinqiushu = 0,sjinqiushu = 0,tjinqiushu = 0;
    NSMutableString *fyingle = [NSMutableString string];
    NSMutableString *syingle = [NSMutableString string];
    NSMutableString *tyingle = [NSMutableString string];
    NSLog(@"赛程赛果");
    [returnString appendFormat:@"进入决赛的队伍：\n%@ %@ %@\n",fCity,sCity,tCity];
    [returnString appendFormat:@"赛程赛果\n\n"];
    NSLog(@"第一轮");
    [returnString appendFormat:@"第一轮\n"];
    //1v2
    NSMutableDictionary *dic12 = [self biSaiJieGuoWithCity:fCity andCity:sCity];
    NSArray *arr12 = [dic12 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic12 valueForKey:@"rString"]];
    switch ([[arr12 objectAtIndex:0] integerValue]) {
        case 0:
            fjifen += 3;
            [fyingle appendFormat:@"2"];
            break;
        case 1:
            fjifen += 1;
            sjifen += 1;
            break;
        case 2:
            sjifen += 3;
            [syingle appendFormat:@"1"];
            break;
            
        default:
            break;
    }
    fjinqiushu += [[arr12 objectAtIndex:1] integerValue];
    sjinqiushu += [[arr12 objectAtIndex:2] integerValue];
    fjingsheng += ([[arr12 objectAtIndex:1] integerValue] - [[arr12 objectAtIndex:2] integerValue]);
    sjingsheng += ([[arr12 objectAtIndex:2] integerValue] - [[arr12 objectAtIndex:1] integerValue]);
    //3v1
    NSMutableDictionary *dic31 = [self biSaiJieGuoWithCity:tCity andCity:fCity];
    NSArray *arr31 = [dic31 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic31 valueForKey:@"rString"]];
    switch ([[arr31 objectAtIndex:0] integerValue]) {
        case 2:
            fjifen += 3;
            [fyingle appendFormat:@"3"];
            break;
        case 1:
            fjifen += 1;
            tjifen += 1;
            break;
        case 0:
            tjifen += 3;
            [tyingle appendFormat:@"1"];
            break;
            
        default:
            break;
    }
    tjinqiushu += [[arr31 objectAtIndex:1] integerValue];
    fjinqiushu += [[arr31 objectAtIndex:2] integerValue];
    tjingsheng += ([[arr31 objectAtIndex:1] integerValue] - [[arr31 objectAtIndex:2] integerValue]);
    fjingsheng += ([[arr31 objectAtIndex:2] integerValue] - [[arr31 objectAtIndex:1] integerValue]);
    //2v3
    NSMutableDictionary *dic23 = [self biSaiJieGuoWithCity:sCity andCity:tCity];
    NSArray *arr23 = [dic23 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic23 valueForKey:@"rString"]];
    switch ([[arr23 objectAtIndex:0] integerValue]) {
        case 0:
            sjifen += 3;
            [syingle appendFormat:@"3"];
            break;
        case 1:
            sjifen += 1;
            tjifen += 1;
            break;
        case 2:
            tjifen += 3;
            [tyingle appendFormat:@"2"];
            break;
            
        default:
            break;
    }
    sjinqiushu += [[arr23 objectAtIndex:1] integerValue];
    tjinqiushu += [[arr23 objectAtIndex:2] integerValue];
    sjingsheng += ([[arr23 objectAtIndex:1] integerValue] - [[arr23 objectAtIndex:2] integerValue]);
    tjingsheng += ([[arr23 objectAtIndex:2] integerValue] - [[arr23 objectAtIndex:1] integerValue]);
    NSLog(@"\n第一轮积分排名");
    [returnString appendFormat:@"\n第一轮"];
    [returnString appendFormat:@"%@",[self sanduijifenPaimingWithCity:fCity andCity:sCity andCity:tCity  andJifen:fjifen andJifen:sjifen andJifen:tjifen andJinqiushu:fjinqiushu andJinqiushu:sjinqiushu andJinqiushu:tjinqiushu andJingsheng:fjingsheng andJingsheng:sjingsheng andJingsheng:tjingsheng andYingle:fyingle andYingle:syingle andYingle:tyingle]];
    NSLog(@"第二轮");
    [returnString appendFormat:@"第二轮\n"];
    //1v3
    NSMutableDictionary *dic13 = [self biSaiJieGuoWithCity:fCity andCity:tCity];
    NSArray *arr13 = [dic13 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic13 valueForKey:@"rString"]];
    switch ([[arr13 objectAtIndex:0] integerValue]) {
        case 0:
            fjifen += 3;
            [fyingle appendFormat:@"3"];
            break;
        case 1:
            fjifen += 1;
            tjifen += 1;
            break;
        case 2:
            tjifen += 3;
            [tyingle appendFormat:@"1"];
            break;
            
        default:
            break;
    }
    fjinqiushu += [[arr13 objectAtIndex:1] integerValue];
    tjinqiushu += [[arr13 objectAtIndex:2] integerValue];
    fjingsheng += ([[arr13 objectAtIndex:1] integerValue] - [[arr13 objectAtIndex:2] integerValue]);
    tjingsheng += ([[arr13 objectAtIndex:2] integerValue] - [[arr13 objectAtIndex:1] integerValue]);
    //3v2
    NSMutableDictionary *dic32 = [self biSaiJieGuoWithCity:tCity andCity:sCity];
    NSArray *arr32 = [dic32 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic32 valueForKey:@"rString"]];
    switch ([[arr32 objectAtIndex:0] integerValue]) {
        case 2:
            sjifen += 3;
            [syingle appendFormat:@"3"];
            break;
        case 1:
            sjifen += 1;
            tjifen += 1;
            break;
        case 0:
            tjifen += 3;
            [tyingle appendFormat:@"2"];
            break;
            
        default:
            break;
    }
    tjinqiushu += [[arr32 objectAtIndex:1] integerValue];
    sjinqiushu += [[arr32 objectAtIndex:2] integerValue];
    tjingsheng += ([[arr32 objectAtIndex:1] integerValue] - [[arr32 objectAtIndex:2] integerValue]);
    sjingsheng += ([[arr32 objectAtIndex:2] integerValue] - [[arr32 objectAtIndex:1] integerValue]);
    //2v1
    NSMutableDictionary *dic21 = [self biSaiJieGuoWithCity:sCity andCity:fCity];
    NSArray *arr21 = [dic21 valueForKey:@"typeArray"];
    [returnString appendFormat:@"%@",[dic21 valueForKey:@"rString"]];
    switch ([[arr21 objectAtIndex:0] integerValue]) {
        case 2:
            fjifen += 3;
            [fyingle appendFormat:@"2"];
            break;
        case 1:
            fjifen += 1;
            sjifen += 1;
            break;
        case 0:
            sjifen += 3;
            [syingle appendFormat:@"1"];
            break;
            
        default:
            break;
    }
    sjinqiushu += [[arr21 objectAtIndex:1] integerValue];
    fjinqiushu += [[arr21 objectAtIndex:2] integerValue];
    sjingsheng += ([[arr21 objectAtIndex:1] integerValue] - [[arr21 objectAtIndex:2] integerValue]);
    fjingsheng += ([[arr21 objectAtIndex:2] integerValue] - [[arr21 objectAtIndex:1] integerValue]);
    
    
    //排序
    NSMutableArray *jieeA = [NSMutableArray array];
    NSMutableDictionary *d1 = [NSMutableDictionary dictionary];
    [d1 setValue:fCity forKey:@"city"];
    [d1 setValue:[NSNumber numberWithInteger:fjifen] forKey:@"jifen"];
    [d1 setValue:[NSNumber numberWithInteger:fjinqiushu] forKey:@"jinqiushu"];
    [d1 setValue:[NSNumber numberWithInteger:fjingsheng] forKey:@"jingsheng"];
    [d1 setValue:@"1" forKey:@"bianhao"];
    [d1 setValue:fyingle forKey:@"yingle"];
    [jieeA addObject:d1];
    NSMutableDictionary *d2 = [NSMutableDictionary dictionary];
    [d2 setValue:sCity forKey:@"city"];
    [d2 setValue:[NSNumber numberWithInteger:sjifen] forKey:@"jifen"];
    [d2 setValue:[NSNumber numberWithInteger:sjinqiushu] forKey:@"jinqiushu"];
    [d2 setValue:[NSNumber numberWithInteger:sjingsheng] forKey:@"jingsheng"];
    [d2 setValue:@"2" forKey:@"bianhao"];
    [d2 setValue:syingle forKey:@"yingle"];
    [jieeA addObject:d2];
    NSMutableDictionary *d3 = [NSMutableDictionary dictionary];
    [d3 setValue:tCity forKey:@"city"];
    [d3 setValue:[NSNumber numberWithInteger:tjifen] forKey:@"jifen"];
    [d3 setValue:[NSNumber numberWithInteger:tjinqiushu] forKey:@"jinqiushu"];
    [d3 setValue:[NSNumber numberWithInteger:tjingsheng] forKey:@"jingsheng"];
    [d3 setValue:@"3" forKey:@"bianhao"];
    [d3 setValue:tyingle forKey:@"yingle"];
    [jieeA addObject:d3];
    
    BOOL isSanduitongjifen = YES;
    NSMutableSet *sets = [NSMutableSet set];
    [sets addObject:[NSNumber numberWithInteger:fjifen]];
    [sets addObject:[NSNumber numberWithInteger:sjifen]];
    [sets addObject:[NSNumber numberWithInteger:tjifen]];
    if (sets.count == 1) {
        isSanduitongjifen = YES;
    }else if (sets.count == 2){
        NSInteger jifengeshu = 0;
        NSNumber *setNumber = [sets anyObject];
        if ([setNumber isEqualToNumber:[NSNumber numberWithInteger:fjifen]]) {
            jifengeshu++;
        }
        if ([setNumber isEqualToNumber:[NSNumber numberWithInteger:sjifen]]) {
            jifengeshu++;
        }
        if ([setNumber isEqualToNumber:[NSNumber numberWithInteger:tjifen]]) {
            jifengeshu++;
        }
        if (jifengeshu != 2) {
            isSanduitongjifen = YES;
        }
    }
    
    NSArray *arra = [jieeA sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDictionary *d1 = obj1;
        NSDictionary *d2 = obj2;
        NSInteger ji1 = [[d1 valueForKey:@"jifen"] integerValue];
        NSInteger ji2 = [[d2 valueForKey:@"jifen"] integerValue];
        NSComparisonResult result;
        if (ji1 > ji2) {
            result = NSOrderedAscending;
        }else{
            if (ji1 == ji2) {
                if (isSanduitongjifen) {
                    NSInteger jingsheng1 = [[d1 valueForKey:@"jingsheng"] integerValue];
                    NSInteger jingsheng2 = [[d2 valueForKey:@"jingsheng"] integerValue];
                    if (jingsheng1 > jingsheng2) {
                        result = NSOrderedAscending;
                    }else{
                        if (jingsheng1 == jingsheng2) {
                            NSInteger jinqiushu1 = [[d1 valueForKey:@"jinqiushu"] integerValue];
                            NSInteger jinqiushu2 = [[d2 valueForKey:@"jinqiushu"] integerValue];
                            if (jinqiushu1 > jinqiushu2) {
                                result = NSOrderedAscending;
                            }else{
                                result = NSOrderedDescending;
                            }
                        }else{
                            result = NSOrderedDescending;
                        }
                    }
                }else{
                    NSString* yingle1 = [d1 valueForKey:@"yingle"];
                    NSString* bianhao2 = [d2 valueForKey:@"bianhao"];
                    if ([yingle1 containsString:bianhao2]) {
                        result = NSOrderedAscending;
                    }else{
                        NSString* yingle2 = [d2 valueForKey:@"yingle"];
                        NSString* bianhao1 = [d1 valueForKey:@"bianhao"];
                        if ([yingle2 containsString:bianhao1]) {
                            result = NSOrderedDescending;
                        }else{
                            NSInteger jingsheng1 = [[d1 valueForKey:@"jingsheng"] integerValue];
                            NSInteger jingsheng2 = [[d2 valueForKey:@"jingsheng"] integerValue];
                            if (jingsheng1 > jingsheng2) {
                                result = NSOrderedAscending;
                            }else{
                                if (jingsheng1 == jingsheng2) {
                                    NSInteger jinqiushu1 = [[d1 valueForKey:@"jinqiushu"] integerValue];
                                    NSInteger jinqiushu2 = [[d2 valueForKey:@"jinqiushu"] integerValue];
                                    if (jinqiushu1 > jinqiushu2) {
                                        result = NSOrderedAscending;
                                    }else{
                                        result = NSOrderedDescending;
                                    }
                                }else{
                                    result = NSOrderedDescending;
                                }
                            }
                        }
                    }
                }
            }else{
                result = NSOrderedDescending;
            }
        }
        return result;
    }];
    
    [shengchuQiudui addObject:[[arra objectAtIndex:0] valueForKey:@"city"]];
    [shengchuQiudui addObject:[[arra objectAtIndex:1] valueForKey:@"city"]];
    [shengchuQiudui addObject:[[arra objectAtIndex:2] valueForKey:@"city"]];
    NSLog(@"\n最终积分排名");
    [returnString appendFormat:@"\n最终积分排名\n"];
    for (int i = 0 ;i < arra.count; i++) {
        NSDictionary *d1 = [arra objectAtIndex:i];
        NSInteger diuqiu = [[d1 valueForKey:@"jinqiushu"] integerValue] - [[d1 valueForKey:@"jingsheng"] integerValue];
        NSLog(@"%@ 积%@分 净胜%@球 进%@球 丢%ld球",[d1 valueForKey:@"city"],[d1 valueForKey:@"jifen"],[d1 valueForKey:@"jingsheng"],[d1 valueForKey:@"jinqiushu"],diuqiu);
        [returnString appendFormat:@"%@ 积%@分 净胜%@球 进%@球 丢%ld球\n",[d1 valueForKey:@"city"],[d1 valueForKey:@"jifen"],[d1 valueForKey:@"jingsheng"],[d1 valueForKey:@"jinqiushu"],diuqiu];
    }
    NSLog(@"\n");
    [returnString appendFormat:@"\n"];
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    [mdic setValue:returnString forKey:@"returnString"];
    [mdic setValue:shengchuQiudui forKey:@"teamArray"];
    return mdic;
}

+(NSMutableDictionary *) biSaiJieGuoWithCity:(NSString *) city1 andCity:(NSString *) city2{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    NSInteger jieguoType;
    NSInteger c1Number = arc4random() % 5;
    NSInteger c2Number = arc4random() % 4;
    if (c1Number > c2Number) {
        jieguoType = 0;
    }else{
        if (c1Number < c2Number) {
            jieguoType = 2;
        }else{
            jieguoType = 1;
        }
    }
    NSLog(@"%@ %ld-%ld %@",city1,(long)c1Number,(long)c2Number,city2);
    NSMutableString *returnString = [NSMutableString string];
    [returnString appendFormat:@"%@ %ld-%ld %@\n",city1,(long)c1Number,(long)c2Number,city2];
    NSArray *arr = [NSArray arrayWithObjects:[NSNumber numberWithInteger:jieguoType],[NSNumber numberWithInteger:c1Number],[NSNumber numberWithInteger:c2Number], nil];
    [mdic setValue:returnString forKey:@"rString"];
    [mdic setValue:arr forKey:@"typeArray"];
    return mdic;
}

+(NSMutableArray *) fenzuArrayWithAllArray:(NSMutableArray *) allArray andArrayNumber:(NSInteger) number
{
    NSMutableArray *returnArray = [NSMutableArray array];
    if (allArray.count < number) {
        [returnArray addObject:allArray];
        return returnArray;
    }
    NSMutableArray *chouArray = [NSMutableArray arrayWithArray:allArray];
    NSInteger yushu = allArray.count % number;
    NSInteger zushu = allArray.count / number;
    NSInteger fnumber = 0;
    if (yushu > (number / 2)) {
        fnumber = yushu;
    }else{
        fnumber = number + yushu;
        zushu--;
    }
    NSMutableArray *farray = [NSMutableArray array];
    for (int i = 0; i < fnumber; i++) {
        NSInteger index = arc4random() % chouArray.count;
        [farray addObject:[chouArray objectAtIndex:index]];
        [chouArray removeObjectAtIndex:index];
    }
    
    
    [returnArray addObject:farray];
    for (int i = 0; i < zushu; i++) {
        NSMutableArray *aarray = [NSMutableArray array];
        for (int i = 0; i < number; i++) {
            NSInteger index = arc4random() % chouArray.count;
            [aarray addObject:[chouArray objectAtIndex:index]];
            [chouArray removeObjectAtIndex:index];
        }
        [returnArray addObject:aarray];
    }
    return returnArray;
}

@end
