//
//  AppprogressViewController.m
//  TSMedicine
//
//  Created by 123 on 15/8/7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "AppprogressViewController.h"

@interface AppprogressViewController ()

@end

@implementation AppprogressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    [self setNavlable];
    
}
-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的申请";
}
-(void)setNavlable{

    
    UIButton *btn = [UIButton buttonWithType:0];
    
    btn.frame = CGRectMake(320, 0, 60, 120);
    [btn setTitle:@"项目详情" forState:0];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(nextpageVC) forControlEvents:UIControlEventTouchUpInside];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0,40);
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -23, 0, 0);
}
- (void)nextpageVC
{
//    CommitAskForViewController *commitVC = [CommitAskForViewController new];
//    [self.navigationController pushViewController:commitVC animated:YES];
    
}


@end
