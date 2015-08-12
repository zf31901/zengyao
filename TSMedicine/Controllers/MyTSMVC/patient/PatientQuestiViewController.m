//
//  PatientQuestiViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-6.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "PatientQuestiViewController.h"

#import "MyProjectModel.h"
#import "MyquestionViewController.h"

#define URL @"http://app.aixinland.cn/api/projects/List"

@interface PatientQuestiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_myTableView;
    NSMutableArray *_dataArr;
}
@end

@implementation PatientQuestiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr=[[NSMutableArray alloc]init];
    
    [self loadData];
    [self setNavView];
    [self setNavlable];
    
    
    
    
}
-(void)loadData{
  
    _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
}
-(void)setNavlable{
    
    _dataArr = [NSMutableArray array];
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    NSDictionary *dic = @{@"userid":@"903050",@"pageid":@"1",@"pagesize":@"10"};
    
    [rq GETURLString:@"http://app.aixinland.cn/api/userproject/List" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
                NSLog(@"responseObj == %@",responseObj);
        
        for (NSDictionary *dic in responseObj[@"data"]) {
            MyProjectModel *model = [[MyProjectModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArr addObject:model];
        }
        [_myTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
    }];
    
    
}
-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的提问";
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    MyProjectModel *model = _dataArr[indexPath.row];
    cell.textLabel.text = model.upname;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MyquestionViewController *VC = [[MyquestionViewController alloc] init];
    VC.goodIndex = _dataArr[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
    
}




@end
