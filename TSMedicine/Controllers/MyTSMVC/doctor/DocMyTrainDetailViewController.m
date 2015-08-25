//
//  DocMyTrainDetailViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-11.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DocMyTrainDetailViewController.h"

@interface DocMyTrainDetailViewController () <UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation DocMyTrainDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    
    [self loadWebView];
    [self createNavView];
    
    
    
    

}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = YES;
//    self.title = @"培训详情";
}
-(void)loadWebView
{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, StatusBar_Height, SCREEN_W,SCREEN_H)];
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    
    NSString *url = [NSString stringWithFormat:@"http://app.aixinland.cn/page/train_detail.html?from=app&dataId=%@&userid=%@",_model.tid,UserInfoData.im];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [_webView  sizeToFit];
    [self.view addSubview:_webView];
    
}

#pragma mark --------------UIWebViewDelegate----------------
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlString = [[request URL] absoluteString];
    NSLog(@"urlString ==== %@",urlString);
    if ([urlString rangeOfString:@"page/train_detail.html?objc_receive:Delete"].location != NSNotFound) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
