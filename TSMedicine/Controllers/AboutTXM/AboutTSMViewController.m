//
//  AboutTSMViewController.m
//  TSMedicine
//
//  Created by lyy on 15-6-12.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "AboutTSMViewController.h"

@interface AboutTSMViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *about_imgView;

@end

@implementation AboutTSMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"关于我们";
    self.about_imgView.layer.cornerRadius = 10;
    self.about_imgView.layer.masksToBounds = YES;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
