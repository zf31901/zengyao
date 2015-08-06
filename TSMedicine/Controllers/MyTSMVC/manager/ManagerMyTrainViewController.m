//
//  ManagerMyTrainViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-6.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "ManagerMyTrainViewController.h"

@interface ManagerMyTrainViewController ()

@end

@implementation ManagerMyTrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的培训";
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
