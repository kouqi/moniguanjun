//
//  TodayViewController.m
//  TestWidget
//
//  Created by 程海峰 on 2016/12/26.
//  Copyright © 2016年 海峰. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)openURLContainingAPP{
    //通过extensionContext借助host app调起app
    [self.extensionContext openURL:[NSURL URLWithString:@"zhengbasai://ios=1&android=2"] completionHandler:^(BOOL success) {
        NSLog(@"open url result:%d",success);
    }];
}
- (IBAction)tapButton:(UIButton *)sender {
    [self openURLContainingAPP];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
