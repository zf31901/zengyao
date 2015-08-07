//
//  DocProjectQuestViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DocProjectQuestViewController.h"
#import "MyPatQuestModel.h"

#import "MyQuestTableViewCell.h"

NSString *const QuestTableViewCell = @"MyQuestTableViewCell";

@interface DocProjectQuestViewController ()<UITableViewDataSource,UITabBarDelegate>

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation DocProjectQuestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    [self loadData];
    
    [self setTabView];
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = [NSString stringWithFormat:@"%@问题",_model.upname];
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
    return _dataArr.count;
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
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    NSDictionary *dic = @{@"pid":_model.uppid,@"userid":_model.upuserid,@"pageid":@"1",@"pagesize":@"10"};
    
    [rq GETURLString:@"http://app.aixinland.cn/api/userquestion/List" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
//        NSLog(@"responseObj == %@",responseObj);
        
        for (NSDictionary *dic in responseObj[@"data"]) {
            MyPatQuestModel *model = [[MyPatQuestModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
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
