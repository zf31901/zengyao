//
//  ReportViewContrlller.m
//  TSMedicine
//
//  Created by lyy on 15-6-26.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "ReportViewContrlller.h"

@interface ReportViewContrlller ()

@end

@implementation ReportViewContrlller

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setNavView];
   
}

-(void)setNavView
{
    self.title = @"举报患者";
    [self buidRightBtn:@"提交"];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [WITool hideAllKeyBoard];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
