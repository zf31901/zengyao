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
    _pagesize=10;
     _dataArr = [NSMutableArray array];
    [self setTableView];
    [self buidRightBtn:@"提问"];
    [self Staload];

    
    

}
-(void)Staload{
   
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    NSString *pageStr = [NSString stringWithFormat:@"%ld",_pagesize];
    //_goodIndex.upuserid
    NSDictionary *dic = @{@"pid":_goodIndex.uppid,@"userid":_goodIndex.upuserid,@"pageid":@"1",@"pagesize":pageStr};
    
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
    commitVC.model= _goodIndex;
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
@end
