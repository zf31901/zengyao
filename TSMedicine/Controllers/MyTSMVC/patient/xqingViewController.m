//
//  xqingViewController.m
//  TSMedicine
//
//  Created by 123 on 15/8/12.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "xqingViewController.h"
#import "MyquestionViewController.h"
#define htmlURL @"http://app.aixinland.cn/page/project_detail?dataId="
@interface xqingViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation xqingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    [self createNavView];
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, StatusBar_Height, SCREEN_W,SCREEN_H-StatusBar_Height)];
    
    _webView.delegate=self;
    
    NSString *url=[NSString stringWithFormat:@"http://app.aixinland.cn/page/userproject_detail.html?dataId=%@&userid=903050",_model.uppid];

    NSLog(@"_model.upid123--%@",_model.uppid);
    
    [_webView  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [_webView  sizeToFit];
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
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
    if ([urlString rangeOfString:@"page/userproject_detail.html?objc_receive:Delete"].location != NSNotFound) {
        [self.navigationController popViewControllerAnimated:YES];
    }    else if([urlString rangeOfString:@"/page/userproject_detail.html?objc_receive:Answers"].location != NSNotFound){
        
        MyquestionViewController *VC=[[MyquestionViewController alloc]init];
        if (_model) {
            
             VC.model = _model;
            VC.isWeb = YES;
             [self.navigationController pushViewController:VC animated:YES];
        }
    }
    else {
        
        
    }

    return YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}
@end
