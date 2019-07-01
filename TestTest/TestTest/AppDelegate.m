//
//  AppDelegate.m
//  TestTest
//
//  Created by 海峰 on 15/9/7.
//  Copyright (c) 2015年 海峰. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (assign, nonatomic) NSInteger jieshu,qiwangjieshu,siqiangcishu,juesaicishu,jieduanshu,yiyuxuansaicishu;
@property (strong, nonatomic) NSMutableArray *huodeGuanjunshuArray;
@property (strong, nonatomic) NSString *qiwangcity;
@end

@implementation AppDelegate


-(void) chouYuxuanWithArray:(NSMutableArray *) allQiuduiArray andjieduan:(NSInteger) jieduan
{
    NSMutableArray *allFuDuiArray = [NSMutableArray arrayWithArray:allQiuduiArray];
    switch (allQiuduiArray.count % 4 ) {
        case 0:
        {
            [self chouqianFenzuWithArray:allQiuduiArray];
        }
            break;
        case 1:
        {
            NSInteger index = arc4random() % allFuDuiArray.count;
            NSString *dio = [allFuDuiArray objectAtIndex:index];
            [allFuDuiArray removeObjectAtIndex:index];
            
            NSInteger indext = arc4random() % allFuDuiArray.count;
            NSString *dit = [allFuDuiArray objectAtIndex:indext];
            [allFuDuiArray removeObjectAtIndex:indext];
            NSLog(@"第%ld阶段预选赛对阵：%@ VS %@",jieduan,dio,dit);
            NSMutableArray *shengyiArray = [NSMutableArray arrayWithArray:@[dio,dit]];
            if (jieduan == 1 && [shengyiArray containsObject:self.qiwangcity]) {
                self.yiyuxuansaicishu++;
            }
            NSInteger indexs1 = arc4random() % shengyiArray.count;
            [allFuDuiArray addObject:[shengyiArray objectAtIndex:indexs1]];
            [shengyiArray removeObjectAtIndex:indexs1];
            
            [self chouqianFenzuWithArray:allFuDuiArray];
        }
            break;
        case 2:
        {
            NSInteger index = arc4random() % allFuDuiArray.count;
            NSString *dio = [allFuDuiArray objectAtIndex:index];
            [allFuDuiArray removeObjectAtIndex:index];
            
            NSInteger indext = arc4random() % allFuDuiArray.count;
            NSString *dit = [allFuDuiArray objectAtIndex:indext];
            [allFuDuiArray removeObjectAtIndex:indext];
            
            NSInteger indexth = arc4random() % allFuDuiArray.count;
            NSString *dith = [allFuDuiArray objectAtIndex:indexth];
            [allFuDuiArray removeObjectAtIndex:indexth];
            
            NSInteger indexf = arc4random() % allFuDuiArray.count;
            NSString *dif = [allFuDuiArray objectAtIndex:indexf];
            [allFuDuiArray removeObjectAtIndex:indexf];
            NSLog(@"第%ld阶段预选赛小组：%@ %@ %@ %@",jieduan,dio,dit,dith,dif);
            
            NSMutableArray *shengyiArray = [NSMutableArray arrayWithArray:@[dio,dit,dith,dif]];
            if (jieduan == 1 && [shengyiArray containsObject:self.qiwangcity]) {
                self.yiyuxuansaicishu++;
            }
            NSInteger indexs1 = arc4random() % shengyiArray.count;
            [allFuDuiArray addObject:[shengyiArray objectAtIndex:indexs1]];
            [shengyiArray removeObjectAtIndex:indexs1];
            
            NSInteger indexs2 = arc4random() % shengyiArray.count;
            [allFuDuiArray addObject:[shengyiArray objectAtIndex:indexs2]];
            [shengyiArray removeObjectAtIndex:indexs2];
            
            [self chouqianFenzuWithArray:allFuDuiArray];
        }
            break;
        case 3:
        {
            NSInteger index = arc4random() % allFuDuiArray.count;
            NSString *dio = [allFuDuiArray objectAtIndex:index];
            [allFuDuiArray removeObjectAtIndex:index];
            
            NSInteger indext = arc4random() % allFuDuiArray.count;
            NSString *dit = [allFuDuiArray objectAtIndex:indext];
            [allFuDuiArray removeObjectAtIndex:indext];
            
            NSInteger indexth = arc4random() % allFuDuiArray.count;
            NSString *dith = [allFuDuiArray objectAtIndex:indexth];
            [allFuDuiArray removeObjectAtIndex:indexth];
            
            NSInteger indexf = arc4random() % allFuDuiArray.count;
            NSString *dif = [allFuDuiArray objectAtIndex:indexf];
            [allFuDuiArray removeObjectAtIndex:indexf];
            NSLog(@"第%ld阶段预选赛小组：%@ %@ %@ %@",jieduan,dio,dit,dith,dif);
            
            NSMutableArray *shengyiArray = [NSMutableArray arrayWithArray:@[dio,dit,dith,dif]];
            if (jieduan == 1 && [shengyiArray containsObject:self.qiwangcity]) {
                self.yiyuxuansaicishu++;
            }
            NSInteger indexs1 = arc4random() % shengyiArray.count;
            [allFuDuiArray addObject:[shengyiArray objectAtIndex:indexs1]];
            [shengyiArray removeObjectAtIndex:indexs1];
            
            [self chouqianFenzuWithArray:allFuDuiArray];
        }
            break;
            
        default:
            break;
    }
}

