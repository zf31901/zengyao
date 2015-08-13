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
#import "APPlicationProgressViewController.h"


#define IS_IPHONE_5    ([[UIScreen mainScreen ] bounds] .size.height)

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
   
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    [dic setObject:@"0" forKey:@"userid"];
    [dic setObject:@"1"              forKey:@"pageid"];
    [dic setObject:@"5"    forKey:@"pagesize"];

    
    _dataArr = [NSMutableArray array];
    YYHttpRequest *hq=[[YYHttpRequest alloc]init];
    
    [hq GETURLString:URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
        
       
        
        if ([responseObj objectForKey:@"data"] !=nil) {
            NSArray *dataArr =[responseObj objectForKey:@"data"];
            
           // NSLog(@"2222223456===================%lu",(unsigned long)dataArr.count);
            
            for (NSDictionary *dic in dataArr)
            {
                MyAppModel *model = [[MyAppModel alloc] init];
                model.upname1=[dic objectForKey:@"upname"];
                model.upcreatedate1=[dic objectForKey:@"upcreatedate"];
                
                model.upimage1=[dic  objectForKey:@"upimage"];
                for (int i = 0; i < dataArr.count; i ++){
                if (i % 2 == 0) {
                    model.isReport = YES;
                    model.upqacount1=[dic  objectForKey:@"upstate"];
                }else{
                    model.isReport = NO;
                }
                }
                [_dataArr addObject:model];
            }
            
            NSLog(@"123123-%ld",_dataArr.count);
            
            [_mytableView reloadData];
            }
       // }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error--%@",error);
    }];
    
    
    

}
-(void)setTableView
{
     _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, IS_IPHONE_5-25) style:UITableViewStyleGrouped];
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
    
   // cell.upstate.text=[NSString stringWithFormat:@"%@人回答",model.upqacount1];

    
    if (![model.upimage1 isKindOfClass:[NSNull class]]) {
    
      [cell.upimage sd_setImageWithURL:[NSURL URLWithString:model.upimage1] placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
    }
    
    NSLog(@"upimage1--%@",model.upimage1);
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    APPlicationProgressViewController *nav=[[APPlicationProgressViewController alloc]init];
    nav.model = _dataArr[indexPath.row];

    [self.navigationController pushViewController:nav animated:YES];
    
}



@end
