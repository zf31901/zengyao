//
//  AskForDonationViewController.m
//  TSMedicine
//
//  Created by lyy on 15-6-19.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "AskForDonationViewController.h"
#import "COMmitAskfor.h"

#define URLisr @"http://app.aixinland.cn//page/notice_detail"

@interface AskForDonationViewController ()<UIWebViewDelegate>
{
 UIWebView *_webView;

}
@end

@implementation AskForDonationViewController

- (void)viewDidLoad { 
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.title = @"申请捐助";
 //   self.askForDonation_nextpageBtn.layer.borderWidth = 1;
    //self.askForDonation_nextpageBtn.layer.borderColor = RGB(159,115,230).CGColor;
  //  self.askForDonation_nextpageBtn.layer.cornerRadius = 4;
   // self.askForDonation_nextpageBtn.layer.masksToBounds = YES;
    
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
    //SCREEN_H- TOPBAR- BOTTOMBAR
    _webView.delegate=self;
   
    NSString *url=[NSString stringWithFormat:@"%@",URLisr];
    NSLog(@"url1234------%@",url);
    
    [_webView  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [_webView  sizeToFit];
    [self.view addSubview:_webView];

    
    
   // [self.askForDonation_nextpageBtn addTarget:self action:@selector(nextpageVC) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void)nextpageVC
{
    COMmitAskfor *commitVC = [COMmitAskfor new];
    [self.navigationController pushViewController:commitVC animated:YES];
    
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
