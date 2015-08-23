//
//  SetAboutTSMViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-23.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "SetAboutTSMViewController.h"

@interface SetAboutTSMViewController ()

@property (nonatomic,strong) WIBaseImageView *iconImageView;
@property (nonatomic,strong) WIBaseLabel *versionLab;
@property (nonatomic,strong) WIBaseLabel *phoneLab;
@property (nonatomic,strong) WIBaseLabel *companyLab;

@end

@implementation SetAboutTSMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    [self creatUI];
    
}

-(void)setNavView
{
    self.title = @"关于我们";
}

-(void)creatUI
{
    _iconImageView = [WIBaseImageView createClassWithFrame:CGRectMake((ScreenWidth - 60)/2, 50, 60, 60) andWithImg:@"S2-Logo-FM.png" andWithTag:0 andWithEnable:YES];
    [_iconImageView makeCorner:10];
    [self.view addSubview:_iconImageView];
    
    
    _versionLab = [WIBaseLabel createClassWithTitle:[NSString stringWithFormat:@"手机捐助 V%@",current_version] andWithFrame:CGRectMake((ScreenWidth - 200)/2, _iconImageView.maxY + 10, 200, 20) andWithFont:17.0];
    _versionLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_versionLab];
    
    _phoneLab = [WIBaseLabel createClassWithTitle:[NSString stringWithFormat:@"客服热线：400 4000 4000"] andWithFrame:CGRectMake((ScreenWidth - 300)/2, ScreenHeight - 150, 300, 20) andWithFont:17.0];
    _phoneLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_phoneLab];
    
    _companyLab = [WIBaseLabel createClassWithTitle:[NSString stringWithFormat:@"北京健胜医药有限公司版权所有"] andWithFrame:CGRectMake((ScreenWidth - 300)/2, _phoneLab.maxY + 10, 300, 20) andWithFont:17.0];
    _companyLab.textAlignment = NSTextAlignmentCenter;
    _companyLab.textColor = Commom_TextColor_Gray;
    [self.view addSubview:_companyLab];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
