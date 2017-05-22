//
//  ShijiebeiModeViewController.m
//  TestTest
//
//  Created by 程海峰 on 2016/10/18.
//  Copyright © 2016年 海峰. All rights reserved.
//

#import "ShijiebeiModeViewController.h"
#import "ShijieBeiModeCalcul.h"

@interface ShijiebeiModeViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonnull) NSMutableString *nstring,*guanjunString,*yaJunString;
@property (assign, nonatomic) NSInteger jieshu,jieduanshu;
@property (assign, nonatomic) NSInteger isShiji;
@property (strong, nonatomic) NSMutableArray *allArray;
@property (assign, nonatomic) NSInteger jilu;
@end

@implementation ShijiebeiModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nstring = [[NSMutableString alloc] init];
    [self.nstring appendFormat:@"参赛球队(%ld支)\n",self.cansaiArray.count];
    for (NSString *name in self.cansaiArray) {
        [self.nstring appendFormat:@"%@ ",name];
    }
    [self.nstring appendFormat:@"\n\n"];
    self.jieshu = 0;
    [self moniguanjun];
    self.jilu = 0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *) yuxuansaiWith:(NSString *) dio and:(NSString *) dit
{
    NSInteger fjinqiushu = 0;
    NSInteger sjinqiushu = 0;
    
    NSMutableDictionary *dic12 = [ShijieBeiModeCalcul biSaiJieGuoWithCity:dio andCity:dit];
    NSArray *arr12 = [dic12 valueForKey:@"typeArray"];
    [self.nstring appendFormat:@"%@",[dic12 valueForKey:@"rString"]];
    fjinqiushu += [[arr12 objectAtIndex:1] integerValue];
    sjinqiushu += [[arr12 objectAtIndex:2] integerValue];
    
//    NSLog(@"总比分\n%@ %ld-%ld %@",dio,(long)fjinqiushu,(long)sjinqiushu,dit);
//    [self.nstring appendFormat:@"总比分\n%@ %ld-%ld %@\n",dio,(long)fjinqiushu,(long)sjinqiushu,dit];
    if (fjinqiushu > sjinqiushu) {
        [self.nstring appendFormat:@"\n"];
        return dio;
    }else if (fjinqiushu < sjinqiushu){
        [self.nstring appendFormat:@"\n"];
        return dit;
    }else{
        NSLog(@"点球");
        [self.nstring appendFormat:@"点球\n"];
        return [self yuxuansaiWith:dio and:dit];
    }
}

-(void) danBaiModeWithArray:(NSMutableArray *) allQiuduiArray andjieduan:(NSInteger) jieduan
{
    NSMutableArray *allFuDuiArray = [NSMutableArray arrayWithArray:allQiuduiArray];
    switch (allQiuduiArray.count % 2 ) {
        case 0:
        {
            [self danBaiBisaiWithArray:allQiuduiArray];
        }
            break;
        case 1:
        {
            if (allQiuduiArray.count == 3) {
                [self sanduiJinruJuesaiWithArray:allQiuduiArray];
            }else{
                NSInteger index = arc4random() % allFuDuiArray.count;
                NSString *dio = [allFuDuiArray objectAtIndex:index];
                [allFuDuiArray removeObjectAtIndex:index];
                
                NSInteger indext = arc4random() % allFuDuiArray.count;
                NSString *dit = [allFuDuiArray objectAtIndex:indext];
                [allFuDuiArray removeObjectAtIndex:indext];
                NSLog(@"第%ld阶段预选赛对阵：%@ VS %@",jieduan,dio,dit);
                [self.nstring appendFormat:@"第%ld阶段预选赛对阵：%@ VS %@\n",jieduan,dio,dit];
                
                [allFuDuiArray addObject:[self yuxuansaiWith:dio and:dit]];
                [self danBaiBisaiWithArray:allFuDuiArray];
            }
        }
            break;
            
        default:
            break;
    }
}

