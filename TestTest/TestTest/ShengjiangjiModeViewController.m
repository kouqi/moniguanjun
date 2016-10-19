//
//  ShengjiangjiModeViewController.m
//  TestTest
//
//  Created by 程海峰 on 16/9/23.
//  Copyright © 2016年 海峰. All rights reserved.
//

#import "ShengjiangjiModeViewController.h"
#import "CalculationGameTool.h"
@interface ShengjiangjiModeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *jiajiTextView;
@property (weak, nonatomic) IBOutlet UITextView *yijiTextView;
@property(strong,nonatomic) NSMutableString *jiajixianshiString,*yijixianshiString;
@property(strong,nonatomic) NSMutableArray *jiajicansaiArray,*jiajifinalfinalAllLunArray,*yijicansaiArray,*yijifinalfinalAllLunArray;
@property (strong, nonatomic) NSMutableDictionary *jiajilastDictionary,*yijilastDictionary;
@property(assign, nonatomic) NSInteger jiayicurrentLunshu,jiajiallLunshu,yiyicurrentLunshu,yijiallLunshu;
@property(strong,nonatomic) NSMutableArray *jiajiAllQiuduiArray,*yijiAllQiuduiArray;
@property(assign, nonatomic) NSInteger jiangjiminge;
@end

@implementation ShengjiangjiModeViewController



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
    self.jiajixianshiString = [NSMutableString string];
    self.yijixianshiString = [NSMutableString string];
//    [self taotaiyizhi];
//    [self yitaotaiyizhi];
    if (self.allQiuduiArray.count % 2 != 0) {
        [self.allQiuduiArray removeLastObject];
    }
    if (self.allQiuduiArray.count <= 20) {
        self.jiangjiminge = 1;
    }else if (self.allQiuduiArray.count <= 38){
        self.jiangjiminge = 2;
    }else{
        self.jiangjiminge = 3;
    }
    NSInteger count = self.allQiuduiArray.count;
    self.yijicansaiArray = [NSMutableArray array];
    self.jiajicansaiArray = [NSMutableArray array];
    for (int i = 0; i < count/2; i++) {
        NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
        [mdic setValue:[self.allQiuduiArray objectAtIndex:i] forKey:@"city"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jifen"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jingshengqiu"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jingqiu"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"sheng"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"ping"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"fu"];
        [self.yijicansaiArray addObject:mdic];
        NSMutableDictionary *jmdic = [NSMutableDictionary dictionary];
        [jmdic setValue:[self.allQiuduiArray objectAtIndex:(i + count/2)] forKey:@"city"];
        [jmdic setValue:[NSNumber numberWithInt:0] forKey:@"jifen"];
        [jmdic setValue:[NSNumber numberWithInt:0] forKey:@"jingshengqiu"];
        [jmdic setValue:[NSNumber numberWithInt:0] forKey:@"jingqiu"];
        [jmdic setValue:[NSNumber numberWithInt:0] forKey:@"sheng"];
        [jmdic setValue:[NSNumber numberWithInt:0] forKey:@"ping"];
        [jmdic setValue:[NSNumber numberWithInt:0] forKey:@"fu"];
        [self.jiajicansaiArray addObject:jmdic];
    }
    [self doucanjia];
    [self yidoucanjia];
    // Do any additional setup after loading the view from its nib.
}

-(void) nextLun{
    if (self.jiayicurrentLunshu >= self.jiajiallLunshu) {
        return;
    }
    NSMutableArray *lunArray = [self.jiajifinalfinalAllLunArray objectAtIndex:self.jiayicurrentLunshu];
    NSLog(@"第%ld轮",(self.jiayicurrentLunshu + 1));
    [self.jiajixianshiString appendFormat:@"\n第%ld轮\n",(self.jiayicurrentLunshu + 1)];
    [self bisaikaishiWithArray:lunArray];
    
    [self.jiajixianshiString appendFormat:@"\n第%ld轮",self.jiayicurrentLunshu + 1];
    [self paimingwith:NO];
    self.jiayicurrentLunshu ++;
    self.jiajiTextView.text = self.jiajixianshiString;
    
    NSMutableArray *yilunArray = [self.yijifinalfinalAllLunArray objectAtIndex:self.yiyicurrentLunshu];
    NSLog(@"第%ld轮",(self.yiyicurrentLunshu + 1));
    [self.yijixianshiString appendFormat:@"\n第%ld轮\n",(self.yiyicurrentLunshu + 1)];
    [self yibisaikaishiWithArray:yilunArray];
    
    [self.yijixianshiString appendFormat:@"\n第%ld轮",self.yiyicurrentLunshu + 1];
    [self yipaimingwith:NO];
    self.yiyicurrentLunshu ++;
    self.yijiTextView.text = self.yijixianshiString;
}