-(void) chouqianFenzuWithArray:(NSMutableArray *) allQiuduiArray
{
    NSLog(@"-----------------------------------------------\n进入比赛%lu强",(unsigned long)allQiuduiArray.count);
    if (allQiuduiArray.count == 4 && [allQiuduiArray containsObject:self.qiwangcity]) {
        self.siqiangcishu++;
    }
    //先分四档
    NSMutableArray *allFuDuiArray = [NSMutableArray arrayWithArray:allQiuduiArray];
    NSMutableArray *fdangArray = [NSMutableArray array];
    NSMutableArray *sdangArray = [NSMutableArray array];
    NSMutableArray *tdangArray = [NSMutableArray array];
    NSMutableArray *fodangArray = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        switch (i) {
            case 0:
            {
                for (int j = 0; j < (allQiuduiArray.count / 4); j++) {
                    NSInteger index = arc4random() % allFuDuiArray.count;
                    [fdangArray addObject:[allFuDuiArray objectAtIndex:index]];
                    [allFuDuiArray removeObjectAtIndex:index];
                }
            }
                break;
            case 1:
            {
                for (int j = 0; j < (allQiuduiArray.count / 4); j++) {
                    NSInteger index = arc4random() % allFuDuiArray.count;
                    [sdangArray addObject:[allFuDuiArray objectAtIndex:index]];
                    [allFuDuiArray removeObjectAtIndex:index];
                }
            }
                break;
            case 2:
            {
                for (int j = 0; j < (allQiuduiArray.count / 4); j++) {
                    NSInteger index = arc4random() % allFuDuiArray.count;
                    [tdangArray addObject:[allFuDuiArray objectAtIndex:index]];
                    [allFuDuiArray removeObjectAtIndex:index];
                }
            }
                break;
            case 3:
            {
                for (int j = 0; j < (allQiuduiArray.count / 4); j++) {
                    NSInteger index = arc4random() % allFuDuiArray.count;
                    [fodangArray addObject:[allFuDuiArray objectAtIndex:index]];
                    [allFuDuiArray removeObjectAtIndex:index];
                }
            }
                break;
                
            default:
                break;
        }
    }
