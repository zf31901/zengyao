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
#import "CanonFormViewController.h"
#import "xqingViewController.h"
#import "APPaixinlModel.h"
#define URL @"http://app.aixinland.cn/api/userproject/List"

#define URLIST @"http://app.aixinland.cn/api/userproject/Get?dataid="
#define IS_IPHONE_5    ([[UIScreen mainScreen ] bounds] .size.height)
@interface APPlicationProgressViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArr;
    UITableView *_myTablview;

}
@end

@implementation APPlicationProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;

    _dataArr=[[NSMutableArray alloc]init];

    
    [self setNavView];
   
    [self buidRightBtn:@"项目详情"];
    [self loadDatacell];
  
   
}
-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
   self.title=@"申请进度";
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}
-(void)UITableView{
    
   
    _myTablview= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, IS_IPHONE_5-25) style:UITableViewStyleGrouped];
    
    _myTablview.delegate = self;
    _myTablview.dataSource = self;
   
   
    [_myTablview registerNib:[UINib nibWithNibName:@"AuditInformationTableViewCell" bundle:nil] forCellReuseIdentifier:@"Audcell"];
    
    [_myTablview registerNib:[UINib nibWithNibName:@"ReasonTableViewCell" bundle:nil] forCellReuseIdentifier:@"Reacell"];
    [_myTablview registerNib:[UINib nibWithNibName:@"HospitalTableViewCell" bundle:nil] forCellReuseIdentifier:@"Hoscell"];
    [_myTablview registerNib:[UINib nibWithNibName:@"CanonicalormTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cancell"];
     [self.view addSubview:_myTablview];
}

-(void)loadDatacell{

    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",URLIST,_Goodmodel.upid];
   
    [rq GETURLString:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
        MyAppModel *model = [[MyAppModel  alloc] init];
        
        [model setValuesForKeysWithDictionary:responseObj[@"data"]];
        
        [_dataArr addObject:model];
        
        [self UITableView];
        
        [_myTablview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
    }];
    
    
}


#pragma mark-UITableView代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (3==indexPath.section) {
    
        
        CanonFormViewController  *answerVC = [[CanonFormViewController alloc] init];
         answerVC.model = _dataArr[indexPath.row];
        [self.navigationController pushViewController:answerVC animated:YES];
        
    }
}

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
    }else if(indexPath.section == 1 &&0 == indexPath.row)
    {
        return 130;
    }
    else if(indexPath.section == 2 &&0 == indexPath.row)
    {
    
        return 200;
    }
    else{
    
        return 203;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && 0 == indexPath.row)
    {
        
    
    AuditInformationTableViewCell *Audcell = [tableView dequeueReusableCellWithIdentifier:@"Audcell" forIndexPath:indexPath];
        
       APPaixinlModel *model=[_dataArr objectAtIndex:indexPath.row];
        NSString *dateStr = [model.upcreatedate substringWithRange:NSMakeRange(0, 10)];
        NSString *timeStr = [model.upcreatedate substringWithRange:NSMakeRange(11, 5)];
        
         Audcell.upcreatedate.text = [NSString stringWithFormat:@"%@ %@",dateStr,timeStr];

     
        Audcell.upname.text=model.upname;
        if ([model.upstate boolValue]== 0) {
             Audcell.upstate.text=@"审核未通过";
             Audcell.upstate.textColor=UIColorFromRGB(0xFF6600);
        }
        else if ([model.upstate boolValue]== 1) {
             Audcell.upstate.text=@"未审核";
             Audcell.upstate.textColor=UIColorFromRGB(0xFF6600);
        }
        else if ([[NSString stringWithFormat:@"%@",model.upstate] isEqualToString:@"2"]){
             Audcell.upstate.text=@"审核通过";
             Audcell.upstate.textColor=UIColorFromRGB(0xFF6600);
        }else{
             Audcell.upstate.text=@"用户正提交申请";
             Audcell.upstate.textColor=UIColorFromRGB(0x20A456);
            
            
        }

       
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
    xqingViewController *VC = [[xqingViewController  alloc] init];
    if (_Goodmodel) {
        
        VC.model=_Goodmodel;
    }
    [self.navigationController pushViewController:VC animated:YES];
}

@end
