//
//  DetailsViewController.m
//  TSMedicine
//
//  Created by 123 on 15/7/29.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DetailsViewController.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "NewsViewController.h"


#define URLisr @"http://app.aixinland.cn//page/news_detail.html?from=app&dataId="

#define URLisr1 @"http://news.163.com/15/0813/17/B0TPM7R70001124J.html"


@interface DetailsViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    UIWebView *_webView;
    UIScrollView *_scrollview;
    NSMutableArray *_dataArr;
    NSString *terr;
}


@end

@implementation DetailsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
       self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr=[[NSMutableArray alloc]init];
    self.navigationController.navigationBarHidden=YES;
    [self UIlable];
 
    
}

-(void)UIlable{
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,SCREEN_H)];

    _webView.delegate=self;
    _webView.dataDetectorTypes=UIDataDetectorTypeLink;
    NSString *url=[NSString stringWithFormat:@"%@%@",URLisr,_model];
    NSLog(@"url1234------%@",url);
   
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

    if ([urlString rangeOfString:@"page/news_detail.html?objc_receive:Delete"].location != NSNotFound) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if
        (navigationType == UIWebViewNavigationTypeLinkClicked )
    {
         [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    else{
    
    
    }
    return YES;
}


@end
