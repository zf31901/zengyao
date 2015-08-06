//
//  DocMyPatientViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-6.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DocMyPatientViewController.h"

@interface DocMyPatientViewController ()

@end

@implementation DocMyPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的患者";
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
