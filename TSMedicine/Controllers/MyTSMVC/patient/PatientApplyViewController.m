//
//  PatientApplyViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-6.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "PatientApplyViewController.h"
#import "MyAppModel.h"
#import "MyAppCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "AppprogressViewController.h"



#define URL @"http://app.aixinland.cn/api/userproject/List"
@interface PatientApplyViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_mytableView;
    NSMutableArray *_dataArr;
    
    
}
@end

@implementation PatientApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    
    [super viewDidLoad];
    
    [self setNavView];
    
    [self setTableView];
    
    //  NSMutableArray *testArr = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    [dic setObject:@"0" forKey:@"userid"];
    [dic setObject:@"1"              forKey:@"pageid"];
    [dic setObject:@"4"    forKey:@"pagesize"];
    //    _pagesize=@"1";
    //    _pagesize=@"2";
    //    _pagesize=@"3";
    //_pagesize=@"4";
    
    
    
    //    NSString *num=@"4";
    //    [dic setObject:num forKey:@"pagesize"];
    
    _dataArr = [NSMutableArray array];
    YYHttpRequest *hq=[[YYHttpRequest alloc]init];
    
    [hq GETURLString:URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
        
        NSLog(@"11111111123%@",responseObj);
        
        if ([responseObj objectForKey:@"data"] !=nil) {
            NSArray *dataArr =[responseObj objectForKey:@"data"];
            
            NSLog(@"2222223456===================%lu",(unsigned long)dataArr.count);
            
            for (NSDictionary *dic in dataArr)
            {
                MyAppModel *model = [[MyAppModel alloc] init];
                model.upname1=[dic objectForKey:@"upname"];
                model.upcreatedate1=[dic objectForKey:@"upcreatedate"];
                
                model.upimage1=[dic  objectForKey:@"upimage"];
                
                [_dataArr addObject:model];
            }
            
            NSLog(@"123123-%ld",_dataArr.count);
            
            [_mytableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error--%@",error);
    }];
    
    
    

}
-(void)setTableView
{
    _mytableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _mytableView.delegate =self;
    _mytableView.dataSource =self;
    [self.view addSubview:_mytableView];
    
    [_mytableView registerNib:[UINib nibWithNibName:@"MyAppCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的申请";
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyAppCellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell=[[MyAppCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    
    MyAppModel *model=[_dataArr objectAtIndex:indexPath.row];
    
    cell.upname.text= [NSString stringWithFormat:@"%@",model.upname1];
    
    
    cell.dataTime.text= [NSString stringWithFormat:@"%@",model.upcreatedate1];
    //  [cell.upimage setImageWithURL:[NSURL URLWithString:model.upimage1] ];
//    [cell.upimage sd_setImageWithURL:[NSURL URLWithString:model.upimage1]];
    
    if (model.upimage1) {
        //cell.upimage.image = [UIImage imageWithContentsOfFile:model.upimage1];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.upimage1]];
        
     // [cell.upimage sd_setImageWithURL:[NSURL URLWithString:model.upimage1] placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
    }
    
    NSLog(@"upimage1--%@",model.upimage1);
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppprogressViewController *nav=[[AppprogressViewController alloc]init];
    [self.navigationController pushViewController:nav animated:YES];
    
}



@end
