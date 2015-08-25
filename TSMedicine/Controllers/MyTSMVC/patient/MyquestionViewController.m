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

#define URL @"http://app.aixinland.cn/api/userquestion/List"


@interface MyquestionViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_mytableView;
    NSMutableArray *_dataArr;
    NSInteger _pagesize;
    
}

@end

@implementation MyquestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self setNavView];
    _pagesize=30;
     _dataArr = [NSMutableArray array];
    [self setTableView];
    [self buidRightBtn:@"提问"];
//    [self Staload];

    
    
}
-(void)Staload{
    [_dataArr removeAllObjects];
    
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    NSString *pageStr = [NSString stringWithFormat:@"%ld",_pagesize];
    
    NSDictionary *dic = nil;
    if (_goodIndex) {
        
        dic = @{@"pid":_goodIndex.uppid,@"userid":_goodIndex.upuserid,@"pageid":@"1",@"pagesize":pageStr};
    }
    if (_model) {
        
        dic = @{@"pid":_model.uppid,@"userid":_model.upuserid,@"pageid":@"1",@"pagesize":pageStr};
    }
    
    [rq GETURLString:@"http://app.aixinland.cn/api/userquestion/List" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        NSLog(@"responseObj == %@",responseObj);
        
        for (NSDictionary *dic in responseObj[@"data"]) {
            MyPatQuestModel *model = [[MyPatQuestModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArr addObject:model];
        }
        [_mytableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
    }];


}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self Staload];
  
}
-(void)setTableView
{
    _mytableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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
    
    MyPatQuestModel *model1 = _dataArr[indexPath.row];
    
    
    cell.model=model1;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QuestionViewController *nav=[[QuestionViewController alloc]init];
    nav.model = _dataArr[indexPath.row];
    
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
