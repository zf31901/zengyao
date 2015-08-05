//
//  MyTSMSetViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-5.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyTSMSetViewController.h"

@interface MyTSMSetViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation MyTSMSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self setNavView];
    
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"设置";
}

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
    return 10.0f;
    }else{
        return 0.1f;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

-(void)loadData
{
    _dataArr = [NSMutableArray array];
    NSArray *arr = [NSArray arrayWithObjects:@"关于我们", @"意见反馈", nil];
    NSArray *arr1 = [NSArray arrayWithObjects:@"清除缓存", nil];
    [_dataArr addObject:arr];
    [_dataArr addObject:arr1];
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