-(void)endlun{
    if (self.jiayicurrentLunshu < self.jiajiallLunshu) {
        return;
    }
    [self paimingwith:YES];
    [self yipaimingwith:YES];
    NSMutableArray *shengjiArray = [NSMutableArray array];
    NSMutableArray *jiangjiArray = [NSMutableArray array];
    for (int i = 0; i < self.jiangjiminge; i++) {
        [shengjiArray addObject:self.yijicansaiArray.firstObject];
        [self.yijicansaiArray removeObjectAtIndex:0];
        [jiangjiArray addObject:self.jiajicansaiArray.lastObject];
        [self.jiajicansaiArray removeLastObject];
    }
    for (int i = 0; i < self.jiangjiminge; i++) {
        [self.yijicansaiArray addObject:[jiangjiArray objectAtIndex:i]];
        [self.jiajicansaiArray addObject:[shengjiArray objectAtIndex:i]];
    }
    for (NSMutableDictionary *mdic in self.jiajicansaiArray) {
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jifen"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jingshengqiu"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jingqiu"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"sheng"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"ping"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"fu"];
    }
    for (NSMutableDictionary *mdic in self.yijicansaiArray) {
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jifen"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jingshengqiu"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jingqiu"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"sheng"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"ping"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"fu"];
    }
    self.jiajixianshiString = [NSMutableString string];
    self.yijixianshiString = [NSMutableString string];
    [self doucanjia];
    [self yidoucanjia];
}


//TODO:甲级
-(NSString *) yuxuansaiWith:(NSString *) dio and:(NSString *) dit
{
    NSInteger fjinqiushu = 0,fkejin = 0;
    NSInteger sjinqiushu = 0,skejin = 0;
    
    NSMutableDictionary *dic12 = [CalculationGameTool biSaiJieGuoWithCity:dio andCity:dit];
    NSArray *arr12 = [dic12 valueForKey:@"typeArray"];
    [self.jiajixianshiString appendFormat:@"%@",[dic12 valueForKey:@"rString"]];
    fjinqiushu += [[arr12 objectAtIndex:1] integerValue];
    sjinqiushu += [[arr12 objectAtIndex:2] integerValue];
    skejin += [[arr12 objectAtIndex:2] integerValue];
    
    NSMutableDictionary *dic21 = [CalculationGameTool biSaiJieGuoWithCity:dit andCity:dio];
    NSArray *arr21 = [dic21 valueForKey:@"typeArray"];
    [self.jiajixianshiString appendFormat:@"%@",[dic21 valueForKey:@"rString"]];
    fjinqiushu += [[arr21 objectAtIndex:2] integerValue];
    fkejin += [[arr21 objectAtIndex:2] integerValue];
    sjinqiushu += [[arr21 objectAtIndex:1] integerValue];
    
    NSLog(@"总比分\n%@ %ld-%ld %@",dio,(long)fjinqiushu,(long)sjinqiushu,dit);
    [self.jiajixianshiString appendFormat:@"总比分\n%@ %ld-%ld %@\n",dio,(long)fjinqiushu,(long)sjinqiushu,dit];
    if (fjinqiushu > sjinqiushu) {
        [self.jiajixianshiString appendFormat:@"\n"];
        return dio;
    }else if (fjinqiushu < sjinqiushu){
        [self.jiajixianshiString appendFormat:@"\n"];
        return dit;
    }else{
        if (fkejin > skejin) {
            NSLog(@"%@客场进球多胜出\n",dio);
            [self.jiajixianshiString appendFormat:@"%@客场进球多胜出\n\n",dio];
            return dio;
        }else if (fkejin < skejin){
            NSLog(@"%@客场进球多胜出\n",dit);
            [self.jiajixianshiString appendFormat:@"%@客场进球多胜出\n\n",dit];
            return dit;
        }else{
            NSLog(@"重赛");
            [self.jiajixianshiString appendFormat:@"重赛\n"];
            return [self yuxuansaiWith:dio and:dit];
        }
    }
    
}

