//
//  DonationViewController.m
//  TSMedicine
//
//  Created by lyy on 15-6-8.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DonationViewController.h"
#import "AskForDonationViewController.h"
#import "DetailModel.h"
#import "MJRefresh.h"


#define URL @"http://app.aixinland.cn/api/projects/List"

@interface DonationViewController ()
{
    NSMutableArray *_dataArry;
    NSMutableArray *_dataA;
    // 下拉刷新变量
    BOOL _isPull;
     NSInteger _page;
    
}
@property (weak, nonatomic) IBOutlet X_TableView *tableView;


@end

@implementation DonationViewController
-(void)dealloc{
   // [self.headerRefreshView free];
    //[self.footerRefreshView free];
}
- (void)viewDidLoad {
    [super viewDidLoad];
      self.title = @"捐助项目";
    _page=10;
    _dataArry=[[NSMutableArray alloc]init];
    _dataA=[[NSMutableArray alloc]init];
    
       // NSMutableArray *testArr = [[NSMutableArray alloc]init];
    [self crealade];
    [self addRefresh];
    
}

- (NSMutableArray *)ListArr
{
    if (_dataArry == nil) {
        _dataArry = [NSMutableArray array];
    }
    return _dataArry;
}
- (NSMutableArray *)itemHeightArr
{
    if (_dataA == nil) {
       _dataA = [NSMutableArray array];
    }
    return _dataA;
}

-(void)crealade{
   // NSMutableArray *arr=[[NSMutableArray alloc]init];

    NSString *pageStr = [NSString stringWithFormat:@"%ld",_page];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    [dic setObject:@"1"              forKey:@"pageid"];
    [dic setObject:pageStr      forKey:@"pagesize"];
    YYHttpRequest *hq=[YYHttpRequest shareInstance];
    
    
    
    [hq GETURLString:URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
       
        if ([responseObj objectForKey:@"data"] !=nil) {
            NSArray *dataArr =[responseObj objectForKey:@"data"];
            
            
            
            for (int i = 0; i < dataArr.count; i++)
            {
                DetailModel *model=[[DetailModel alloc]init];
                NSDictionary *dataDic = (NSDictionary *)[dataArr objectAtIndex:i];
                
                [model setValuesForKeysWithDictionary:dataDic];
                [_dataArry addObject:model];
                
                
                [_dataA addObject:[@{
                                  kCellTag:@"DonationCell",
                                  kCellDidSelect:@"DonationCell",
                                  @"donation_titleLab":[dataDic objectForKey:@"pname"],
                                  @"donation_contentlab":[dataDic objectForKey:@"pjieshao"],
                                  @"donation_unitlab":[dataDic objectForKey:@"pfaqidanwei"],
                                  @"donation_imgView":[dataDic  objectForKey:@"pimage"],
                                  } mutableCopy]];
                
                
            }
            self.tableView.xDataSource = _dataA;
            
            [self.tableView reloadData];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
            
        }
        [self lable];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {


        
    }];

}
#pragma mark - 上下啦刷新
- (void)addRefresh
{
    __weak DonationViewController * ctl = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        _page = 10;

        [_dataA removeAllObjects];
        [ctl crealade];
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        _page += 10;
        [ctl crealade];
    }];
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}
-(void)lable{
    
    WEAKSELF
    [self.tableView addCellEventListenerWithName:@"DonationCell" block:^(X_TableViewCell *cell) {
        
        NSIndexPath *indexPath = [weakSelf.tableView indexPathForCell:cell];
        NSLog(@"-----cell-->>\n%ld",(long)indexPath.row);
        
        AskForDonationViewController *askVC = [AskForDonationViewController new];
        askVC.hidesBottomBarWhenPushed = YES;
        
       
        askVC.model=_dataArry[indexPath.row];
        
        [weakSelf.navigationController pushViewController:askVC animated:YES];
    }];
}




@end
