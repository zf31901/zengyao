//
//  MyquestionViewController.m
//  TSMedicine
//
//  Created by 123 on 15/8/7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyquestionViewController.h"
#import "MYquestion.h"
#import "myquerstionTableViewCell.h"
#import "QuestionTurnViewController.h"
#import "QuestionViewController.h"
#import "MJRefresh.h"

#define URL @"http://app.aixinland.cn/api/userquestion/List"


@interface MyquestionViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_mytableView;
    NSMutableArray *_dataArr;
    NSInteger _pagesize;
    NSInteger _pagID;
    
    
}

@end

@implementation MyquestionViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self loadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    
    _pagesize=30;
    _dataArr = [NSMutableArray array];
    
    [self setTableView];
    
    [self addRefresh];
    
}
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark ---------------- 上下啦刷新-------------
- (void)addRefresh
{
    __weak MyquestionViewController * ctl = self;
    [_mytableView addLegendHeaderWithRefreshingBlock:^{
       _pagesize = 10;
        [_dataArr removeAllObjects];
        [ctl loadData];
    }];
//    [_mytableView addLegendFooterWithRefreshingBlock:^{
//        _pageID++;
//        
//       [ctl loadData];
//    }];


}
-(void)loadData{
    [_dataArr removeAllObjects];
    
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_pagesize];
    //NSString *pageID=[NSString stringWithFormat:@"@%ld",(long)_pagID];
    
    NSDictionary *dic = nil;
    if (_goodIndex) {
        
        dic = @{@"pid":_goodIndex.uppid,@"userid":UserInfoData.im,@"pageid":@"1",@"pagesize":pageStr};
    }
    if (_model) {
        
        dic = @{@"pid":_model.uppid,@"userid":UserInfoData.im,@"pageid":@"1",@"pagesize":pageStr};
    }
    
    [rq GETURLString:@"http://app.aixinland.cn/api/userquestion/List" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
//        NSLog(@"responseObj555 == %@",responseObj);
        
        for (NSDictionary *dic in responseObj[@"data"]) {
            MyPatQuestModel *model = [[MyPatQuestModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArr addObject:model];
        }
        [_mytableView reloadData];
        [_mytableView.header endRefreshing];
        [_mytableView.footer endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
    
    }];


}
-(void)setTableView
{
    _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-44) style:UITableViewStyleGrouped];
    _mytableView.delegate =self;
    _mytableView.dataSource =self;
    [self.view addSubview:_mytableView];
  [_mytableView registerNib:[UINib nibWithNibName:@"myquerstionTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}
- (void)commit
{
    QuestionTurnViewController *commitVC = [QuestionTurnViewController new];
    if (_goodIndex) {
        commitVC.model= _goodIndex;
    }
    if (_model) {
        commitVC.appModel= _model;
    }
    [self.navigationController pushViewController:commitVC animated:YES];
    
}
-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的提问";
    [self buidRightBtn:@"提问"];
    
}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myquerstionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        
        cell=[[myquerstionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.indexPath = indexPath;
    
    MyPatQuestModel *model1 = _dataArr[indexPath.row];
    cell.model = model1;
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return 70.0f;
    MyPatQuestModel *model = _dataArr[indexPath.row];
    return 40.0 + model.contentSize.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QuestionViewController *nav=[[QuestionViewController alloc]init];
    
    MyPatQuestModel *model = _dataArr[indexPath.row];
    nav.model = model;
    
//    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:[NSString stringWithFormat:@"%ld%@",indexPath.row,model.uqid]];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController pushViewController:nav animated:YES];

}

- (void)back
{
    if (_isWeb) {
        
        [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