-(void) xiaoyufour{
    if (self.jiajicansaiArray.count == 1) {
        [self paimingwith:NO];
        self.jiajiTextView.text = self.jiajixianshiString;
        return;
    }
    NSMutableArray *diyisss = [NSMutableArray array];
    if (self.jiajicansaiArray.count % 2 != 0) {
        NSInteger index = arc4random() % self.jiajicansaiArray.count;
        self.jiajilastDictionary = [NSMutableDictionary dictionaryWithDictionary:[self.jiajicansaiArray objectAtIndex:index]];
        [self.jiajicansaiArray removeObjectAtIndex:index];
        
        NSMutableArray *shuju = [NSMutableArray array];
        for (int i = 0; i < self.jiajicansaiArray.count; i++) {
            NSMutableArray *sshuju = [NSMutableArray array];
            if (i % 2 == 0) {
                [sshuju addObject:self.jiajilastDictionary];
                [sshuju addObject:[self.jiajicansaiArray objectAtIndex:i]];
            }else{
                [sshuju addObject:[self.jiajicansaiArray objectAtIndex:i]];
                [sshuju addObject:self.jiajilastDictionary];
            }
            
            [shuju addObject:sshuju];
        }
        [diyisss addObject:shuju];
        NSMutableArray *shujus = [NSMutableArray array];
        for (int i = 0; i < self.jiajicansaiArray.count; i++) {
            NSMutableArray *sshuju = [NSMutableArray array];
            if (i % 2 != 0) {
                [sshuju addObject:self.jiajilastDictionary];
                [sshuju addObject:[self.jiajicansaiArray objectAtIndex:i]];
            }else{
                [sshuju addObject:[self.jiajicansaiArray objectAtIndex:i]];
                [sshuju addObject:self.jiajilastDictionary];
            }
            [shujus addObject:sshuju];
        }
        [diyisss addObject:shujus];
    }
    NSMutableArray *shujuss = [NSMutableArray array];
    NSMutableArray *sshuju1 = [NSMutableArray array];
    [sshuju1 addObject:[self.jiajicansaiArray objectAtIndex:0]];
    [sshuju1 addObject:[self.jiajicansaiArray objectAtIndex:1]];
    [shujuss addObject:sshuju1];
    NSMutableArray *sshuju2 = [NSMutableArray array];
    [sshuju2 addObject:[self.jiajicansaiArray objectAtIndex:1]];
    [sshuju2 addObject:[self.jiajicansaiArray objectAtIndex:0]];
    [shujuss addObject:sshuju2];
    
    [diyisss addObject:shujuss];
    for (int i = 0; i < diyisss.count; i++) {
        NSMutableArray *lunArray = [diyisss objectAtIndex:i];
        NSLog(@"赛前第%d轮",(i + 1));
        [self.jiajixianshiString appendFormat:@"\n赛前第%d轮\n",(i + 1)];
        [self bisaikaishiWithArray:lunArray];
    }
    [self paimingwith:NO];
    self.jiajiTextView.text = self.jiajixianshiString;
}

-(void) doucanjia{
    if (self.jiajicansaiArray.count < 4) {
        [self xiaoyufour];
        return;
    }
    if (self.jiajicansaiArray.count % 2 != 0) {
        NSInteger index = arc4random() % self.jiajicansaiArray.count;
        self.jiajilastDictionary = [NSMutableDictionary dictionaryWithDictionary:[self.jiajicansaiArray objectAtIndex:index]];
        [self.jiajicansaiArray removeObjectAtIndex:index];
        NSMutableArray *diyisss = [NSMutableArray array];
        NSMutableArray *shuju = [NSMutableArray array];
        for (int i = 0; i < self.jiajicansaiArray.count; i++) {
            NSMutableArray *sshuju = [NSMutableArray array];
            if (i % 2 == 0) {
                [sshuju addObject:self.jiajilastDictionary];
                [sshuju addObject:[self.jiajicansaiArray objectAtIndex:i]];
            }else{
                [sshuju addObject:[self.jiajicansaiArray objectAtIndex:i]];
                [sshuju addObject:self.jiajilastDictionary];
            }
            
            [shuju addObject:sshuju];
        }
        [diyisss addObject:shuju];
        NSMutableArray *shujus = [NSMutableArray array];
        for (int i = 0; i < self.jiajicansaiArray.count; i++) {
            NSMutableArray *sshuju = [NSMutableArray array];
            if (i % 2 != 0) {
                [sshuju addObject:self.jiajilastDictionary];
                [sshuju addObject:[self.jiajicansaiArray objectAtIndex:i]];
            }else{
                [sshuju addObject:[self.jiajicansaiArray objectAtIndex:i]];
                [sshuju addObject:self.jiajilastDictionary];
            }
            [shujus addObject:sshuju];
        }
        [diyisss addObject:shujus];
        for (int i = 0; i < diyisss.count; i++) {
            NSMutableArray *lunArray = [diyisss objectAtIndex:i];
            NSLog(@"赛前第%d轮",(i + 1));
            [self.jiajixianshiString appendFormat:@"\n赛前第%d轮\n",(i + 1)];
            [self bisaikaishiWithArray:lunArray];
        }
        [self lunshuduizhen];
        [self paimingwith:NO];
        self.jiajiTextView.text = self.jiajixianshiString;
    }else{
        [self lunshuduizhen];
        [self paimingwith:NO];
        self.jiajiTextView.text = self.jiajixianshiString;
    }
}

