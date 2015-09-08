//
//  DocProjectQuestViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DocProjectQuestViewController.h"
#import "DocProjectAnswerViewController.h"
#import "MyPatQuestModel.h"

#import "MJRefresh.h"

#import "MyQuestTableViewCell.h"

NSString *const QuestTableViewCell = @"MyQuestTableViewCell";

@interface DocProjectQuestViewController ()<UITableViewDataSource,UITabBarDelegate>
{
    NSInteger _pageSize;
    NSInteger _pageid;
}

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation DocProjectQuestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = [NSMutableArray array];
    
     _pageSize = 10;
    
    [self setNavView];
    [self loadData];
    
    [self setTabView];
    
    [self addRefresh];
    
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = [NSString stringWithFormat:@"%@问题",_model.pname];
}

-(void)setTabView
{
    [_tableView registerNib:[UINib nibWithNibName:QuestTableViewCell bundle:nil] forCellReuseIdentifier:QuestTableViewCell];
}

#pragma mark --------UITableViewDataSource--------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArr.count > 0) {
        return _dataArr.count;
    }else{
        return 0;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyQuestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QuestTableViewCell];
    if (!cell) {
        cell = [[MyQuestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QuestTableViewCell];
    }
  
    MyPatQuestModel *model = _dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark --------UITableViewDelegate--------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DocProjectAnswerViewController *answerVC = [[DocProjectAnswerViewController alloc] init];
    answerVC.model = _dataArr[indexPath.row];
    [self.navigationController pushViewController:answerVC animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPatQuestModel *model = _dataArr[indexPath.row];
//    NSLog(@"model.contentSize.height = %f",model.contentSize.height);
    
    return 40.0 + model.contentSize.height + 10.0;
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
    
    NSDictionary *dic = @{@"pid":_model.pid,@"userid":@(0),@"pageid":pageid,@"pagesize":pageSize};
    
    [rq GETURLString:@"http://app.aixinland.cn/api/userquestion/List2" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
//        NSLog(@"responseObj == %@",responseObj);
        BOOL state = NO;
        NSArray *dataArr =[responseObj objectForKey:@"data"];
        if (dataArr.count == 0) {
            state = YES;
        }

        for (NSDictionary *dic in responseObj[@"data"]) {
            MyPatQuestModel *model = [[MyPatQuestModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArr addObject:model];
        }
        
        if (_dataArr.count > 0) {
            [_tableView reloadData];
        }else{
            [_tableView removeFromSuperview];
            _tableView = nil;
            [self loadAlertUI];
        }
        
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
    __weak DocProjectQuestViewController * weakSelf = self;
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

-(void)loadAlertUI
{
    WIBaseLabel *label = [WIBaseLabel createClassWithTitle:@"您暂无提问" andWithFrame:CGRectMake(0, 0, 120, 20) andWithFont:17];
    label.center = self.view.center;
    label.midY = label.center.y - 50;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
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
