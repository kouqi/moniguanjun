//
//  LianSaiJingxingshiViewController.m
//  TestTest
//
//  Created by 程海峰 on 16/9/9.
//  Copyright © 2016年 海峰. All rights reserved.
//

#import "LianSaiJingxingshiViewController.h"
#import "CalculationGameTool.h"
@interface LianSaiJingxingshiViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(strong,nonatomic) NSMutableString *xianshiString;
@property(strong,nonatomic) NSMutableArray *cansaiArray,*finalfinalAllLunArray;
@property (strong, nonatomic) NSMutableDictionary *lastDictionary;
@property(assign, nonatomic) NSInteger currentLunshu,allLunshu;
@property(strong,nonatomic) NSMutableArray *jiqianArray;
@end

@implementation LianSaiJingxingshiViewController

-(NSString *) yuxuansaiWith:(NSString *) dio and:(NSString *) dit
{
    NSInteger fjinqiushu = 0,fkejin = 0;
    NSInteger sjinqiushu = 0,skejin = 0;
    
    NSMutableDictionary *dic12 = [CalculationGameTool biSaiJieGuoWithCity:dio andCity:dit];
    NSArray *arr12 = [dic12 valueForKey:@"typeArray"];
    [self.xianshiString appendFormat:@"%@",[dic12 valueForKey:@"rString"]];
    fjinqiushu += [[arr12 objectAtIndex:1] integerValue];
    sjinqiushu += [[arr12 objectAtIndex:2] integerValue];
    skejin += [[arr12 objectAtIndex:2] integerValue];
    
    NSMutableDictionary *dic21 = [CalculationGameTool biSaiJieGuoWithCity:dit andCity:dio];
    NSArray *arr21 = [dic21 valueForKey:@"typeArray"];
    [self.xianshiString appendFormat:@"%@",[dic21 valueForKey:@"rString"]];
    fjinqiushu += [[arr21 objectAtIndex:2] integerValue];
    fkejin += [[arr21 objectAtIndex:2] integerValue];
    sjinqiushu += [[arr21 objectAtIndex:1] integerValue];
    
    NSLog(@"总比分\n%@ %ld-%ld %@",dio,(long)fjinqiushu,(long)sjinqiushu,dit);
    [self.xianshiString appendFormat:@"总比分\n%@ %ld-%ld %@\n",dio,(long)fjinqiushu,(long)sjinqiushu,dit];
    if (fjinqiushu > sjinqiushu) {
        [self.xianshiString appendFormat:@"\n"];
        return dio;
    }else if (fjinqiushu < sjinqiushu){
        [self.xianshiString appendFormat:@"\n"];
        return dit;
    }else{
        if (fkejin > skejin) {
            NSLog(@"%@客场进球多胜出\n",dio);
            [self.xianshiString appendFormat:@"%@客场进球多胜出\n\n",dio];
            return dio;
        }else if (fkejin < skejin){
            NSLog(@"%@客场进球多胜出\n",dit);
            [self.xianshiString appendFormat:@"%@客场进球多胜出\n\n",dit];
            return dit;
        }else{
            NSLog(@"重赛");
            [self.xianshiString appendFormat:@"重赛\n"];
            return [self yuxuansaiWith:dio and:dit];
        }
    }
    
}

-(void) initTopBar{
    self.title = @"联赛细情";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 70, 40);
    [button setTitle:@"next" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextLun) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbu = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIButton *sbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    sbutton.frame = CGRectMake(0, 0, 70, 40);
    [sbutton setTitle:@"done" forState:UIControlStateNormal];
    [sbutton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [sbutton addTarget:self action:@selector(endlun) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sbarbu = [[UIBarButtonItem alloc] initWithCustomView:sbutton];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:sbarbu,barbu, nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopBar];
    self.xianshiString = [NSMutableString string];
//    [self taotaiyizhi];
    [self doucanjia];
    // Do any additional setup after loading the view from its nib.
}