-(void) taotaiyizhi{
    if (self.allQiuduiArray.count % 2 != 0) {
        NSInteger index = arc4random() % self.allQiuduiArray.count;
        NSString *dio = [self.allQiuduiArray objectAtIndex:index];
        [self.allQiuduiArray removeObjectAtIndex:index];
        
        NSInteger indext = arc4random() % self.allQiuduiArray.count;
        NSString *dit = [self.allQiuduiArray objectAtIndex:indext];
        [self.allQiuduiArray removeObjectAtIndex:indext];
        NSLog(@"预选赛对阵：%@ VS %@",dio,dit);
        [self.jiajixianshiString appendFormat:@"预选赛对阵：%@ VS %@\n",dio,dit];
        [self.allQiuduiArray addObject:[self yuxuansaiWith:dio and:dit]];
        
    }
    self.jiajicansaiArray = [NSMutableArray array];
    for (NSString *city in self.allQiuduiArray) {
        NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
        [mdic setValue:city forKey:@"city"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jifen"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jingshengqiu"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jingqiu"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"sheng"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"ping"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"fu"];
        [self.jiajicansaiArray addObject:mdic];
    }
    [self lunshuduizhen];
    [self paimingwith:NO];
    self.jiajiTextView.text = self.jiajixianshiString;
}

-(void) lunshuduizhen
{
    NSMutableArray *fshuzu = [NSMutableArray array];
    NSMutableArray *lshuzu = [NSMutableArray array];
    NSMutableArray *theArray = [NSMutableArray arrayWithArray:self.jiajicansaiArray];
    for (int i = 0; i < (self.jiajicansaiArray.count) / 2; i++) {
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
    for (int i = 0; i < self.jiajicansaiArray.count - 1; i++) {
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
    for (int i = 0; i < (self.jiajicansaiArray.count / 2); i++) {
        [ffllarra addObject:[allLunArray objectAtIndex:i]];
        [allLunArray removeObject:[allLunArray objectAtIndex:i]];
        if ((i + 1) < (self.jiajicansaiArray.count / 2)) {
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
    for (int i = 0; i < self.jiajicansaiArray.count - 1; i++) {
        NSInteger index = arc4random() % ffllarra.count;
        [ffflllArra addObject:[ffllarra objectAtIndex:index]];
        [ffllarra removeObjectAtIndex:index];
        
        NSInteger indexs = arc4random() % ssllarra.count;
        [ssslllArra addObject:[ssllarra objectAtIndex:indexs]];
        [ssllarra removeObjectAtIndex:indexs];
    }
    
    
    
    self.jiajifinalfinalAllLunArray = [NSMutableArray array];
    [self.jiajifinalfinalAllLunArray addObjectsFromArray:ssslllArra];
    [self.jiajifinalfinalAllLunArray addObjectsFromArray:ffflllArra];
    self.jiayicurrentLunshu = 0;
    self.jiajiallLunshu = self.jiajifinalfinalAllLunArray.count;
    
}

-(void) bisaikaishiWithArray:(NSMutableArray *) array
{
    for (NSMutableArray *arr in array) {
        NSMutableDictionary *mdic1 = [arr objectAtIndex:0];
        NSMutableDictionary *mdic2 = [arr objectAtIndex:1];
        NSMutableDictionary *dic21 = [CalculationGameTool biSaiJieGuoWithCity:[mdic1 valueForKey:@"city"] andCity:[mdic2 valueForKey:@"city"]];
        int fjifen = [[mdic1 valueForKey:@"jifen"] intValue] ,fjingqiu = [[mdic1 valueForKey:@"jingqiu"] intValue] ,fjingsheng = [[mdic1 valueForKey:@"jingshengqiu"] intValue],ffu = [[mdic1 valueForKey:@"fu"] intValue],fsheng = [[mdic1 valueForKey:@"sheng"] intValue],fping = [[mdic1 valueForKey:@"ping"] intValue] ;
        int sjifen = [[mdic2 valueForKey:@"jifen"] intValue] ,sjingqiu = [[mdic2 valueForKey:@"jingqiu"] intValue] ,sjingsheng = [[mdic2 valueForKey:@"jingshengqiu"] intValue],ssheng = [[mdic2 valueForKey:@"sheng"] intValue],sping = [[mdic2 valueForKey:@"ping"] intValue],sfu = [[mdic2 valueForKey:@"fu"] intValue] ;
        NSArray *arr21 = [dic21 valueForKey:@"typeArray"];
        [self.jiajixianshiString appendFormat:@"%@",[dic21 valueForKey:@"rString"]];
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
        [mdic2 setValue:[NSNumber numberWithInt:sjifen] forKey:@"jifen"];
        [mdic2 setValue:[NSNumber numberWithInt:sjingsheng] forKey:@"jingshengqiu"];
        [mdic2 setValue:[NSNumber numberWithInt:sjingqiu] forKey:@"jingqiu"];
        [mdic2 setValue:[NSNumber numberWithInt:ssheng] forKey:@"sheng"];
        [mdic2 setValue:[NSNumber numberWithInt:sping] forKey:@"ping"];
        [mdic2 setValue:[NSNumber numberWithInt:sfu] forKey:@"fu"];
    }
}

-(void) paimingwith:(BOOL) init
{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.jiajicansaiArray];
    if (self.jiajilastDictionary) {
        [arr addObject:self.jiajilastDictionary];
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
    if (init) {
        self.jiajicansaiArray = [NSMutableArray arrayWithArray:arra];
    }else{
        NSLog(@"第%ld轮积分排名",(self.jiayicurrentLunshu + 1));
        [self.jiajixianshiString appendFormat:@"积分排名\n"];
        for (int i = 0 ;i < arra.count; i++) {
            NSDictionary *d1 = [arra objectAtIndex:i];
            NSInteger diuqiu = [[d1 valueForKey:@"jingqiu"] integerValue] - [[d1 valueForKey:@"jingshengqiu"] integerValue];
            NSLog(@"%d、%@ %@胜 %@平 %@负 %@/%ld %@分",(i+1),[d1 valueForKey:@"city"],[d1 valueForKey:@"sheng"],[d1 valueForKey:@"ping"],[d1 valueForKey:@"fu"],[d1 valueForKey:@"jingqiu"],diuqiu,[d1 valueForKey:@"jifen"]);
            [self.jiajixianshiString appendFormat:@"%d、%@ %@胜 %@平 %@负 %@/%ld %@分\n",(i+1),[d1 valueForKey:@"city"],[d1 valueForKey:@"sheng"],[d1 valueForKey:@"ping"],[d1 valueForKey:@"fu"],[d1 valueForKey:@"jingqiu"],diuqiu,[d1 valueForKey:@"jifen"]];
        }
    }
}

//TODO:乙级
-(NSString *) yiyuxuansaiWith:(NSString *) dio and:(NSString *) dit
{
    NSInteger fjinqiushu = 0,fkejin = 0;
    NSInteger sjinqiushu = 0,skejin = 0;
    
    NSMutableDictionary *dic12 = [CalculationGameTool biSaiJieGuoWithCity:dio andCity:dit];
    NSArray *arr12 = [dic12 valueForKey:@"typeArray"];
    [self.yijixianshiString appendFormat:@"%@",[dic12 valueForKey:@"rString"]];
    fjinqiushu += [[arr12 objectAtIndex:1] integerValue];
    sjinqiushu += [[arr12 objectAtIndex:2] integerValue];
    skejin += [[arr12 objectAtIndex:2] integerValue];
    
    NSMutableDictionary *dic21 = [CalculationGameTool biSaiJieGuoWithCity:dit andCity:dio];
    NSArray *arr21 = [dic21 valueForKey:@"typeArray"];
    [self.yijixianshiString appendFormat:@"%@",[dic21 valueForKey:@"rString"]];
    fjinqiushu += [[arr21 objectAtIndex:2] integerValue];
    fkejin += [[arr21 objectAtIndex:2] integerValue];
    sjinqiushu += [[arr21 objectAtIndex:1] integerValue];
    
    NSLog(@"总比分\n%@ %ld-%ld %@",dio,(long)fjinqiushu,(long)sjinqiushu,dit);
    [self.yijixianshiString appendFormat:@"总比分\n%@ %ld-%ld %@\n",dio,(long)fjinqiushu,(long)sjinqiushu,dit];
    if (fjinqiushu > sjinqiushu) {
        [self.yijixianshiString appendFormat:@"\n"];
        return dio;
    }else if (fjinqiushu < sjinqiushu){
        [self.yijixianshiString appendFormat:@"\n"];
        return dit;
    }else{
        if (fkejin > skejin) {
            NSLog(@"%@客场进球多胜出\n",dio);
            [self.yijixianshiString appendFormat:@"%@客场进球多胜出\n\n",dio];
            return dio;
        }else if (fkejin < skejin){
            NSLog(@"%@客场进球多胜出\n",dit);
            [self.yijixianshiString appendFormat:@"%@客场进球多胜出\n\n",dit];
            return dit;
        }else{
            NSLog(@"重赛");
            [self.yijixianshiString appendFormat:@"重赛\n"];
            return [self yiyuxuansaiWith:dio and:dit];
        }
    }
    
}

-(void) yixiaoyufour{
    if (self.yijicansaiArray.count == 1) {
        [self yipaimingwith:NO];
        self.yijiTextView.text = self.yijixianshiString;
        return;
    }
    NSMutableArray *diyisss = [NSMutableArray array];
    if (self.yijicansaiArray.count % 2 != 0) {
        NSInteger index = arc4random() % self.yijicansaiArray.count;
        self.yijilastDictionary = [NSMutableDictionary dictionaryWithDictionary:[self.yijicansaiArray objectAtIndex:index]];
        [self.yijicansaiArray removeObjectAtIndex:index];
        
        NSMutableArray *shuju = [NSMutableArray array];
        for (int i = 0; i < self.yijicansaiArray.count; i++) {
            NSMutableArray *sshuju = [NSMutableArray array];
            if (i % 2 == 0) {
                [sshuju addObject:self.yijilastDictionary];
                [sshuju addObject:[self.yijicansaiArray objectAtIndex:i]];
            }else{
                [sshuju addObject:[self.yijicansaiArray objectAtIndex:i]];
                [sshuju addObject:self.yijilastDictionary];
            }
            
            [shuju addObject:sshuju];
        }
        [diyisss addObject:shuju];
        NSMutableArray *shujus = [NSMutableArray array];
        for (int i = 0; i < self.yijicansaiArray.count; i++) {
            NSMutableArray *sshuju = [NSMutableArray array];
            if (i % 2 != 0) {
                [sshuju addObject:self.yijilastDictionary];
                [sshuju addObject:[self.yijicansaiArray objectAtIndex:i]];
            }else{
                [sshuju addObject:[self.yijicansaiArray objectAtIndex:i]];
                [sshuju addObject:self.yijilastDictionary];
            }
            [shujus addObject:sshuju];
        }
        [diyisss addObject:shujus];
    }
    NSMutableArray *shujuss = [NSMutableArray array];
    NSMutableArray *sshuju1 = [NSMutableArray array];
    [sshuju1 addObject:[self.yijicansaiArray objectAtIndex:0]];
    [sshuju1 addObject:[self.yijicansaiArray objectAtIndex:1]];
    [shujuss addObject:sshuju1];
    NSMutableArray *sshuju2 = [NSMutableArray array];
    [sshuju2 addObject:[self.yijicansaiArray objectAtIndex:1]];
    [sshuju2 addObject:[self.yijicansaiArray objectAtIndex:0]];
    [shujuss addObject:sshuju2];
    
    [diyisss addObject:shujuss];
    for (int i = 0; i < diyisss.count; i++) {
        NSMutableArray *lunArray = [diyisss objectAtIndex:i];
        NSLog(@"赛前第%d轮",(i + 1));
        [self.yijixianshiString appendFormat:@"\n赛前第%d轮\n",(i + 1)];
        [self yibisaikaishiWithArray:lunArray];
    }
    [self yipaimingwith:NO];
    self.yijiTextView.text = self.yijixianshiString;
}

-(void) yidoucanjia{
    if (self.yijicansaiArray.count < 4) {
        [self yixiaoyufour];
        return;
    }
    if (self.yijicansaiArray.count % 2 != 0) {
        NSInteger index = arc4random() % self.yijicansaiArray.count;
        self.yijilastDictionary = [NSMutableDictionary dictionaryWithDictionary:[self.yijicansaiArray objectAtIndex:index]];
        [self.yijicansaiArray removeObjectAtIndex:index];
        NSMutableArray *diyisss = [NSMutableArray array];
        NSMutableArray *shuju = [NSMutableArray array];
        for (int i = 0; i < self.yijicansaiArray.count; i++) {
            NSMutableArray *sshuju = [NSMutableArray array];
            if (i % 2 == 0) {
                [sshuju addObject:self.yijilastDictionary];
                [sshuju addObject:[self.yijicansaiArray objectAtIndex:i]];
            }else{
                [sshuju addObject:[self.yijicansaiArray objectAtIndex:i]];
                [sshuju addObject:self.yijilastDictionary];
            }
            
            [shuju addObject:sshuju];
        }
        [diyisss addObject:shuju];
        NSMutableArray *shujus = [NSMutableArray array];
        for (int i = 0; i < self.yijicansaiArray.count; i++) {
            NSMutableArray *sshuju = [NSMutableArray array];
            if (i % 2 != 0) {
                [sshuju addObject:self.yijilastDictionary];
                [sshuju addObject:[self.yijicansaiArray objectAtIndex:i]];
            }else{
                [sshuju addObject:[self.yijicansaiArray objectAtIndex:i]];
                [sshuju addObject:self.yijilastDictionary];
            }
            [shujus addObject:sshuju];
        }
        [diyisss addObject:shujus];
        for (int i = 0; i < diyisss.count; i++) {
            NSMutableArray *lunArray = [diyisss objectAtIndex:i];
            NSLog(@"赛前第%d轮",(i + 1));
            [self.yijixianshiString appendFormat:@"\n赛前第%d轮\n",(i + 1)];
            [self yibisaikaishiWithArray:lunArray];
        }
        [self yilunshuduizhen];
        [self yipaimingwith:NO];
        self.yijiTextView.text = self.yijixianshiString;
    }else{
        [self yilunshuduizhen];
        [self yipaimingwith:NO];
        self.yijiTextView.text = self.yijixianshiString;
    }
}

-(void) yitaotaiyizhi{
    if (self.allQiuduiArray.count % 2 != 0) {
        NSInteger index = arc4random() % self.allQiuduiArray.count;
        NSString *dio = [self.allQiuduiArray objectAtIndex:index];
        [self.allQiuduiArray removeObjectAtIndex:index];
        
        NSInteger indext = arc4random() % self.allQiuduiArray.count;
        NSString *dit = [self.allQiuduiArray objectAtIndex:indext];
        [self.allQiuduiArray removeObjectAtIndex:indext];
        NSLog(@"预选赛对阵：%@ VS %@",dio,dit);
        [self.yijixianshiString appendFormat:@"预选赛对阵：%@ VS %@\n",dio,dit];
        [self.allQiuduiArray addObject:[self yiyuxuansaiWith:dio and:dit]];
        
    }
    self.yijicansaiArray = [NSMutableArray array];
    for (NSString *city in self.allQiuduiArray) {
        NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
        [mdic setValue:city forKey:@"city"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jifen"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jingshengqiu"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"jingqiu"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"sheng"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"ping"];
        [mdic setValue:[NSNumber numberWithInt:0] forKey:@"fu"];
        [self.yijicansaiArray addObject:mdic];
    }
    [self yilunshuduizhen];
    [self yipaimingwith:NO];
    self.yijiTextView.text = self.yijixianshiString;
}

-(void) yilunshuduizhen
{
    NSMutableArray *fshuzu = [NSMutableArray array];
    NSMutableArray *lshuzu = [NSMutableArray array];
    NSMutableArray *theArray = [NSMutableArray arrayWithArray:self.yijicansaiArray];
    for (int i = 0; i < (self.yijicansaiArray.count) / 2; i++) {
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
    for (int i = 0; i < self.yijicansaiArray.count - 1; i++) {
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
    for (int i = 0; i < (self.yijicansaiArray.count / 2); i++) {
        [ffllarra addObject:[allLunArray objectAtIndex:i]];
        [allLunArray removeObject:[allLunArray objectAtIndex:i]];
        if ((i + 1) < (self.yijicansaiArray.count / 2)) {
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
    for (int i = 0; i < self.yijicansaiArray.count - 1; i++) {
        NSInteger index = arc4random() % ffllarra.count;
        [ffflllArra addObject:[ffllarra objectAtIndex:index]];
        [ffllarra removeObjectAtIndex:index];
        
        NSInteger indexs = arc4random() % ssllarra.count;
        [ssslllArra addObject:[ssllarra objectAtIndex:indexs]];
        [ssllarra removeObjectAtIndex:indexs];
    }
    
    
    
    self.yijifinalfinalAllLunArray = [NSMutableArray array];
    [self.yijifinalfinalAllLunArray addObjectsFromArray:ssslllArra];
    [self.yijifinalfinalAllLunArray addObjectsFromArray:ffflllArra];
    self.yiyicurrentLunshu = 0;
    self.yijiallLunshu = self.yijifinalfinalAllLunArray.count;
}

-(void) yibisaikaishiWithArray:(NSMutableArray *) array
{
    for (NSMutableArray *arr in array) {
        NSMutableDictionary *mdic1 = [arr objectAtIndex:0];
        NSMutableDictionary *mdic2 = [arr objectAtIndex:1];
        NSMutableDictionary *dic21 = [CalculationGameTool biSaiJieGuoWithCity:[mdic1 valueForKey:@"city"] andCity:[mdic2 valueForKey:@"city"]];
        int fjifen = [[mdic1 valueForKey:@"jifen"] intValue] ,fjingqiu = [[mdic1 valueForKey:@"jingqiu"] intValue] ,fjingsheng = [[mdic1 valueForKey:@"jingshengqiu"] intValue],ffu = [[mdic1 valueForKey:@"fu"] intValue],fsheng = [[mdic1 valueForKey:@"sheng"] intValue],fping = [[mdic1 valueForKey:@"ping"] intValue] ;
        int sjifen = [[mdic2 valueForKey:@"jifen"] intValue] ,sjingqiu = [[mdic2 valueForKey:@"jingqiu"] intValue] ,sjingsheng = [[mdic2 valueForKey:@"jingshengqiu"] intValue],ssheng = [[mdic2 valueForKey:@"sheng"] intValue],sping = [[mdic2 valueForKey:@"ping"] intValue],sfu = [[mdic2 valueForKey:@"fu"] intValue] ;
        NSArray *arr21 = [dic21 valueForKey:@"typeArray"];
        [self.yijixianshiString appendFormat:@"%@",[dic21 valueForKey:@"rString"]];
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
        [mdic2 setValue:[NSNumber numberWithInt:sjifen] forKey:@"jifen"];
        [mdic2 setValue:[NSNumber numberWithInt:sjingsheng] forKey:@"jingshengqiu"];
        [mdic2 setValue:[NSNumber numberWithInt:sjingqiu] forKey:@"jingqiu"];
        [mdic2 setValue:[NSNumber numberWithInt:ssheng] forKey:@"sheng"];
        [mdic2 setValue:[NSNumber numberWithInt:sping] forKey:@"ping"];
        [mdic2 setValue:[NSNumber numberWithInt:sfu] forKey:@"fu"];
    }
}

-(void) yipaimingwith:(BOOL) init
{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.yijicansaiArray];
    if (self.yijilastDictionary) {
        [arr addObject:self.yijilastDictionary];
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
    if (init) {
        self.yijicansaiArray = [NSMutableArray arrayWithArray:arra];
    }else{
        NSLog(@"第%ld轮积分排名",(self.yiyicurrentLunshu + 1));
        [self.yijixianshiString appendFormat:@"积分排名\n"];
        for (int i = 0 ;i < arra.count; i++) {
            NSDictionary *d1 = [arra objectAtIndex:i];
            NSInteger diuqiu = [[d1 valueForKey:@"jingqiu"] integerValue] - [[d1 valueForKey:@"jingshengqiu"] integerValue];
            NSLog(@"%d、%@ %@胜 %@平 %@负 %@/%ld %@分",(i+1),[d1 valueForKey:@"city"],[d1 valueForKey:@"sheng"],[d1 valueForKey:@"ping"],[d1 valueForKey:@"fu"],[d1 valueForKey:@"jingqiu"],diuqiu,[d1 valueForKey:@"jifen"]);
            [self.yijixianshiString appendFormat:@"%d、%@ %@胜 %@平 %@负 %@/%ld %@分\n",(i+1),[d1 valueForKey:@"city"],[d1 valueForKey:@"sheng"],[d1 valueForKey:@"ping"],[d1 valueForKey:@"fu"],[d1 valueForKey:@"jingqiu"],diuqiu,[d1 valueForKey:@"jifen"]];
        }
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
