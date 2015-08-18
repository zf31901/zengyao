//
//  CanonFormViewController.m
//  TSMedicine
//
//  Created by 123 on 15/8/12.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "CanonFormViewController.h"

@interface CanonFormViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    
}
@end

@implementation CanonFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,SCREEN_H- 64)];
    
    _webView.delegate=self;
    
 
    NSString *url=[NSString stringWithFormat:@"http://app.aixinland.cn/page/paradigm_list.html?from=app&dataid=%@",_model.upid];
    
    
    [_webView  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [_webView  sizeToFit];
    [self.view addSubview:_webView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlString = [[request URL] absoluteString];
    NSLog(@"urlString---  %@",urlString);
    
    if ([urlString rangeOfString:@"page/paradigm_list.html?objc_receive:Delete"].location != NSNotFound) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
    }
    return YES;
}



@end
