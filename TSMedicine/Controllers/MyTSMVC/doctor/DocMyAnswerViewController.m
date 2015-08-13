//
//  DocMyAnswerViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-6.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DocMyAnswerViewController.h"
#import "DocProjectQuestViewController.h"

#import "MyProjectModel.h"

@interface DocMyAnswerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation DocMyAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    
    [self loadData];
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"选择项目";
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    MyProjectModel *model = _dataArr[indexPath.row];
    cell.textLabel.text = model.upname;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark --------UITableViewDelegate--------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DocProjectQuestViewController *questVC = [[DocProjectQuestViewController alloc] init];
    questVC.model = _dataArr[indexPath.row];
    [self.navigationController pushViewController:questVC animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
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
    
    [rq GETURLString:@"http://app.aixinland.cn/api/userproject/List" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        NSLog(@"responseObj == %@",responseObj);
        
        for (NSDictionary *dic in responseObj[@"data"]) {
            MyProjectModel *model = [[MyProjectModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
//            NSLog(@"upname == %@",model.upname)
            
            [_dataArr addObject:model];
        }
        [_tableView reloadData];
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
