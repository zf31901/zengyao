//
//  DocMyPatientViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-6.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DocMyPatientViewController.h"
#import "ReportViewContrlller.h"

#import "MyPatientTableViewCell.h"

#import "MyPatientModel.h"

NSString *const PatientTableViewCell = @"MyPatientTableViewCell";

@interface DocMyPatientViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation DocMyPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
    [self setNavView];
    
    [self setTabView];
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的患者";
}

-(void)setTabView
{
    [_tableView registerNib:[UINib nibWithNibName:PatientTableViewCell bundle:nil] forCellReuseIdentifier:PatientTableViewCell];
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
    MyPatientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PatientTableViewCell];
    if (!cell) {
        cell = [[MyPatientTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PatientTableViewCell];
    }
    cell.model = _dataArr[indexPath.row];
    
    return cell;
}
#pragma mark --------UITableViewDelegate--------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyPatientModel *model = _dataArr[indexPath.row];
    if (!model.isReport) {
        ReportViewContrlller *reportVC = [[ReportViewContrlller alloc] init];
        [self.navigationController pushViewController:reportVC animated:YES];
    }
    
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
    NSArray *nameArr = [NSArray arrayWithObjects:@"张三", @"李四",@"王五",@"赵六", nil];
    
    for (int i = 0; i < nameArr.count; i++) {
        
        MyPatientModel *model = [[MyPatientModel alloc] init];
        model.name = nameArr[i];
        model.phoneNum = @"15987725345";
        
        
        if (i % 2 == 0) {
            model.isReport = YES;
        }else{
            model.isReport = NO;
        }
        
        [_dataArr addObject:model];
    }

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
