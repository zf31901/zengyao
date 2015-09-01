//
//  MyTSMViewController.m
//  TSMedicine
//
//  Created by lyy on 15-6-8.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyTSMViewController.h"

#import "SetMyTSMViewController.h"
#import "MyPatientViewController.h"
#import "MyShenqingViewContrlller.h"
#import "TrainViewController.h"
#import "PhoneVerificationCodeViewController.h"

#import "MyApplication.h"

#import "PatientApplyViewController.h"
#import "PatientQuestiViewController.h"
#import "DocMyPatientViewController.h"
#import "DocMyTrainViewController.h"
#import "DocMyAnswerViewController.h"
#import "ManagerMyTrainViewController.h"

#import "LoginViewController.h"
#import "MyTSMUserInfoViewController.h"
#import "MyTSMNoticeViewController.h"
#import "MyTSMSetViewController.h"

#import "MyHeaderView.h"
#import "MyProModel.h"
#import "MyProTableViewCell.h"


#define Patient_Type1 @"01"         //患者
#define Patient_Type2 @""           //患者
#define Doctor_Type   @"010101"     //医生
#define Manager_Type  @"010103"     //协管员
#define Medicine_Type @"010104"     //药房

NSString *const ProTableViewCell = @"MyProTableViewCell";

@interface MyTSMViewController ()<MyHeaderViewDelegate,UITableViewDataSource,UITableViewDelegate>

//@property (weak, nonatomic) IBOutlet X_TableView *tableView;

@property (strong,nonatomic) MyHeaderView *headView;

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (nonatomic,assign) NSInteger count;

@end

@implementation MyTSMViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden  = YES;
    
//    NSLog(@"isAutoLogin == %d",[GlobalMethod sharedInstance].isAutoLogin);
    
    if ([GlobalMethod sharedInstance].isAutoLogin)
    {
        [[GlobalMethod sharedInstance] reloadUserInfoDataSuccess:^(NSString *status) {
            if ([status isEqualToString:@"success"]) {
                NSLog(@"用户数据更新成功");
                
                [self drawUI];
            }
        } failure:^{
            
        }];
        
    }else if ([GlobalMethod sharedInstance].isLogin){
        
        [self drawUI];
        
    }else{
        
        [self.tableView removeFromSuperview];
        self.tableView = nil;
        _headView.headImageView.image = [UIImage imageNamed:default_head];
        _headView.nameLab.text = @"点击登录";
    }
}

-(void)drawUI
{
    
    [_headView.headImageView sd_setImageWithURL:[NSURL URLWithString:UserInfoData.headPic] placeholderImage:[UIImage imageNamed:default_head] options:SDWebImageRefreshCached];
    
    _headView.nameLab.text = [NSString stringWithFormat:@"%@",UserInfoData.nickName];
    
    [self.view addSubview:self.tableView];
    [_tableView registerNib:[UINib nibWithNibName:ProTableViewCell bundle:nil] forCellReuseIdentifier:ProTableViewCell];
    
    [self loadData];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _headView.maxY, ScreenWidth, ScreenHeight - _headView.maxY) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [NSMutableArray array];
    
    [self createUI];
}

