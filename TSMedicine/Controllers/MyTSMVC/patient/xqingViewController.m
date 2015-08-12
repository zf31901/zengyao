//
//  xqingViewController.m
//  TSMedicine
//
//  Created by 123 on 15/8/12.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "xqingViewController.h"
#define htmlURL @"http://app.aixinland.cn/page/project_detail?dataId="
@interface xqingViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation xqingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,SCREEN_H - 64)];
    
    NSString *url=[NSString stringWithFormat:@"%@",htmlURL];
    NSLog(@"url1234------%@",url);
    
    
    [_webView  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [_webView  sizeToFit];
    [self.view addSubview:_webView];
    

}
-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;

    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