-(void) xiaoyufour{
    if (self.cansaiArray.count == 1) {
        [self paiming];
        self.textView.text = self.xianshiString;
        return;
    }
    NSMutableArray *diyisss = [NSMutableArray array];
    if (self.cansaiArray.count % 2 != 0) {
        NSInteger index = arc4random() % self.cansaiArray.count;
        self.lastDictionary = [NSMutableDictionary dictionaryWithDictionary:[self.cansaiArray objectAtIndex:index]];
        [self.cansaiArray removeObjectAtIndex:index];
        
        NSMutableArray *shuju = [NSMutableArray array];
        for (int i = 0; i < self.cansaiArray.count; i++) {
            NSMutableArray *sshuju = [NSMutableArray array];
            if (i % 2 == 0) {
                [sshuju addObject:self.lastDictionary];
                [sshuju addObject:[self.cansaiArray objectAtIndex:i]];
            }else{
                [sshuju addObject:[self.cansaiArray objectAtIndex:i]];
                [sshuju addObject:self.lastDictionary];
            }
            
            [shuju addObject:sshuju];
        }
        [diyisss addObject:shuju];
        NSMutableArray *shujus = [NSMutableArray array];
        for (int i = 0; i < self.cansaiArray.count; i++) {
            NSMutableArray *sshuju = [NSMutableArray array];
            if (i % 2 != 0) {
                [sshuju addObject:self.lastDictionary];
                [sshuju addObject:[self.cansaiArray objectAtIndex:i]];
            }else{
                [sshuju addObject:[self.cansaiArray objectAtIndex:i]];
                [sshuju addObject:self.lastDictionary];
            }
            [shujus addObject:sshuju];
        }
         [diyisss addObject:shujus];
    }
    NSMutableArray *shujuss = [NSMutableArray array];
    NSMutableArray *sshuju1 = [NSMutableArray array];
    [sshuju1 addObject:[self.cansaiArray objectAtIndex:0]];
    [sshuju1 addObject:[self.cansaiArray objectAtIndex:1]];
    [shujuss addObject:sshuju1];
    NSMutableArray *sshuju2 = [NSMutableArray array];
    [sshuju2 addObject:[self.cansaiArray objectAtIndex:1]];
    [sshuju2 addObject:[self.cansaiArray objectAtIndex:0]];
    [shujuss addObject:sshuju2];
    
    [diyisss addObject:shujuss];
    for (int i = 0; i < diyisss.count; i++) {
        NSMutableArray *lunArray = [diyisss objectAtIndex:i];
        NSLog(@"赛前第%d轮",(i + 1));
        [self.xianshiString appendFormat:@"\n赛前第%d轮\n",(i + 1)];
        [self bisaikaishiWithArray:lunArray];
    }
    [self paiming];
    self.textView.text = self.xianshiString;
}