-(void) sanduiJinruJuesaiWithArray:(NSMutableArray *) sanduiArray
{
    NSMutableDictionary *midc = [ShijieBeiModeCalcul sasanduiJinruJuesaiWithMdic:sanduiArray];
    NSArray *jieguoArra = [midc valueForKey:@"teamArray"];
    [self.nstring appendFormat:@"%@",[midc valueForKey:@"returnString"]];
    NSLog(@"------冠军:%@",[jieguoArra objectAtIndex:0]);
    NSLog(@"------亚军:%@",[jieguoArra objectAtIndex:1]);
    NSLog(@"------季军:%@",[jieguoArra objectAtIndex:2]);
    [self.nstring appendFormat:@"冠军:%@\n",[jieguoArra objectAtIndex:0]];
    [self.nstring appendFormat:@"亚军:%@\n",[jieguoArra objectAtIndex:1]];
    [self.nstring appendFormat:@"季军:%@\n",[jieguoArra objectAtIndex:2]];
    NSMutableString *guanjun = [NSMutableString stringWithFormat:@"%@",[jieguoArra objectAtIndex:0]];
    self.guanjunString = guanjun;
    NSLog(@"+++++++++++++++++++++++++\n第%ld届比赛结束",(long)self.jieshu);
    [self.nstring appendFormat:@"第%ld届比赛结束\n",(long)self.jieshu];
    [self showStringToTextView];
}

