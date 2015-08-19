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
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,SCREEN_H)];
    
    _webView.delegate=self;
    
    NSString *url=[NSString stringWithFormat:@"http://app.aixinland.cn/page/project_detail.html?from=app&dataId=8&userid=903050"];
    
    
    [_webView  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [_webView  sizeToFit];
    [self.view addSubview:_webView];

}
-(void)setNavView
{
    self.navigationController.navigationBarHidden = YES;

    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlString = [[request URL] absoluteString];
    NSLog(@"urlString---  %@",urlString);
    if ([urlString rangeOfString:@"page/project_detail.html?objc_receive:Delete"].location != NSNotFound) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
    }
    return YES;
}

@end
