//
//  DocMyTrainViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-6.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DocMyTrainViewController.h"
#import "MyTrainTableViewCell.h"

NSString *const TrainTableViewCell = @"MyTrainTableViewCell";

@interface DocMyTrainViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation DocMyTrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    [self setTabView];
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的培训";
}
-(void)setTabView
{
    [_tableView registerNib:[UINib nibWithNibName:TrainTableViewCell bundle:nil] forCellReuseIdentifier:TrainTableViewCell];
}
#pragma mark --------UITableViewDataSource--------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTrainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TrainTableViewCell];
    if (!cell) {
        cell = [[MyTrainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TrainTableViewCell];
    }
    
    return cell;
}

#pragma mark --------UITableViewDelegate--------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
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