-(void) danBaiBisaiWithArray:(NSMutableArray *) allQiuduiArray
{
    if (allQiuduiArray.count == 2) {
        NSLog(@"\n\n-----------------------------------------------\n进入决赛");
        [self.nstring appendFormat:@"进入决赛\n"];
    }else{
        NSLog(@"\n\n-----------------------------------------------\n进入比赛%lu强",(unsigned long)allQiuduiArray.count);
        [self.nstring appendFormat:@"进入比赛%lu强\n",(unsigned long)allQiuduiArray.count];
    }
    //先分两档
    NSMutableArray *allFuDuiArray = [NSMutableArray arrayWithArray:allQiuduiArray];
    NSMutableArray *fdangArray = [NSMutableArray array];
    NSMutableArray *sdangArray = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        switch (i) {
            case 0:
            {
                for (int j = 0; j < (allQiuduiArray.count / 2); j++) {
                    NSInteger index = arc4random() % allFuDuiArray.count;
                    [fdangArray addObject:[allFuDuiArray objectAtIndex:index]];
                    [allFuDuiArray removeObjectAtIndex:index];
                }
            }
                break;
            case 1:
            {
                for (int j = 0; j < (allQiuduiArray.count / 2); j++) {
                    NSInteger index = arc4random() % allFuDuiArray.count;
                    [sdangArray addObject:[allFuDuiArray objectAtIndex:index]];
                    [allFuDuiArray removeObjectAtIndex:index];
                }
            }
                break;
                
            default:
                break;
        }
    }
    //分组
    NSMutableArray *fenzuJieGuoArray = [NSMutableArray array];
    for (int j = 0; j < (allQiuduiArray.count / 2); j++) {
        NSMutableArray *arra = [NSMutableArray array];
        NSInteger index1 = arc4random() % fdangArray.count;
        NSInteger index2 = arc4random() % sdangArray.count;
        
        [arra addObject:[fdangArray objectAtIndex:index1]];
        [arra addObject:[sdangArray objectAtIndex:index2]];
        
        [fdangArray removeObjectAtIndex:index1];
        [sdangArray removeObjectAtIndex:index2];
        
        NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
        [mdic setValue:[NSNumber numberWithInt:(j + 1)] forKey:@"zuming"];
        [mdic setValue:arra forKey:@"chengyuan"];
        [fenzuJieGuoArray addObject:mdic];
    }
    
    //模拟赛果
    if (fenzuJieGuoArray.count <= 2) {
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *shibaiZheArray = [NSMutableArray array];
        for (NSMutableDictionary *mdic in fenzuJieGuoArray) {
            NSMutableArray *arra = [mdic valueForKey:@"chengyuan"];
            NSLog(@"组别%@\n%@ VS %@",[mdic valueForKey:@"zuming"],[arra objectAtIndex:0],[arra objectAtIndex:1]);
            [self.nstring appendFormat:@"组别%@\n%@ VS %@\n",[mdic valueForKey:@"zuming"],[arra objectAtIndex:0],[arra objectAtIndex:1]];
            
            NSString *dio = [arra objectAtIndex:0];
            NSString *dit = [arra objectAtIndex:1];
            NSString *shengzhe = [self yuxuansaiWith:dio and:dit];
            [array addObject:shengzhe];
            if ([shengzhe isEqualToString:dio]) {
                [shibaiZheArray addObject:dit];
            }else{
                [shibaiZheArray addObject:dio];
            }
        }
        NSLog(@"------进入季军争夺赛");
        [self.nstring appendFormat:@"进入季军争夺赛\n"];
        NSLog(@"%@ VS %@",[shibaiZheArray objectAtIndex:0],[shibaiZheArray objectAtIndex:1]);
        [self.nstring appendFormat:@"%@ VS %@\n",[shibaiZheArray objectAtIndex:0],[shibaiZheArray objectAtIndex:1]];
        NSString *dio = [shibaiZheArray objectAtIndex:0];
        NSString *dit = [shibaiZheArray objectAtIndex:1];
        NSString *jijun = [self yuxuansaiWith:dio and:dit];
        NSString *dianjun;
        if ([jijun isEqualToString:dio]) {
            dianjun = dit;
        }else{
            dianjun = dio;
        }
        
        NSLog(@"------进入决赛");
        [self.nstring appendFormat:@"进入决赛\n"];
        NSLog(@"%@ VS %@",[array objectAtIndex:0],[array objectAtIndex:1]);
        [self.nstring appendFormat:@"%@ VS %@\n",[array objectAtIndex:0],[array objectAtIndex:1]];
        NSString *dioj = [array objectAtIndex:0];
        NSString *ditj = [array objectAtIndex:1];
        NSString *guanjun = [self yuxuansaiWith:dioj and:ditj];
        NSString *yajun;
        if ([guanjun isEqualToString:dioj]) {
            yajun = ditj;
        }else{
            yajun = dioj;
        }
        
        
        NSLog(@"------冠军:%@",guanjun);
        NSLog(@"------亚军:%@",yajun);
        NSLog(@"------季军:%@",jijun);
        NSLog(@"------殿军:%@",dianjun);
        [self.nstring appendFormat:@"冠军:%@\n",guanjun];
        [self.nstring appendFormat:@"亚军:%@\n",yajun];
        [self.nstring appendFormat:@"季军:%@\n",jijun];
        [self.nstring appendFormat:@"殿军:%@\n",dianjun];
        self.guanjunString = [NSMutableString stringWithFormat:@"%@",guanjun];
        NSLog(@"+++++++++++++++++++++++++\n第%ld届比赛结束",(long)self.jieshu);
        [self.nstring appendFormat:@"第%ld届比赛结束\n",(long)self.jieshu];
        [self showStringToTextView];
    }else{
        NSMutableArray *array = [NSMutableArray array];
        for (NSMutableDictionary *mdic in fenzuJieGuoArray) {
            NSMutableArray *arra = [mdic valueForKey:@"chengyuan"];
            NSLog(@"组别%@\n%@ VS %@",[mdic valueForKey:@"zuming"],[arra objectAtIndex:0],[arra objectAtIndex:1]);
            [self.nstring appendFormat:@"组别%@\n%@ VS %@\n",[mdic valueForKey:@"zuming"],[arra objectAtIndex:0],[arra objectAtIndex:1]];
            
            NSString *dio = [arra objectAtIndex:0];
            NSString *dit = [arra objectAtIndex:1];
            [array addObject:[self yuxuansaiWith:dio and:dit]];
        }
        self.jieduanshu++;
        [self danBaiModeWithArray:array andjieduan:self.jieduanshu];
    }
    
}

