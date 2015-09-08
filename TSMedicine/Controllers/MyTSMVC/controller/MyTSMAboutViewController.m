//
//  MyTSMAboutViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-24.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyTSMAboutViewController.h"

@interface MyTSMAboutViewController ()

@property (nonatomic,strong) WIBaseImageView *iconImageView;
@property (nonatomic,strong) WIBaseLabel *versionLab;
@property (nonatomic,strong) WIBaseLabel *phoneLab;
@property (nonatomic,strong) WIBaseLabel *companyLab;

@end

@implementation MyTSMAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    
    [self loadData];
    
}

-(void)setNavView
{
    self.title = @"关于我们";
}

-(void)creatUIWithDataDic:(NSDictionary *)dataDic
{
//    _iconImageView = [WIBaseImageView createClassWithFrame:CGRectMake((ScreenWidth - 60)/2, 50, 60, 60) andWithImg:@"icon180.png" andWithTag:0 andWithEnable:YES];
    
    _iconImageView = [WIBaseImageView createClassNetWorkWithFrame:CGRectMake((ScreenWidth - 60)/2, 50, 60, 60) andWithUrlImg:dataDic[@"logo"] andPlaceholderImage:@"icon180.png" andWithTag:0 andWithEnable:YES];
    [_iconImageView makeCorner:5];
    [self.view addSubview:_iconImageView];
    
    _versionLab = [WIBaseLabel createClassWithTitle:[NSString stringWithFormat:@"%@ V%@",dataDic[@"packageName"],dataDic[@"versionName"]] andWithFrame:CGRectMake((ScreenWidth - 280)/2, _iconImageView.maxY + 10, 280, 20) andWithFont:17.0];
    _versionLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_versionLab];
    
    _phoneLab = [WIBaseLabel createClassWithTitle:[NSString stringWithFormat:@"客服热线：%@",dataDic[@"phone"]] andWithFrame:CGRectMake((ScreenWidth - 300)/2, ScreenHeight - 150, 300, 20) andWithFont:17.0];
    _phoneLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_phoneLab];
    
    _companyLab = [WIBaseLabel createClassWithTitle:[NSString stringWithFormat:@"%@",dataDic[@"company"]] andWithFrame:CGRectMake((ScreenWidth - 300)/2, _phoneLab.maxY + 10, 300, 20) andWithFont:17.0];
    _companyLab.textAlignment = NSTextAlignmentCenter;
    _companyLab.textColor = Commom_TextColor_Gray;
    [self.view addSubview:_companyLab];
    

}

-(void)loadData
{
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    NSDictionary *parameters = @{@"appid":@"2",@"type":@"1"};
    
    [rq GETURLString:@"http://app.aixinland.cn/api/version/Get" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
        NSLog(@"responseObj === %@",responseObj);
        
        if ([responseObj[@"status"] isEqualToString:@"Success"]) {
            
            NSDictionary *dataDic = responseObj[@"data"];
            
            [self creatUIWithDataDic:dataDic];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error == %@",error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
