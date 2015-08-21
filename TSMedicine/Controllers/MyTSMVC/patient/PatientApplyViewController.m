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
#import "MJRefresh.h"

#define IS_IPHONE_5    ([[UIScreen mainScreen ] bounds] .size.height)

#define URL @"http://app.aixinland.cn/api/userproject/List"


@interface PatientApplyViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_mytableView;
    NSMutableArray *_dataArr;
         NSInteger _pagesize;
    
}
@end

@implementation PatientApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    _pagesize=10;
    [super viewDidLoad];
    
    [self setNavView];
    
    [self setTableView];
    
    [self loadData];
    [self addRefresh];
    

}
-(void)loadData{

    NSString *pageStr = [NSString stringWithFormat:@"%ld",_pagesize];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    [dic setObject:UserInfoData.im forKey:@"userid"];
    [dic setObject:@"1"              forKey:@"pageid"];
    [dic setObject:pageStr   forKey:@"pagesize"];
    
    
    _dataArr = [NSMutableArray array];
    YYHttpRequest *hq=[[YYHttpRequest alloc]init];
    
    [hq GETURLString:URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
        
        
        
        if ([responseObj objectForKey:@"data"] !=nil) {
            NSArray *dataArr =[responseObj objectForKey:@"data"];
            
            // NSLog(@"2222223456===================%lu",(unsigned long)dataArr.count);
            
            for (NSDictionary *dic in dataArr)
            {
                MyAppModel *model = [[MyAppModel alloc] init];
                model.upname=[dic objectForKey:@"upname"];
                model.upcreatedate=[dic objectForKey:@"upcreatedate"];
                
                model.upimage=[dic  objectForKey:@"upimage"];
                model.upid=[dic objectForKey:@"upid"];
                
                
                for (int i = 0; i < dataArr.count; i ++){
                    model.upqacount=[dic  objectForKey:@"upstate"];
                    if (i % 2 == 0) {
                        model.isReport = YES;
                        
                        
                    }else{
                        model.isReport = NO;
                        
                    }
                }
                [_dataArr addObject:model];
            }
            
            NSLog(@"123123-%ld",_dataArr.count);
            
            [_mytableView reloadData];
            
        }
        [_mytableView.header endRefreshing];
        [_mytableView.footer endRefreshing];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error--%@",error);
    }];
    

}
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mark - 上下啦刷新
- (void)addRefresh
{
    __weak PatientApplyViewController * ctl = self;
    [_mytableView addLegendHeaderWithRefreshingBlock:^{
        _pagesize = 10;
        
        [_dataArr removeAllObjects];
        [ctl loadData];
    }];
    [_mytableView addLegendFooterWithRefreshingBlock:^{
       _pagesize += 10;
        [ctl loadData];
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
    
    cell.upname.text= [NSString stringWithFormat:@"%@",model.upname];
    
    
    cell.dataTime.text= [NSString stringWithFormat:@"%@",model.upcreatedate];
    
    if (model.isReport) {
        cell.upstate.text=@"审核通过";
        cell.upstate.textColor=UIColorFromRGB(0x000000FF);
    }
    else {
        cell.upstate.text=@"等待申请";
        cell.upstate.textColor=UIColorFromRGB(0x000000FF);
    }
    
    if (![model.upimage isKindOfClass:[NSNull class]]) {
    
      [cell.upimage sd_setImageWithURL:[NSURL URLWithString:model.upimage] placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
    }
    
    NSLog(@"upimage1--%@",model.upimage);
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
    nav.Goodmodel = _dataArr[indexPath.row];

    [self.navigationController pushViewController:nav animated:YES];
    
}



@end