-(void) showStringToTextView{
    NSMutableArray *rangeArray = [NSMutableArray array];
    NSMutableString *chaString = [NSMutableString stringWithFormat:@"%@",self.nstring];
    NSRange startRange = [chaString rangeOfString:self.guanjunString];
    do {
        [rangeArray addObject:[NSValue valueWithRange:startRange]];
        startRange = [chaString rangeOfString:self.guanjunString options:NSCaseInsensitiveSearch range:NSMakeRange((startRange.location + 2), (chaString.length - (startRange.location + 2)))];
    } while (startRange.location != NSNotFound);
    NSMutableAttributedString *flyInfoString = [[NSMutableAttributedString alloc] initWithString:self.nstring];
//    for (NSValue *values in rangeArray) {
//        NSRange range = [values rangeValue];
//        [flyInfoString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
//    }
    self.textView.attributedText = flyInfoString;
}

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
            [self.nstring appendFormat:@"第%ld阶段预选赛对阵：%@ VS %@\n",jieduan,dio,dit];
            
            [allFuDuiArray addObject:[self yuxuansaiWith:dio and:dit]];
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
            [self.nstring appendFormat:@"第%ld阶段预选赛小组：%@ %@ %@ %@\n",jieduan,dio,dit,dith,dif];
            NSMutableArray *shengyiArray = [NSMutableArray arrayWithArray:@[dio,dit,dith,dif]];
            NSMutableDictionary *midc = [ShijieBeiModeCalcul saiChengSaiGuoWithMdic:shengyiArray];
            NSArray *jieguoArra = [midc valueForKey:@"teamArray"];
            [self.nstring appendFormat:@"%@",[midc valueForKey:@"returnString"]];
            for (NSString *strs in jieguoArra) {
                [allFuDuiArray addObject:strs];
                [shengyiArray removeObject:strs];
            }
            
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
            [self.nstring appendFormat:@"第%ld阶段预选赛小组：%@ %@ %@ %@\n",jieduan,dio,dit,dith,dif];
            NSMutableArray *shengyiArray = [NSMutableArray arrayWithArray:@[dio,dit,dith,dif]];
            NSMutableDictionary *midc = [ShijieBeiModeCalcul saiChengSaiGuoWithMdic:shengyiArray];
            NSArray *jieguoArra = [midc valueForKey:@"teamArray"];
            [self.nstring appendFormat:@"%@",[midc valueForKey:@"returnString"]];
            [allFuDuiArray addObject:[jieguoArra objectAtIndex:0]];
            [shengyiArray removeObject:[jieguoArra objectAtIndex:0]];
            
            [self chouqianFenzuWithArray:allFuDuiArray];
        }
            break;
            
        default:
            break;
    }
}

