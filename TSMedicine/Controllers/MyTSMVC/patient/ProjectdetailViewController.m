//
//  ProjectdetailViewController.m
//  TSMedicine
//
//  Created by 123 on 15/8/7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "ProjectdetailViewController.h"
#define URLisr @"http://app.aixinland.cn//page/apply_success"

@interface ProjectdetailViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    
}
@end

@implementation ProjectdetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self webviewlable];
}
-(void)webviewlable{

    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,SCREEN_H- 64)];
    //SCREEN_H- TOPBAR- BOTTOMBAR
    _webView.delegate=self;
    
    NSString *url=[NSString stringWithFormat:@"%@",URLisr];
    NSLog(@"url1234------%@",url);
    
    [_webView  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [_webView  sizeToFit];
    [self.view addSubview:_webView];
    



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
