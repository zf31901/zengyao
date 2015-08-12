//
//  APPlicationProgressViewController.m
//  TSMedicine
//
//  Created by 123 on 15/8/12.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "APPlicationProgressViewController.h"
#import "AuditInformationTableViewCell.h"
#import "ReasonTableViewCell.h"
#import "HospitalTableViewCell.h"
#import "CanonicalormTableViewCell.h"

#import "xqingViewController.h"

@interface APPlicationProgressViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArr;
    UITableView *_myTablview;

}
@end

@implementation APPlicationProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr=[[NSMutableArray alloc]init];
    [self setNavView];
    [self UITableView];
    [self buidRightBtn:@"详情"];
}
-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
   self.title=@"申请进度";
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)UITableView{
    
   
    _myTablview= [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _myTablview.delegate = self;
    _myTablview.dataSource = self;
   
   
    [_myTablview registerNib:[UINib nibWithNibName:@"AuditInformationTableViewCell" bundle:nil] forCellReuseIdentifier:@"Audcell"];
    
    [_myTablview registerNib:[UINib nibWithNibName:@"ReasonTableViewCell" bundle:nil] forCellReuseIdentifier:@"Reacell"];
    [_myTablview registerNib:[UINib nibWithNibName:@"HospitalTableViewCell" bundle:nil] forCellReuseIdentifier:@"Hoscell"];
    [_myTablview registerNib:[UINib nibWithNibName:@"CanonicalormTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cancell"];
     [self.view addSubview:_myTablview];
}




#pragma mark-UITableView代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && 0 == indexPath.row)
    {
        return 143;
    }else if(indexPath.section == 1 &&1 == indexPath.row)
    {
        return 50;
    }
    else if(indexPath.section == 2 &&2 == indexPath.row)
    {
    
        return 154;
    }
    else{
    
        return 153;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && 0 == indexPath.row)
    {
        
    
    AuditInformationTableViewCell *Audcell = [tableView dequeueReusableCellWithIdentifier:@"Audcell" forIndexPath:indexPath];
    
        return Audcell;
        
    }
    
    else if(indexPath.section == 1 && 0==indexPath.row){
    
        ReasonTableViewCell *Reacell = [tableView dequeueReusableCellWithIdentifier:@"Reacell" forIndexPath:indexPath];
        
        return Reacell;
    
    
    }
    else if (indexPath.section == 2 && 0==indexPath.row){
        HospitalTableViewCell *Hoscell = [tableView dequeueReusableCellWithIdentifier:@"Hoscell" forIndexPath:indexPath];
        
        return Hoscell;
    }
    else{
    
        CanonicalormTableViewCell *Cancell = [tableView dequeueReusableCellWithIdentifier:@"Cancell" forIndexPath:indexPath];
        
        return Cancell;

    return nil;
    }

}

-(void)commit{
    xqingViewController *VC = [[xqingViewController   alloc] init];
    // VC.goodIndex = _dataArr[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];



}

@end
