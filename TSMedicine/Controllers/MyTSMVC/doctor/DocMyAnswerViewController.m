//
//  DocMyAnswerViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-6.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DocMyAnswerViewController.h"
#import "DocProjectQuestViewController.h"

#import "MJRefresh.h"

#import "MyProjectsListModel.h"

@interface DocMyAnswerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _pageSize;
    NSInteger _pageid;
}

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation DocMyAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [NSMutableArray array];
    
    _pageSize = 10;
    
    [self setNavView];
    
    [self loadData];
    
    [self addRefresh];
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
    MyProjectsListModel *model = _dataArr[indexPath.row];
    cell.textLabel.text = model.pname;
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
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    
    _pageid = _pageid!=0?_pageid:1;
    NSString *pageid = [NSString stringWithFormat:@"%ld",(long)_pageid];
    NSString *pageSize = [NSString stringWithFormat:@"%ld",(long)_pageSize];
    
    NSDictionary *dic = @{@"pageid":pageid,@"pagesize":pageSize};
    
    [rq GETURLString:@"http://app.aixinland.cn/api/projects/List" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
//        NSLog(@"responseObj == %@",responseObj);
//        NSLog(@"message == %@",responseObj[@"message"]);
        
        BOOL state = NO;
        NSArray *dataArr =[responseObj objectForKey:@"data"];
        if (dataArr.count == 0) {
            state = YES;
        }
        
        for (NSDictionary *dic in responseObj[@"data"]) {
            
            MyProjectsListModel *model = [[MyProjectsListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArr addObject:model];
        }
        [_tableView reloadData];
        
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
        if (state)
        {
            _tableView.footer.state = MJRefreshFooterStateNoMoreData;
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
    }];

}

#pragma mark - 上下啦刷新
- (void)addRefresh
{
    __weak DocMyAnswerViewController * weakSelf = self;
    [_tableView addLegendHeaderWithRefreshingBlock:^{
        _pageSize = 10;
        _pageid = 1;
        [_dataArr removeAllObjects];
        [weakSelf loadData];
    }];
    [_tableView addLegendFooterWithRefreshingBlock:^{
        _pageid++;
        [weakSelf loadData];
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