-(void) doucanjia{
    self.cansaiArray = [NSMutableArray array];
    for (NSString *city in self.allQiuduiArray) {
        NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
        [mdic setValue:city forKey:@"city"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jifen"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jingshengqiu"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jingqiu"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"sheng"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"ping"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"fu"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"changci"];
        [self.cansaiArray addObject:mdic];
    }
//    if (self.cansaiArray.count < 4) {
//        [self xiaoyufour];
//        return;
//    }
    
    
    [self beigerduizhen];
    [self paiming];
    self.textView.text = self.xianshiString;
    
    return;
    
//    if ((self.cansaiArray.count % 2) != 0) {
//        NSInteger index = arc4random() % self.cansaiArray.count;
//        self.lastDictionary = [NSMutableDictionary dictionaryWithDictionary:[self.cansaiArray objectAtIndex:index]];
//        [self.cansaiArray removeObjectAtIndex:index];
//        NSMutableArray *diyisss = [NSMutableArray array];
//        NSMutableArray *shuju = [NSMutableArray array];
//        for (int i = 0; i < self.cansaiArray.count; i++) {
//            NSMutableArray *sshuju = [NSMutableArray array];
//            if (i % 2 == 0) {
//                [sshuju addObject:self.lastDictionary];
//                [sshuju addObject:[self.cansaiArray objectAtIndex:i]];
//            }else{
//                [sshuju addObject:[self.cansaiArray objectAtIndex:i]];
//                [sshuju addObject:self.lastDictionary];
//            }
//            
//            [shuju addObject:sshuju];
//        }
//        [diyisss addObject:shuju];
//        NSMutableArray *shujus = [NSMutableArray array];
//        for (int i = 0; i < self.cansaiArray.count; i++) {
//            NSMutableArray *sshuju = [NSMutableArray array];
//            if (i % 2 != 0) {
//                [sshuju addObject:self.lastDictionary];
//                [sshuju addObject:[self.cansaiArray objectAtIndex:i]];
//            }else{
//                [sshuju addObject:[self.cansaiArray objectAtIndex:i]];
//                [sshuju addObject:self.lastDictionary];
//            }
//            [shujus addObject:sshuju];
//        }
//        [diyisss addObject:shujus];
//        self.jiqianArray = [NSMutableArray array];
//        NSMutableArray *jiemuArray = [NSMutableArray array];
//        for (int i = 0; i < diyisss.count; i++) {
//            NSMutableArray *lunArray = [diyisss objectAtIndex:i];
//            [jiemuArray addObject:lunArray.firstObject];
//            [lunArray removeObjectAtIndex:0];
//            [self.jiqianArray addObjectsFromArray:lunArray];
//        }
//        NSLog(@"揭幕战");
//        [self.xianshiString appendFormat:@"揭幕战\n"];
//        [self bisaikaishiWithArray:jiemuArray];
//        for (int i = 0; i < diyisss.count; i++) {
//            NSMutableArray *lunArray = [diyisss objectAtIndex:i];
//            NSLog(@"赛前第%d轮",(i + 1));
//            [self.xianshiString appendFormat:@"\n赛前第%d轮\n",(i + 1)];
//            [self bisaikaishiWithArray:lunArray];
//        }
//        [self lunshuduizhen];
//        [self paiming];
//        self.textView.text = self.xianshiString;
//    }else{
//        [self lunshuduizhen];
//        [self paiming];
//        self.textView.text = self.xianshiString;
//    }
}

-(void) beigerduizhen{
    NSMutableArray *fshuzu = [NSMutableArray array];
    NSMutableArray *lshuzu = [NSMutableArray array];
    NSMutableArray *theArray = [NSMutableArray arrayWithArray:self.cansaiArray];
    
    NSInteger tiaojian1,tiaojian2;
    
    if (self.cansaiArray.count % 2 == 0) {
        tiaojian1 = (self.cansaiArray.count) / 2;
        tiaojian2 = self.cansaiArray.count - 1;
    }else{
        tiaojian1 = (self.cansaiArray.count + 1) / 2;
        tiaojian2 = self.cansaiArray.count;
    }
    
    for (int i = 0; i < (self.cansaiArray.count + 1) / 2; i++) {
        NSInteger index = arc4random() % theArray.count;
        NSMutableDictionary *dio = [theArray objectAtIndex:index];
        [theArray removeObjectAtIndex:index];
        [fshuzu addObject:dio];
        
        if (self.cansaiArray.count % 2 == 0) {
            NSInteger indext = arc4random() % theArray.count;
            NSMutableDictionary *dit = [theArray objectAtIndex:indext];
            [theArray removeObjectAtIndex:indext];
            [lshuzu addObject:dit];
        }else{
            if (theArray.count == 0) {
                [lshuzu addObject:@"0"];
            }else{
                NSInteger indext = arc4random() % theArray.count;
                NSMutableDictionary *dit = [theArray objectAtIndex:indext];
                [theArray removeObjectAtIndex:indext];
                [lshuzu addObject:dit];
            }
        }
    }
    
    NSMutableArray *allLunArray = [NSMutableArray array];
    NSInteger changcishu = fshuzu.count;
    for (int i = 0; i < tiaojian2; i++) {
        NSMutableArray *lunArray = [NSMutableArray array];
        for (int k = 0; k < changcishu; k++) {
            NSMutableArray *changShuzu = [NSMutableArray array];
            [changShuzu addObject:[fshuzu objectAtIndex:k]];
            [changShuzu addObject:[lshuzu objectAtIndex:k]];
            [lunArray addObject:changShuzu];
        }
        NSMutableDictionary *lunhuanfCity = fshuzu.lastObject;
        NSMutableDictionary *luhuansCity = lshuzu.firstObject;
        [fshuzu removeLastObject];
        [fshuzu insertObject:luhuansCity atIndex:1];
        [lshuzu removeObjectAtIndex:0];
        [lshuzu addObject:lunhuanfCity];
        [allLunArray addObject:lunArray];
    }
    
    NSMutableArray *finalAllLunArray = [NSMutableArray array];
    for (int i = 0; i < allLunArray.count; i++) {
        NSMutableArray *lunArray = [allLunArray objectAtIndex:i];
        NSMutableArray *xlunArray = [NSMutableArray array];
        for (int j = 0; j < lunArray.count; j++) {
            NSMutableArray *changShuzu = [lunArray objectAtIndex:j];
            NSMutableArray *xc = [NSMutableArray array];
            [xc addObject:[changShuzu objectAtIndex:1]];
            [xc addObject:[changShuzu objectAtIndex:0]];
            [xlunArray addObject:xc];
        }
        [finalAllLunArray addObject:xlunArray];
    }
    
    NSMutableArray *ffllarra = [NSMutableArray array];
    for (int i = 0; i < tiaojian1; i++) {
        [ffllarra addObject:[allLunArray objectAtIndex:i]];
        [allLunArray removeObject:[allLunArray objectAtIndex:i]];
        if ((i + 1) < tiaojian1) {
            [ffllarra addObject:[finalAllLunArray objectAtIndex:(i+1)]];
            [finalAllLunArray removeObject:[finalAllLunArray objectAtIndex:(i+1)]];
        }
    }
    
    NSMutableArray *ssllarra = [NSMutableArray array];
    for (int i = 0; i < allLunArray.count; i++) {
        [ssllarra addObject:[finalAllLunArray objectAtIndex:i]];
        [ssllarra addObject:[allLunArray objectAtIndex:i]];
    }
    [ssllarra addObject:finalAllLunArray.lastObject];
    
    NSMutableArray *ffflllArra = [NSMutableArray array];
    NSMutableArray *ssslllArra = [NSMutableArray array];
    for (int i = 0; i < tiaojian2; i++) {
        NSInteger index = arc4random() % ffllarra.count;
        [ffflllArra addObject:[ffllarra objectAtIndex:index]];
        [ffllarra removeObjectAtIndex:index];
        
        NSInteger indexs = arc4random() % ssllarra.count;
        [ssslllArra addObject:[ssllarra objectAtIndex:indexs]];
        [ssllarra removeObjectAtIndex:indexs];
    }
    
    
    
    self.finalfinalAllLunArray = [NSMutableArray array];
    [self.finalfinalAllLunArray addObjectsFromArray:ssslllArra];
    [self.finalfinalAllLunArray addObjectsFromArray:ffflllArra];
    self.currentLunshu = 0;
    self.allLunshu = self.finalfinalAllLunArray.count;
}

-(void) lunshuduizhen
{
    NSMutableArray *fshuzu = [NSMutableArray array];
    NSMutableArray *lshuzu = [NSMutableArray array];
    NSMutableArray *theArray = [NSMutableArray arrayWithArray:self.cansaiArray];
    for (int i = 0; i < (self.cansaiArray.count) / 2; i++) {
        NSInteger index = arc4random() % theArray.count;
        NSMutableDictionary *dio = [theArray objectAtIndex:index];
        [theArray removeObjectAtIndex:index];
        
        NSInteger indext = arc4random() % theArray.count;
        NSMutableDictionary *dit = [theArray objectAtIndex:indext];
        [theArray removeObjectAtIndex:indext];
        [fshuzu addObject:dio];
        [lshuzu addObject:dit];
    }
    
    NSMutableArray *allLunArray = [NSMutableArray array];
    NSInteger changcishu = fshuzu.count;
    for (int i = 0; i < self.cansaiArray.count - 1; i++) {
        NSMutableArray *lunArray = [NSMutableArray array];
        for (int k = 0; k < changcishu; k++) {
            NSMutableArray *changShuzu = [NSMutableArray array];
            [changShuzu addObject:[fshuzu objectAtIndex:k]];
            [changShuzu addObject:[lshuzu objectAtIndex:k]];
            [lunArray addObject:changShuzu];
        }
        NSMutableDictionary *lunhuanfCity = fshuzu.lastObject;
        NSMutableDictionary *luhuansCity = lshuzu.firstObject;
        [fshuzu removeLastObject];
        [fshuzu insertObject:luhuansCity atIndex:1];
        [lshuzu removeObjectAtIndex:0];
        [lshuzu addObject:lunhuanfCity];
        [allLunArray addObject:lunArray];
    }
//    NSMutableArray *finalAllLunArray = [NSMutableArray arrayWithArray:allLunArray];
    NSMutableArray *finalAllLunArray = [NSMutableArray array];
    for (int i = 0; i < allLunArray.count; i++) {
        NSMutableArray *lunArray = [allLunArray objectAtIndex:i];
        NSMutableArray *xlunArray = [NSMutableArray array];
        for (int j = 0; j < lunArray.count; j++) {
            NSMutableArray *changShuzu = [lunArray objectAtIndex:j];
            NSMutableArray *xc = [NSMutableArray array];
            [xc addObject:[changShuzu objectAtIndex:1]];
            [xc addObject:[changShuzu objectAtIndex:0]];
            [xlunArray addObject:xc];
        }
        [finalAllLunArray addObject:xlunArray];
    }
    
    NSMutableArray *ffllarra = [NSMutableArray array];
    for (int i = 0; i < (self.cansaiArray.count / 2); i++) {
        [ffllarra addObject:[allLunArray objectAtIndex:i]];
        [allLunArray removeObject:[allLunArray objectAtIndex:i]];
        if ((i + 1) < (self.cansaiArray.count / 2)) {
            [ffllarra addObject:[finalAllLunArray objectAtIndex:(i+1)]];
            [finalAllLunArray removeObject:[finalAllLunArray objectAtIndex:(i+1)]];
        }
    }
    
    NSMutableArray *ssllarra = [NSMutableArray array];
    for (int i = 0; i < allLunArray.count; i++) {
        [ssllarra addObject:[finalAllLunArray objectAtIndex:i]];
        [ssllarra addObject:[allLunArray objectAtIndex:i]];
    }
    [ssllarra addObject:finalAllLunArray.lastObject];
    
    NSMutableArray *ffflllArra = [NSMutableArray array];
    NSMutableArray *ssslllArra = [NSMutableArray array];
    for (int i = 0; i < self.cansaiArray.count - 1; i++) {
        NSInteger index = arc4random() % ffllarra.count;
        [ffflllArra addObject:[ffllarra objectAtIndex:index]];
        [ffllarra removeObjectAtIndex:index];
        
        NSInteger indexs = arc4random() % ssllarra.count;
        [ssslllArra addObject:[ssllarra objectAtIndex:indexs]];
        [ssllarra removeObjectAtIndex:indexs];
    }
    
    
    
    self.finalfinalAllLunArray = [NSMutableArray array];
    [self.finalfinalAllLunArray addObjectsFromArray:ssslllArra];
    [self.finalfinalAllLunArray addObjectsFromArray:ffflllArra];
    self.currentLunshu = 0;
    self.allLunshu = self.finalfinalAllLunArray.count;
    
}

-(void) nextLun{
    if (self.currentLunshu >= self.allLunshu) {
        return;
    }
    NSMutableArray *lunArray = [self.finalfinalAllLunArray objectAtIndex:self.currentLunshu];
    if (self.jiqianArray.count > 0) {
        [lunArray addObject:[self.jiqianArray objectAtIndex:self.currentLunshu]];
    }
    NSLog(@"第%ld轮",(self.currentLunshu + 1));
    [self.xianshiString appendFormat:@"\n第%ld轮\n",(self.currentLunshu + 1)];
    [self bisaikaishiWithArray:lunArray];
    
    [self.xianshiString appendFormat:@"\n第%ld轮",self.currentLunshu + 1];
    [self paiming];
    self.currentLunshu ++;
    self.textView.text = self.xianshiString;
}

-(void)endlun{
    if (self.currentLunshu >= self.allLunshu) {
        return;
    }
    for (; self.currentLunshu < self.allLunshu; ) {
        NSMutableArray *lunArray = [self.finalfinalAllLunArray objectAtIndex:self.currentLunshu];
        if (self.jiqianArray.count > 0) {
            [lunArray addObject:[self.jiqianArray objectAtIndex:self.currentLunshu]];
        }
        [self.xianshiString appendFormat:@"\n第%ld轮\n",(self.currentLunshu + 1)];
        [self bisaikaishiWithArray:lunArray];
        
        [self.xianshiString appendFormat:@"\n第%ld轮",self.currentLunshu + 1];
        [self paiming];
        self.currentLunshu ++;
    }
    
    self.textView.text = self.xianshiString;
}

-(void) bisaikaishiWithArray:(NSMutableArray *) array
{
    for (NSMutableArray *arr in array) {
        if (([[arr objectAtIndex:0] isKindOfClass:[NSString class]] || [[arr objectAtIndex:1] isKindOfClass:[NSString class]])) {
            if ([[arr objectAtIndex:0] isKindOfClass:[NSString class]]) {
                NSMutableDictionary *mdic2 = [arr objectAtIndex:1];
                [self.xianshiString appendFormat:@"本轮轮空球队：%@\n",[mdic2 valueForKey:@"city"]];
            }else{
                NSMutableDictionary *mdic1 = [arr objectAtIndex:0];
                [self.xianshiString appendFormat:@"本轮轮空球队：%@\n",[mdic1 valueForKey:@"city"]];
            }
            break;
        }
        
    }
    
    for (NSMutableArray *arr in array) {
        if (self.jiqianArray.count > 0 && [arr isEqualToArray:array.lastObject] && array.count > 2) {
            [self.xianshiString appendFormat:@"附加赛\n"];
        }
        
        if (!([[arr objectAtIndex:0] isKindOfClass:[NSString class]] || [[arr objectAtIndex:1] isKindOfClass:[NSString class]])) {
            NSMutableDictionary *mdic1 = [arr objectAtIndex:0];
            NSMutableDictionary *mdic2 = [arr objectAtIndex:1];
            NSMutableDictionary *dic21 = [CalculationGameTool biSaiJieGuoWithCity:[mdic1 valueForKey:@"city"] andCity:[mdic2 valueForKey:@"city"]];
            int fjifen = [[mdic1 valueForKey:@"jifen"] intValue] ,fjingqiu = [[mdic1 valueForKey:@"jingqiu"] intValue] ,fjingsheng = [[mdic1 valueForKey:@"jingshengqiu"] intValue],ffu = [[mdic1 valueForKey:@"fu"] intValue],fsheng = [[mdic1 valueForKey:@"sheng"] intValue],fping = [[mdic1 valueForKey:@"ping"] intValue] ;
            int sjifen = [[mdic2 valueForKey:@"jifen"] intValue] ,sjingqiu = [[mdic2 valueForKey:@"jingqiu"] intValue] ,sjingsheng = [[mdic2 valueForKey:@"jingshengqiu"] intValue],ssheng = [[mdic2 valueForKey:@"sheng"] intValue],sping = [[mdic2 valueForKey:@"ping"] intValue],sfu = [[mdic2 valueForKey:@"fu"] intValue] ;
            NSArray *arr21 = [dic21 valueForKey:@"typeArray"];
            [self.xianshiString appendFormat:@"%@",[dic21 valueForKey:@"rString"]];
            switch ([[arr21 objectAtIndex:0] integerValue]) {
                case 0:
                {
                    fjifen += 3;
                    fsheng += 1;
                    sfu += 1;
                }
                    break;
                case 1:
                {
                    fjifen += 1;
                    sjifen += 1;
                    fping += 1;
                    sping += 1;
                }
                    break;
                case 2:
                {
                    sjifen += 3;
                    ssheng += 1;
                    ffu += 1;
                }
                    break;
                    
                default:
                    break;
            }
            int changci1 = [[mdic1 valueForKey:@"changci"] intValue];
            int changci2 = [[mdic2 valueForKey:@"changci"] intValue];
            changci1++;
            changci2++;
            fjingqiu += [[arr21 objectAtIndex:1] integerValue];
            sjingqiu += [[arr21 objectAtIndex:2] integerValue];
            fjingsheng += ([[arr21 objectAtIndex:1] integerValue] - [[arr21 objectAtIndex:2] integerValue]);
            sjingsheng += ([[arr21 objectAtIndex:2] integerValue] - [[arr21 objectAtIndex:1] integerValue]);
            [mdic1 setValue:[NSNumber numberWithInt:fjifen] forKey:@"jifen"];
            [mdic1 setValue:[NSNumber numberWithInt:fjingsheng] forKey:@"jingshengqiu"];
            [mdic1 setValue:[NSNumber numberWithInt:fjingqiu] forKey:@"jingqiu"];
            [mdic1 setValue:[NSNumber numberWithInt:fsheng] forKey:@"sheng"];
            [mdic1 setValue:[NSNumber numberWithInt:fping] forKey:@"ping"];
            [mdic1 setValue:[NSNumber numberWithInt:ffu] forKey:@"fu"];
            [mdic1 setValue:[NSNumber numberWithInt:changci1] forKey:@"changci"];
            
            [mdic2 setValue:[NSNumber numberWithInt:sjifen] forKey:@"jifen"];
            [mdic2 setValue:[NSNumber numberWithInt:sjingsheng] forKey:@"jingshengqiu"];
            [mdic2 setValue:[NSNumber numberWithInt:sjingqiu] forKey:@"jingqiu"];
            [mdic2 setValue:[NSNumber numberWithInt:ssheng] forKey:@"sheng"];
            [mdic2 setValue:[NSNumber numberWithInt:sping] forKey:@"ping"];
            [mdic2 setValue:[NSNumber numberWithInt:sfu] forKey:@"fu"];
            [mdic2 setValue:[NSNumber numberWithInt:changci2] forKey:@"changci"];
        }
    }
}

-(void) paiming
{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.cansaiArray];
    if (self.lastDictionary) {
        [arr addObject:self.lastDictionary];
    }
    NSArray *arra = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDictionary *d1 = obj1;
        NSDictionary *d2 = obj2;
        NSInteger ji1 = [[d1 valueForKey:@"jifen"] integerValue];
        NSInteger ji2 = [[d2 valueForKey:@"jifen"] integerValue];
        NSComparisonResult result;
        if (ji1 > ji2) {
            result = NSOrderedAscending;
        }else{
            if (ji1 == ji2) {
                NSInteger jingsheng1 = [[d1 valueForKey:@"jingshengqiu"] integerValue];
                NSInteger jingsheng2 = [[d2 valueForKey:@"jingshengqiu"] integerValue];
                if (jingsheng1 > jingsheng2) {
                    result = NSOrderedAscending;
                }else{
                    if (jingsheng1 == jingsheng2) {
                        NSInteger jinqiushu1 = [[d1 valueForKey:@"jingqiu"] integerValue];
                        NSInteger jinqiushu2 = [[d2 valueForKey:@"jingqiu"] integerValue];
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
                result = NSOrderedDescending;
            }
        }
        return result;
    }];
    NSLog(@"第%ld轮积分排名",(self.currentLunshu + 1));
    [self.xianshiString appendFormat:@"积分排名\n"];
    for (int i = 0 ;i < arra.count; i++) {
        NSDictionary *d1 = [arra objectAtIndex:i];
        NSInteger diuqiu = [[d1 valueForKey:@"jingqiu"] integerValue] - [[d1 valueForKey:@"jingshengqiu"] integerValue];
        NSLog(@"%d、%@ %@胜 %@平 %@负 %@/%ld %@分",(i+1),[d1 valueForKey:@"city"],[d1 valueForKey:@"sheng"],[d1 valueForKey:@"ping"],[d1 valueForKey:@"fu"],[d1 valueForKey:@"jingqiu"],diuqiu,[d1 valueForKey:@"jifen"]);
        [self.xianshiString appendFormat:@"%d、%@ %@胜 %@平 %@负 %@/%ld %@分\n",(i+1),[d1 valueForKey:@"city"],[d1 valueForKey:@"sheng"],[d1 valueForKey:@"ping"],[d1 valueForKey:@"fu"],[d1 valueForKey:@"jingqiu"],diuqiu,[d1 valueForKey:@"jifen"]];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