-(void) chouqianFenzuWithArray:(NSMutableArray *) allQiuduiArray
{
    
    if (self.jilu > 0) {
        [self danBaiBisaiWithArray:allQiuduiArray];
        return;
    }
    self.jilu++;
    NSLog(@"\n\n-----------------------------------------------\n进入比赛%lu强",(unsigned long)allQiuduiArray.count);
    [self.nstring appendFormat:@"进入比赛%lu强\n",(unsigned long)allQiuduiArray.count];
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
    
    //模拟赛果
    NSMutableArray *array = [NSMutableArray array];
    for (NSMutableDictionary *mdic in fenzuJieGuoArray) {
        NSMutableArray *arra = [mdic valueForKey:@"chengyuan"];
        NSLog(@"组别%@\n%@ %@ %@ %@",[mdic valueForKey:@"zuming"],[arra objectAtIndex:0],[arra objectAtIndex:1],[arra objectAtIndex:2],[arra objectAtIndex:3]);
        [self.nstring appendFormat:@"组别%@\n%@ %@ %@ %@\n",[mdic valueForKey:@"zuming"],[arra objectAtIndex:0],[arra objectAtIndex:1],[arra objectAtIndex:2],[arra objectAtIndex:3]];
        
        NSMutableDictionary *midc = [ShijieBeiModeCalcul saiChengSaiGuoWithMdic:arra];
        NSArray *jieguoArra = [midc valueForKey:@"teamArray"];
        [self.nstring appendFormat:@"%@",[midc valueForKey:@"returnString"]];
        for (NSString *strs in jieguoArra) {
            [array addObject:strs];
            [arra removeObject:strs];
        }
    }
    if (array.count < 4) {
        NSLog(@"------冠军:%@",[array objectAtIndex:0]);
        [self.nstring appendFormat:@"冠军:%@\n",[array objectAtIndex:0]];
        NSMutableString *guanjun = [NSMutableString stringWithFormat:@"%@",[array objectAtIndex:0]];
        self.guanjunString = guanjun;
        NSLog(@"------亚军:%@",[array objectAtIndex:1]);
        self.yaJunString = [array objectAtIndex:1];
        if (allQiuduiArray.count == 4) {
            for (NSString *name in allQiuduiArray) {
                if ((![name isEqualToString:self.guanjunString]) && (![name isEqualToString:self.yaJunString])) {
                }
            }
        }
        [self.nstring appendFormat:@"亚军:%@\n",[array objectAtIndex:1]];
        NSLog(@"+++++++++++++++++++++++++\n第%ld届比赛结束",(long)self.jieshu);
        [self.nstring appendFormat:@"第%ld届比赛结束\n",(long)self.jieshu];
        
        
        NSMutableArray *rangeArray = [NSMutableArray array];
        NSMutableString *chaString = [NSMutableString stringWithFormat:@"%@",self.nstring];
        NSRange startRange = [chaString rangeOfString:self.guanjunString];
        do {
            [rangeArray addObject:[NSValue valueWithRange:startRange]];
            startRange = [chaString rangeOfString:self.guanjunString options:NSCaseInsensitiveSearch range:NSMakeRange((startRange.location + 2), (chaString.length - (startRange.location + 2)))];
        } while (startRange.location != NSNotFound);
        NSMutableAttributedString *flyInfoString = [[NSMutableAttributedString alloc] initWithString:self.nstring];
        for (NSValue *values in rangeArray) {
            NSRange range = [values rangeValue];
            [flyInfoString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        }
        
        NSMutableArray *srangeArray = [NSMutableArray array];
        NSMutableString *schaString = [NSMutableString stringWithFormat:@"%@",self.nstring];
        NSRange sstartRange = [schaString rangeOfString:self.yaJunString];
        do {
            [srangeArray addObject:[NSValue valueWithRange:sstartRange]];
            sstartRange = [schaString rangeOfString:self.yaJunString options:NSCaseInsensitiveSearch range:NSMakeRange((sstartRange.location + 2), (schaString.length - (sstartRange.location + 2)))];
        } while (sstartRange.location != NSNotFound);
        for (NSValue *values in srangeArray) {
            NSRange range = [values rangeValue];
            [flyInfoString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
        }
        self.textView.attributedText = flyInfoString;
        
    }else{
        self.jieduanshu++;
        [self chouYuxuanWithArray:array andjieduan:self.jieduanshu];
    }
}

-(void) moniguanjun
{
    self.jieshu++;
    self.jieduanshu = 1;
    [self shengchengShuzu];
    [self kaishiMoniWithArray];
}

-(void) shengchengShuzu
{
    self.allArray = [NSMutableArray arrayWithArray:self.cansaiArray];
}

-(void) kaishiMoniWithArray{
    if (self.allArray.count < 4) {
        [self danBaiModeWithArray:self.allArray andjieduan:self.jieduanshu];
    }
    [self chouYuxuanWithArray:self.allArray andjieduan:self.jieduanshu];
}

@end
