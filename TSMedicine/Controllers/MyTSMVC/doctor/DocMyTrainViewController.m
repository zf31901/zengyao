//
//  DocMyTrainViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-6.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DocMyTrainViewController.h"
#import "DocMyTrainDetailViewController.h"

#import "MyTrainTableViewCell.h"

#import "MyTrainModel.h"

NSString *const TrainTableViewCell = @"MyTrainTableViewCell";

@interface DocMyTrainViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation DocMyTrainViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setNavView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self setTabView];
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的培训";
}
-(void)setTabView
{
    [_tableView registerNib:[UINib nibWithNibName:TrainTableViewCell bundle:nil] forCellReuseIdentifier:TrainTableViewCell];
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
    MyTrainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TrainTableViewCell];
    if (!cell) {
        cell = [[MyTrainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TrainTableViewCell];
    }
    cell.model = _dataArr[indexPath.row];
    return cell;
}

#pragma mark --------UITableViewDelegate--------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DocMyTrainDetailViewController *trainDetailVC = [[DocMyTrainDetailViewController alloc] init];
    trainDetailVC.model = _dataArr[indexPath.row];
    [self.navigationController pushViewController:trainDetailVC animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

-(void)loadData
{
    _dataArr = [NSMutableArray array];
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    
    NSDictionary *dic = @{@"userid":UserInfoData.im,@"pageid":@"1",@"pagesize":@"10"};
    
    [rq GETURLString:@"http://app.aixinland.cn/api/training/List2" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        NSLog(@"responseObj === %@",responseObj);
       if ([responseObj[@"status"] isEqualToString:@"Success"]) {
           
           for (NSDictionary *dic in responseObj[@"data"]) {
               
               MyTrainModel *model = [[MyTrainModel alloc] init];
               [model setValuesForKeysWithDictionary:dic];
               [_dataArr addObject:model];
           }
           [_tableView reloadData];
       }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
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
