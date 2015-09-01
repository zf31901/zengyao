//
//  PatientQuestiViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-6.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "PatientQuestiViewController.h"
#import "PatProjectTableViewCell.h"

#import "MyProjectModel.h"
#import "MyquestionViewController.h"

#define URL @"http://app.aixinland.cn/api/projects/List"


NSString *const ProjectTableViewCell = @"PatProjectTableViewCell";
@interface PatientQuestiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_myTableView;
    NSMutableArray *_dataArr;
    NSInteger _pagesize;
}
@end

@implementation PatientQuestiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _pagesize=6;
    _dataArr=[[NSMutableArray alloc]init];
    
    [self loadData];
    [self setNavView];
    [self setNavlable];
    
}
-(void)setlableview{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.text=@"暂无数据";
    label.center=self.view.center;
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    

}
-(void)loadData{
  
    _myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
    
    [_myTableView registerNib:[UINib nibWithNibName:ProjectTableViewCell bundle:nil] forCellReuseIdentifier:ProjectTableViewCell];
}
-(void)setNavlable{
    _dataArr = [NSMutableArray array];
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_pagesize];
    NSDictionary *dic = @{@"userid":UserInfoData.im,@"order":@"1",@"pageid":@"1",@"pagesize":pageStr};
    
    [rq GETURLString:@"http://app.aixinland.cn/api/userproject/List2" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
//        NSLog(@"responseObj6666666 = %@",responseObj);
    
        for (NSDictionary *dic in responseObj[@"data"]) {
            MyProjectModel *model = [[MyProjectModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArr addObject:model];
        }
        if (_dataArr.count==0) {
           [self setlableview];
        }
        else{
        [_myTableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
    }];
    
    
}
-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"选择项目";
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PatProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProjectTableViewCell];
    if (!cell) {
        cell = [[PatProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProjectTableViewCell];
    }
    MyProjectModel *model = _dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyquestionViewController *VC = [[MyquestionViewController alloc] init];
    MyProjectModel *model = _dataArr[indexPath.row];
    VC.goodIndex = model;
    
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:[NSString stringWithFormat:@"%ld%@",indexPath.row,model.uppid]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController pushViewController:VC animated:YES];
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}





@end
