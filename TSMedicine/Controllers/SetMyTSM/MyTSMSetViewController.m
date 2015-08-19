//
//  MyTSMSetViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-5.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyTSMSetViewController.h"
#import "AboutTSMViewController.h"
#import "MyTSMFeedBackViewController.h"

@interface MyTSMSetViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation MyTSMSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self setNavView];
    
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"设置";
    
    [_exitBtn makeCorner:5];
    [_exitBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [_exitBtn setBackgroundColor:Common_Btn_BgColor];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row){
            case 0:
            {
                AboutTSMViewController *aboutVC = [[AboutTSMViewController alloc] init];
                [self.navigationController pushViewController:aboutVC animated:YES];
            }
                break;
            case 1:
            {
                MyTSMFeedBackViewController *feedBack = [[MyTSMFeedBackViewController alloc] init];
                [self.navigationController pushViewController:feedBack animated:YES];
            }
                break;
                
            default:
                break;
        }
    }else{
        switch (indexPath.row){
            case 0:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否清除缓存!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
            }
                break;
                
            default:
                break;
        }
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
    return 10.0f;
    }else{
        return 0.1f;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

-(void)loadData
{
    _dataArr = [NSMutableArray array];
    NSArray *arr = [NSArray arrayWithObjects:@"关于我们", @"意见反馈", nil];
    NSArray *arr1 = [NSArray arrayWithObjects:@"清除缓存", nil];
    [_dataArr addObject:arr];
    [_dataArr addObject:arr1];
}
- (IBAction)exitLoginAction:(id)sender {
    
    
    NSDictionary *parameter = @{@"u": UserInfoData.im,@"clientkey":UserInfoData.clientkey};
    [HttpRequest_MyApi GETURLString:@"/user/loginout/" parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObj) {
    
        NSDictionary *rqDic = (NSDictionary *)responseObj;
        
        NSLog(@"rqDic === %@",rqDic);
        
        if([rqDic[HTTP_STATE] boolValue]){
            
            [GlobalMethod saveLoginInStatus:NO];
            [GlobalMethod sharedInstance].isLogin = NO;
            [GlobalMethod sharedInstance].isAutoLogin = NO;
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            NSLog(@"errorMsg: %@",rqDic[HTTP_MSG]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
