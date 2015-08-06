//
//  MyTSMFeedBackViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-6.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyTSMFeedBackViewController.h"

@interface MyTSMFeedBackViewController ()

@end

@implementation MyTSMFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"意见反馈";
    
    _feedBackTextView.backgroundColor = [UIColor redColor];
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
