//
//  PatientQuestiViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-6.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "PatientQuestiViewController.h"
#import "PersonTableViewCell.h"
#import "personmodel.h"
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
    //实例化一个UITableView
    _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
}
-(void)setNavlable{

NSArray *arr = @[@"项目一",@"项目二",@"项目三",@"项目四"];
    for (int i=0; i<4; i++) {
       personmodel *pModel = [[personmodel alloc] init];
        pModel.nameStr = arr[i];
        pModel.headImageStr = @"arrow-fight16x25_gray";
        [_dataArr addObject:pModel];

    }
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[PersonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //刷新数据
    personmodel *pModel = _dataArr[indexPath.row];
    
    cell.nameLabel.text = pModel.nameStr;
    cell.headImageView.image = [UIImage imageNamed:pModel.headImageStr];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   MyquestionViewController *ctl = [[MyquestionViewController alloc] init];
//    ctl.myModel = _dataArr[indexPath.row];
    
    [self.navigationController pushViewController:ctl animated:YES];
    
    
}




@end
