//
//  AskForDonationViewController.m
//  TSMedicine
//
//  Created by lyy on 15-6-19.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "AskForDonationViewController.h"
#import "CommitAskForViewController.h"

#define URLisr @"http://app.aixinland.cn//page/notice_detail?datald="

@interface AskForDonationViewController ()<UIWebViewDelegate>
{
 UIWebView *_webView;

}
@end

@implementation AskForDonationViewController

- (void)viewDidLoad { 
    [super viewDidLoad];
    
    
    UIButton *btn = [UIButton buttonWithType:0];
    
    btn.frame = CGRectMake(320, 0, 60, 120);
    [btn setTitle:@"申请捐助" forState:0];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(nextpageVC) forControlEvents:UIControlEventTouchUpInside];
   btn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0,40);
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -23, 0, 0);
    
    
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,SCREEN_H- 64)];

    _webView.delegate=self;
   
    NSString *url=[NSString stringWithFormat:@"http://app.aixinland.cn//page/project_detail.html?from=app&dataId=%@",_model.pid];
  
    
    [_webView  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [_webView  sizeToFit];
    [self.view addSubview:_webView];
    
    
}
- (void)nextpageVC
{
    CommitAskForViewController *commitVC = [CommitAskForViewController new];
    [self.navigationController pushViewController:commitVC animated:YES];
    
}


@end