//    NSLog(@"分档结果:\n第一档");
//    NSMutableString *fname = [[NSMutableString alloc] init];
//    for (NSString *name in fdangArray) {
//        [fname appendFormat:@"%@ ",name];
//    }
//    NSLog(@"%@",fname);
//    NSLog(@"第二档");
//    NSMutableString *sname = [[NSMutableString alloc] init];
//    for (NSString *name in sdangArray) {
//        [sname appendFormat:@"%@ ",name];
//    }
//    NSLog(@"%@",sname);
//    NSLog(@"第三档");
//    NSMutableString *tname = [[NSMutableString alloc] init];
//    for (NSString *name in tdangArray) {
//        [tname appendFormat:@"%@ ",name];
//    }
//    NSLog(@"%@",tname);
//    NSLog(@"第四档");
//    NSMutableString *foname = [[NSMutableString alloc] init];
//    for (NSString *name in fodangArray) {
//        [foname appendFormat:@"%@ ",name];
//    }
//    NSLog(@"%@",foname);
    //分组
    NSMutableArray *fenzuJieGuoArray = [NSMutableArray array];
    for (int j = 0; j < (allQiuduiArray.count / 4); j++) {
        NSMutableArray *arra = [NSMutableArray array];
        NSInteger index1 = arc4random() % fdangArray.count;
        NSInteger index2 = arc4random() % sdangArray.count;
        NSInteger index3 = arc4random() % tdangArray.count;
        NSInteger index4 = arc4random() % fodangArray.count;
        
        [arra addObject:[fdangArray objectAtIndex:index1]];
        [arra addObject:[sdangArray objectAtIndex:index2]];
        [arra addObject:[tdangArray objectAtIndex:index3]];
        [arra addObject:[fodangArray objectAtIndex:index4]];
        
        [fdangArray removeObjectAtIndex:index1];
        [sdangArray removeObjectAtIndex:index2];
        [tdangArray removeObjectAtIndex:index3];
        [fodangArray removeObjectAtIndex:index4];
        
        NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
        [mdic setValue:[NSNumber numberWithInt:(j + 1)] forKey:@"zuming"];
        [mdic setValue:arra forKey:@"chengyuan"];
        [fenzuJieGuoArray addObject:mdic];
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *mdic in fenzuJieGuoArray) {
        NSMutableArray *arra = [mdic valueForKey:@"chengyuan"];
        NSLog(@"组别%@\n%@ %@ %@ %@",[mdic valueForKey:@"zuming"],[arra objectAtIndex:0],[arra objectAtIndex:1],[arra objectAtIndex:2],[arra objectAtIndex:3]);
        
        NSInteger indexs1 = arc4random() % arra.count;
        [array addObject:[arra objectAtIndex:indexs1]];
        [arra removeObjectAtIndex:indexs1];
        
        NSInteger indexs2 = arc4random() % arra.count;
        [array addObject:[arra objectAtIndex:indexs2]];
        [arra removeObjectAtIndex:indexs2];
    }
    if (array.count < 4) {
        NSInteger indexs1 = arc4random() % array.count;
        NSLog(@"------冠军:%@",[array objectAtIndex:indexs1]);
        NSString *guanjun = [NSString stringWithFormat:@"%@",[array objectAtIndex:indexs1]];
        BOOL isOldGuan = NO;
        if (self.huodeGuanjunshuArray) {
            for (NSMutableDictionary *mdic in self.huodeGuanjunshuArray) {
                if ([guanjun isEqualToString:[mdic valueForKey:@"city"]]) {
                    int cishu = [[mdic valueForKey:@"cishu"] intValue];
                    cishu++;
                    [mdic setValue:[NSNumber numberWithInt:cishu] forKey:@"cishu"];
                    NSMutableString *dijijie = [mdic valueForKey:@"jieshu"];
                    [dijijie appendFormat:@"第%ld届 ",self.jieshu];
                    [mdic setValue:dijijie forKey:@"jieshu"];
                    isOldGuan = YES;
                    break;
                }
            }
            if (!isOldGuan) {
                NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
                [mdic setValue:guanjun forKey:@"city"];
                [mdic setValue:[NSNumber numberWithInt:1] forKey:@"cishu"];
                [mdic setValue:[NSMutableString stringWithFormat:@"第%ld届 ",self.jieshu] forKey:@"jieshu"];
                [self.huodeGuanjunshuArray addObject:mdic];
            }
        }else{
            self.huodeGuanjunshuArray = [NSMutableArray array];
            NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
            [mdic setValue:guanjun forKey:@"city"];
            [mdic setValue:[NSNumber numberWithInt:1] forKey:@"cishu"];
            [mdic setValue:[NSMutableString stringWithFormat:@"第%ld届 ",self.jieshu] forKey:@"jieshu"];
            [self.huodeGuanjunshuArray addObject:mdic];
        }
        if ([[array objectAtIndex:indexs1] isEqualToString:self.qiwangcity]) {
            self.juesaicishu++;
        }
        [array removeObjectAtIndex:indexs1];
        if ([[array objectAtIndex:0] isEqualToString:self.qiwangcity]) {
            self.juesaicishu++;
        }
        NSLog(@"------亚军:%@",[array objectAtIndex:0]);
        NSLog(@"+++++++++++++++++++++++++\n第%ld届比赛结束",(long)self.jieshu);
        self.jieduanshu = 1;
//        if (![guanjun isEqualToString:self.qiwangcity]) {
            if (self.jieshu < self.qiwangjieshu) {
                [self moniguanjun];
            }else{
                NSArray *sortArray = [self.huodeGuanjunshuArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                    NSDictionary *dic1 = (NSDictionary *) obj1;
                    NSDictionary *dic2 = (NSDictionary *) obj2;
                    int cishu1 = [[dic1 valueForKey:@"cishu"] intValue];
                    int cishu2 = [[dic2 valueForKey:@"cishu"] intValue];
                    NSComparisonResult result;
                    if (cishu1 > cishu2) {
                        result = NSOrderedAscending;
                    }else{
                        result = NSOrderedDescending;
                    }
                    return result;
                }];

                NSMutableString *logString = [[NSMutableString alloc] init];
                NSInteger guanjuncishu = 0;
                for (NSMutableDictionary *mdic in sortArray) {
                    if ([[mdic valueForKey:@"city"] isEqualToString:self.qiwangcity]) {
                        guanjuncishu = [[mdic valueForKey:@"cishu"] intValue];
                    }
                    [logString appendFormat:@"%@  获得冠军%@次  %@\n",[mdic valueForKey:@"city"],[mdic valueForKey:@"cishu"],[mdic valueForKey:@"jieshu"]];
                }
                NSString *zustr;
                if (guanjuncishu == 0) {
                    zustr = @"未获得";
                }else{
                    zustr = [NSString stringWithFormat:@"获得%ld次",guanjuncishu];
                }
                NSLog(@"***********%@在%ld届之内%@冠军\n其中进入决赛%ld次，进入四强%ld次，进入第一阶段预选赛%ld次\n冠军列表\n%@",self.qiwangcity,self.qiwangjieshu,zustr,self.juesaicishu,self.siqiangcishu,self.yiyuxuansaicishu,logString);
                
            }
