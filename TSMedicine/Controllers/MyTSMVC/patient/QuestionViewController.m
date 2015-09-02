//
//  QuestionViewController.m
//  TSMedicine
//
//  Created by 123 on 15/8/9.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestPersoNTableViewCell.h"
#import "QuestionTurnViewController.h"


#import "MyPatQuestModel.h"
#import "MyAnswerModel.h"

#define URL @"http://app.aixinland.cn/api/userquestionanswer/List"


@interface QuestionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_mytableView;
     NSInteger _pagesize;
}
@property(nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,assign) BOOL isFirst;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       _isFirst = YES;
    _dataArr=[[NSMutableArray alloc]init];
    
     _pagesize=20;
    [self Staload];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"问题详情";
}

-(void)settabView{
    
    _mytableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _mytableView.delegate =self;
    _mytableView.dataSource =self;
    _mytableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_mytableView];
    
    [_mytableView registerNib:[UINib nibWithNibName:@"QuestPersoNTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
-(void)Staload{
    
    
    _dataArr = [NSMutableArray array];
    NSMutableArray *arr1 = [NSMutableArray array];
    [arr1 addObject:self.model];
    [_dataArr addObject:arr1];
    
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
     NSString *pageStr = [NSString stringWithFormat:@"%ld",_pagesize];
    
    NSDictionary *dic = @{@"uqid":_model.uqid,@"userid":@"0",@"pageid":@"1",@"pagesize":pageStr};
    [rq GETURLString:@"http://app.aixinland.cn/api/userquestionanswer/List2" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
//        NSLog(@"responseObj777 == %@",responseObj);
        
        NSMutableArray *arr2 = [NSMutableArray array];
        for (NSDictionary *dic in responseObj[@"data"]) {
            MyAnswerModel *model = [[MyAnswerModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [arr2 addObject:model];
        }
        [_dataArr addObject:arr2];
        
        if (_isFirst) {
            [self settabView];
            _isFirst = NO;
        }
        
        
        [_mytableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error===%@",error);
    }];
    
}
#pragma mark --------UITableViewDataSource--------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [_dataArr[section] count];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

   QuestPersoNTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[QuestPersoNTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
   
  [cell loadDataWithDataArray:_dataArr andWithIndexPath:indexPath];
    
    return cell;
    
}
#pragma mark --------UITableViewDelegate--------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.section == 0) {
        MyPatQuestModel *model = _dataArr[indexPath.section][indexPath.row];
        return 80.0 + model.contentSize.height;
        
    }else{
        MyAnswerModel *model = _dataArr[indexPath.section][indexPath.row];
        
        return 80.0 + model.contentSize.height;
    }

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1f;
    }else{
        return 3.0f;
    }

}
@end
