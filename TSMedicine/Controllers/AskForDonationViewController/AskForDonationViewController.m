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
    
     self.navigationController.navigationBarHidden=YES;
    
    
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,SCREEN_H- 64)];

    _webView.delegate=self;
   
    NSString *url=[NSString stringWithFormat:@"http://app.aixinland.cn/page/project_detail.html?from=app&dataId=8&userid=903050"];
  
    
    [_webView  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [_webView  sizeToFit];
    [self.view addSubview:_webView];
    
    
}
- (void)nextpageVC
{
    CommitAskForViewController *commitVC = [CommitAskForViewController new];
    [self.navigationController pushViewController:commitVC animated:YES];
    
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
