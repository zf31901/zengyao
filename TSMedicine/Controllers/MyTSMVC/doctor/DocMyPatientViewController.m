//
//  DocMyPatientViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-6.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DocMyPatientViewController.h"
#import "ReportViewContrlller.h"

#import "MyPatientTableViewCell.h"

#import "MyPatientModel.h"

NSString *const PatientTableViewCell = @"MyPatientTableViewCell";

@interface DocMyPatientViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation DocMyPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
    [self setNavView];
    
    [self setTabView];
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的患者";
}

-(void)setTabView
{
    _tableView.bounces = YES;
    [_tableView registerNib:[UINib nibWithNibName:PatientTableViewCell bundle:nil] forCellReuseIdentifier:PatientTableViewCell];
}

#pragma mark --------UITableViewDataSource--------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPatientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PatientTableViewCell];
    if (!cell) {
        cell = [[MyPatientTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PatientTableViewCell];
    }
    cell.model = _dataArr[indexPath.row];
    
    return cell;
}
#pragma mark --------UITableViewDelegate--------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyPatientModel *model = _dataArr[indexPath.row];
    if (![model.mobilestate boolValue]) {
        ReportViewContrlller *reportVC = [[ReportViewContrlller alloc] init];
        reportVC.model = _dataArr[indexPath.row];
        [self.navigationController pushViewController:reportVC animated:YES];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

-(void)loadData
{
    _dataArr = [NSMutableArray array];
    
//    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
//    
//    NSDictionary *dic = @{@"userid":UserInfoData.im,@"pageid":@"1",@"pagesize":@"10"};
//    [rq GETURLString:@"http://app.aixinland.cn/api/userreport/List" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
////        NSLog(@"responseObj === %@",responseObj);
//        if ([responseObj[@"status"] isEqualToString:@"Success"]) {
//            
//            for (NSDictionary *dic in responseObj[@"data"]) {
//                
//                MyPatientModel *model = [[MyPatientModel alloc] init];
//                [model setValuesForKeysWithDictionary:dic];
//                [_dataArr addObject:model];
//            }
//        }
//            [_tableView reloadData];
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//         NSLog(@"error == %@",error);
//    }];
    
    
    NSDictionary *parameters = @{@"type":@"010105",@"pageid":@"1",@"pagesize":@"15"};
    [HttpRequest_MyApi POSTURLString:@"/user/list2/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//       NSLog(@"responseObject === %@",responseObject);
        
        if ([responseObject[@"state"] boolValue]) {
            
            for (NSDictionary *dic in responseObject[@"data"]) {
                
                MyPatientModel *model = [[MyPatientModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [_dataArr addObject:model];
                
            }
        }
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         NSLog(@"error == %@",error);
    }];
    
    
    
    
    /*
     _dataArr = [NSMutableArray array];
     NSArray *nameArr = [NSArray arrayWithObjects:@"张三", @"李四",@"王五",@"赵六", nil];
     
     for (int i = 0; i < nameArr.count; i++) {
     
     MyPatientModel *model = [[MyPatientModel alloc] init];
     model.name = nameArr[i];
     model.phoneNum = @"15987725345";
     
     if (i % 2 == 0) {
     model.isReport = YES;
     }else{
     model.isReport = NO;
     }
     
     [_dataArr addObject:model];
     }
     */
    
    
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
