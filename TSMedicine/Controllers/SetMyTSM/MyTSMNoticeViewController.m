//
//  MyTSMNoticeViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-5.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyTSMNoticeViewController.h"

#define htmlURL @"http://app.aixinland.cn/page/notice_list.html?from=app&userid=%@"

@interface MyTSMNoticeViewController () <UIWebViewDelegate,UIScrollViewDelegate>
{
    UIWebView *_webView;
    
}
@end

@implementation MyTSMNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setNavView];
    [self loadWebView];
    
    [self createNavView];
    
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = YES;
    self.title = @"系统通知";
}
-(void)loadWebView
{
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, StatusBar_Height, SCREEN_W,SCREEN_H - StatusBar_Height)];
    [_webView  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:htmlURL,UserInfoData.im]]]];
    [_webView  sizeToFit];
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    [self.view addSubview:_webView];
}
#pragma mark --------------UIWebViewDelegate----------------
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlString = [[request URL] absoluteString];
    NSLog(@"urlString ==== %@",urlString);
    if ([urlString rangeOfString:@"page/notice_list.html?objc_receive:Delete"].location != NSNotFound) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
    }
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
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