//        }else{
//            NSArray *sortArray = [self.huodeGuanjunshuArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//                NSDictionary *dic1 = (NSDictionary *) obj1;
//                NSDictionary *dic2 = (NSDictionary *) obj2;
//                int cishu1 = [[dic1 valueForKey:@"cishu"] intValue];
//                int cishu2 = [[dic2 valueForKey:@"cishu"] intValue];
//                NSComparisonResult result;
//                if (cishu1 > cishu2) {
//                    result = NSOrderedAscending;
//                }else{
//                    result = NSOrderedDescending;
//                }
//                return result;
//            }];
//            NSMutableString *logString = [[NSMutableString alloc] init];
//            for (NSMutableDictionary *mdic in sortArray) {
//                [logString appendFormat:@"%@  获得冠军%@次  %@\n",[mdic valueForKey:@"city"],[mdic valueForKey:@"cishu"],[mdic valueForKey:@"jieshu"]];
//            }
//            NSInteger cishu;
//            if (self.jieshu < self.qiwangjieshu) {
//                cishu = self.jieshu;
//            }else{
//                cishu = self.qiwangjieshu;
//            }
//            NSLog(@"***********%@在第%ld届获得冠军\n其中进入决赛%ld次，进入四强%ld次，进入第一阶段预选赛%ld次\n冠军列表\n%@",self.qiwangcity,cishu,self.juesaicishu,self.siqiangcishu,self.yiyuxuansaicishu,logString);
//        }
    }else{
        self.jieduanshu++;
        [self chouYuxuanWithArray:array andjieduan:self.jieduanshu];
    }
}

-(void) moniguanjun
{
    self.jieshu++;
    self.jieduanshu = 1;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CityList" ofType:@"plist"];
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"HuNan" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
//        if ([[dic valueForKey:@"prov"] isEqualToString:@"广东"]) {
//         if ([[dic valueForKey:@"shi"] isEqualToString:@"阜阳"]) {
            NSMutableArray *all = [dic valueForKey:@"city"];
            [array addObjectsFromArray:all];
//            break;
//        }
    }
    [self chouYuxuanWithArray:array andjieduan:self.jieduanshu];
}

//-(void) saiChengWithZhuArray:(NSMutableArray *) zhuArray andKeArray:(NSMutableArray *) keArray
//{
//    if (zhuArray.count % 2 == 0) {
//        NSMutableArray *zhuFuArray = [NSMutableArray arrayWithArray:zhuArray];
//        NSMutableArray *keFuArray = [NSMutableArray arrayWithArray:keArray];
//        for (int i = 0; i < zhuArray.count - 1 ;i++) {
//            
//        }
//    }
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    self.huodeGuanjunshuArray = [NSMutableArray array];
//    self.qiwangcity = @"广州";
//    self.qiwangjieshu = 300;
//    self.siqiangcishu = 0;
//    self.juesaicishu = 0;
//    self.jieshu = 0;
//    self.yiyuxuansaicishu = 0;
//    [self moniguanjun];
    NSLog(@"%d",31400%100);
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    NSLog(@"--------%@",url);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