-(void)createUI
{
    _headView = [[MyHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    _headView.delegate = self;
    [self.view addSubview:_headView];
}
#pragma mark -------UITableViewDataSource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyProTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProTableViewCell];
    if (!cell) {
        cell = [[MyProTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProTableViewCell];
    }
    cell.model = _dataArr[indexPath.section][indexPath.row];
    
    
    NSString *type = UserInfoData.Type;
    Weak(MyProTableViewCell)
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        if ([type isEqualToString:Manager_Type] || [type isEqualToString:Medicine_Type]) {
            
            [[GlobalMethod sharedInstance] getDoctorWaitTrainNumber:^(NSArray *numberArr){
                
                if (numberArr.count > 0) {
                    
                    weakCell.questionBtn.hidden = NO;
                    [weakCell.questionBtn setTitle:[NSString stringWithFormat:@"%ld",numberArr.count] forState:UIControlStateNormal];
                    [weakCell.questionBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
                }else{
                    weakCell.questionBtn.hidden = YES;
                }
                
            }];
            
        }else{
            
        }
        
    }
    
    if (indexPath.section == 0 && indexPath.row == 1)
    {
        
        if (![type isEqualToString:Doctor_Type] && ![type isEqualToString:Manager_Type] && ![type isEqualToString:Medicine_Type]) {
            
            if (_count > 0) {
                
                cell.questionBtn.hidden = NO;
                [cell.questionBtn setTitle:[NSString stringWithFormat:@"%ld",_count] forState:UIControlStateNormal];
                [cell.questionBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
                
            }else{
                cell.questionBtn.hidden = YES;
            }
            
        }else if ([type isEqualToString:Doctor_Type]){
            
            [[GlobalMethod sharedInstance] getDoctorWaitTrainNumber:^(NSArray *numberArr){
               
                if (numberArr.count > 0) {
                    
                    weakCell.questionBtn.hidden = NO;
                    [weakCell.questionBtn setTitle:[NSString stringWithFormat:@"%ld",numberArr.count] forState:UIControlStateNormal];
                    [weakCell.questionBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
                }else{
                    weakCell.questionBtn.hidden = YES;
                }
                
            }];
        
        }else{
            
        }
        
        
    }
    
    return cell;
}

#pragma mark --------UITableViewDelegate--------------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *type = UserInfoData.Type;
    
    if (indexPath.section == 0)
    {
        
        if (![type isEqualToString:Doctor_Type] && ![type isEqualToString:Manager_Type] && ![type isEqualToString:Medicine_Type])
        {
            
            switch (indexPath.row) {
                case 0:
                {
                    PatientApplyViewController *applyVC = [[PatientApplyViewController alloc] init];
                    applyVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:applyVC animated:YES];
                }
                    break;
                    
                case 1:
                {
                    PatientQuestiViewController *questVC = [[PatientQuestiViewController alloc] init];
                    questVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:questVC animated:YES];
                }
                    break;
                default:
                    break;
            }
        }else if ([type isEqualToString:Doctor_Type]){
        
            switch (indexPath.row) {
                case 0:
                {
                    DocMyPatientViewController *patientVC = [[DocMyPatientViewController alloc] init];
                    patientVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:patientVC animated:YES];
                }
                    break;
                case 1:
                {
                    DocMyTrainViewController *trainVC = [[DocMyTrainViewController alloc] init];
                    trainVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:trainVC animated:YES];
                }
                    break;
                case 2:
                {
                    DocMyAnswerViewController *answerVC = [[DocMyAnswerViewController alloc] init];
                    answerVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:answerVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }else if ([type isEqualToString:Manager_Type] || [type isEqualToString:Medicine_Type]){
            
            switch (indexPath.row){
                case 0:
                {
                    DocMyTrainViewController *trainVC = [[DocMyTrainViewController alloc] init];
                    trainVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:trainVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            
        }else{
            
        }
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                MyTSMNoticeViewController *noticeVC = [[MyTSMNoticeViewController alloc] init];
                noticeVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:noticeVC animated:YES];
            }
                break;
                
            case 1:
            {
                MyTSMSetViewController *setVC = [[MyTSMSetViewController alloc] init];
                setVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:setVC animated:YES];
            }
                break;
                
            default:
                break;
        }
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

#pragma mark ------------ 数据 ---------------
-(void)loadData
{
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    NSDictionary *parameters = @{@"pid":@(0),@"Duserid":@(0),@"Suserid":UserInfoData.im};
    
    [rq GETURLString:@"http://app.aixinland.cn/api/userquestionanswer/Count2" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObj) {
//        NSLog(@"responseObj22222 === %@",responseObj);
        
        if ([responseObj[@"status"] isEqualToString:@"Success"]) {
            
            NSInteger answerCount = [responseObj[@"data"] integerValue];
            NSInteger lastAnswerCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"answerCount"];
            
            if (answerCount - lastAnswerCount > 0) {
                
                _count = answerCount - lastAnswerCount;
                
            }else{
                _count = 0;
            }
            
            [[NSUserDefaults standardUserDefaults] setInteger:answerCount forKey:@"answerCount"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self loadLocationData];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error == %@",error);
    }];
}

-(void)loadLocationData
{
    [_dataArr removeAllObjects];
    NSString *type = UserInfoData.Type;
    NSLog(@"Type == %@",UserInfoData.Type);
    
    NSArray *picArr = nil;
    if (![type isEqualToString:Doctor_Type] && ![type isEqualToString:Manager_Type] && ![type isEqualToString:Medicine_Type]) {
        picArr = [NSArray arrayWithObjects:@"appl40", @"questions40", nil];
    }else if ([type isEqualToString:Doctor_Type]){
        picArr = [NSArray arrayWithObjects:@"patient40", @"training40", @"answer40", nil];
    }else if ([type isEqualToString:Manager_Type] || [type isEqualToString:Medicine_Type]){
        picArr = [NSArray arrayWithObjects:@"training40", nil];
    }else{
        
    }
    NSArray *comPicArr = [NSArray arrayWithObjects:@"notice40", @"Set-up40",nil];
    
    NSArray *titleArr = nil;
    if (![type isEqualToString:Doctor_Type] && ![type isEqualToString:Manager_Type] && ![type isEqualToString:Medicine_Type]) {
        titleArr = [NSArray arrayWithObjects:@"我的申请", @"我的提问", nil];
    }else if ([type isEqualToString:Doctor_Type]){
        titleArr = [NSArray arrayWithObjects:@"我的患者", @"我的培训", @"我的问答", nil];
    }else if ([type isEqualToString:Manager_Type] || [type isEqualToString:Medicine_Type]){
        titleArr = [NSArray arrayWithObjects:@"我的培训", nil];
    }else{
        
    }
    NSArray *comTitleArr = [NSArray arrayWithObjects:@"系统通知", @"设置", nil];
    
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < picArr.count; i++) {
        
        MyProModel *model = [[MyProModel alloc] init];
        model.pic = picArr[i];
        model.title = titleArr[i];
        
        [arr1 addObject:model];
    }
    
    NSMutableArray *arr2 = [NSMutableArray array];
    for (int i = 0; i < comTitleArr.count; i++) {
        
        MyProModel *model = [[MyProModel alloc] init];
        model.pic = comPicArr[i];
        model.title = comTitleArr[i];
        
        [arr2 addObject:model];
    }
    
    [_dataArr addObject:arr1];
    [_dataArr addObject:arr2];
    
    [_tableView reloadData];
}

#pragma mark ---------MyHeaderViewDelegate--------
-(void)myHeaderViewClick:(MyHeaderView *)headerView
{
    if ([GlobalMethod sharedInstance].isLogin) {
        
        MyTSMUserInfoViewController *infoVC = [[MyTSMUserInfoViewController alloc] init];
        infoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infoVC animated:YES];
        
    }else{
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
