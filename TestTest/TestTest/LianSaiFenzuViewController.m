//
//  LianSaiFenzuViewController.m
//  TestTest
//
//  Created by 程海峰 on 16/9/9.
//  Copyright © 2016年 海峰. All rights reserved.
//

#import "LianSaiFenzuViewController.h"
#import "CalculationGameTool.h"
#import "LianSaiJingxingshiViewController.h"
#import "ShengjiangjiModeViewController.h"
#import "ShijiebeiModeViewController.h"
@interface LianSaiFenzuViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *xiaozuArray;
@property (weak, nonatomic) IBOutlet UISwitch *shengjiangjiSwitch;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (assign, nonatomic) BOOL isShengjiangji;
@property (assign, nonatomic)BOOL isShiJieBeiMode;
@end

@implementation LianSaiFenzuViewController
- (IBAction)shengjiangji:(UISwitch *)sender {
    self.isShengjiangji = sender.on;
}
- (IBAction)shijiebei:(UISwitch *)sender {
    self.isShiJieBeiMode = sender.on;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    if (self.allQiuduiArray.count <= 50) {
        self.shengjiangjiSwitch.hidden = NO;
//    }
    self.title = @"联赛分组";
    self.isShengjiangji = NO;
    self.isShiJieBeiMode = NO;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tapBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbu = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barbu;
        // Do any additional setup after loading the view from its nib.
}
- (IBAction)tapFenzuButton:(UIButton *)sender {
    if (!self.isShengjiangji) {
        NSInteger fenzuNumber = [self.numberTextField.text integerValue];
        if (fenzuNumber == 0) {
            if (self.isShiJieBeiMode) {
                fenzuNumber = 32;
            }else{
                fenzuNumber = 20;
            }
            
        }
        self.xiaozuArray = [NSMutableArray arrayWithArray:[CalculationGameTool fenzuArrayWithAllArray:self.allQiuduiArray andArrayNumber:fenzuNumber]];
        [self.tableView reloadData];
    }else{
        NSInteger fenzuNumber = [self.numberTextField.text integerValue];
        if (fenzuNumber == 0) {
            if (self.isShiJieBeiMode) {
                fenzuNumber = 32;
            }else{
                fenzuNumber = 20;
            }
        }
        self.xiaozuArray = [NSMutableArray arrayWithArray:[CalculationGameTool fenzuArrayWithAllArray:self.allQiuduiArray andArrayNumber:fenzuNumber]];
        [self.tableView reloadData];
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
- (IBAction)tapBack:(UIButton *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.xiaozuArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"联赛%ld",indexPath.row + 1];
    NSArray *shuzuArray = [self.xiaozuArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [shuzuArray objectAtIndex:0];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isShiJieBeiMode) {
        NSArray *shuzuArray = [self.xiaozuArray objectAtIndex:indexPath.row];
        ShijiebeiModeViewController *llllsvc = [[ShijiebeiModeViewController alloc] initWithNibName:@"ShijiebeiModeViewController" bundle:nil];
        llllsvc.cansaiArray = [NSMutableArray arrayWithArray:shuzuArray];
        [self.navigationController pushViewController:llllsvc animated:YES];
    }else{
        if (self.isShengjiangji) {
            NSArray *shuzuArray = [self.xiaozuArray objectAtIndex:indexPath.row];
            ShengjiangjiModeViewController *llllsvc = [[ShengjiangjiModeViewController alloc] initWithNibName:@"ShengjiangjiModeViewController" bundle:nil];
            llllsvc.allQiuduiArray = [NSMutableArray arrayWithArray:shuzuArray];
            [self.navigationController pushViewController:llllsvc animated:YES];
        }else{
            NSArray *shuzuArray = [self.xiaozuArray objectAtIndex:indexPath.row];
            LianSaiJingxingshiViewController *llllsvc = [[LianSaiJingxingshiViewController alloc] initWithNibName:@"LianSaiJingxingshiViewController" bundle:nil];
            llllsvc.allQiuduiArray = [NSMutableArray arrayWithArray:shuzuArray];
            [self.navigationController pushViewController:llllsvc animated:YES];
        }
    }
    
}

@end
