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
#define HTMURL @"http://app.aixinland.cn/api/userproject/CheckState?dataId=%@&userid=%@"
#define Patient_Type1 @"01"         //患者
#define Patient_Type2 @""           //患者


@interface DonationViewController ()
{
    NSMutableArray *_dataArry;
    NSMutableArray *_dataA;
    // 下拉刷新变量
    BOOL _isPull;
     NSInteger _page;
    NSInteger  _dataId;
    
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
        [_dataArry removeAllObjects];
        [_dataA removeAllObjects];
        [ctl crealade];
    }];
//    [self.tableView addLegendFooterWithRefreshingBlock:^{
//        _page += 10;
//        [ctl crealade];
//    }];
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
        
        YYHttpRequest *rq = [[YYHttpRequest alloc] init];
        
        if ([GlobalMethod sharedInstance].isLogin) {
            
            DetailModel *model = _dataArry[indexPath.row];
            
            NSString *prm=[NSString stringWithFormat:HTMURL,model.pid,UserInfoData.im];
            
            [rq GET:prm parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSLog(@"responseObject1234已登陆--%@",responseObject);
                NSLog(@"message == %@",responseObject[@"message"]);
                
                if ([responseObject[@"data"] boolValue]) {
                    
                     AskForDonationViewController *askVC = [AskForDonationViewController new];
                     askVC.hidesBottomBarWhenPushed = YES;
                    
                    if ([UserInfoData.Type isEqualToString:Patient_Type1] || [UserInfoData.Type isEqualToString:Patient_Type2]) {
                            askVC.userID = UserInfoData.im;
                    }
                
                    askVC.model = _dataArry[indexPath.row];
                    [weakSelf.navigationController pushViewController:askVC animated:YES];
                    
                }else{
                    
                    AskForDonationViewController *askVC = [AskForDonationViewController new];
                    askVC.hidesBottomBarWhenPushed = YES;
                     askVC.model = _dataArry[indexPath.row];
                    [weakSelf.navigationController pushViewController:askVC animated:YES];
                
                }
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
            
        }else{
           
            AskForDonationViewController *askVC = [AskForDonationViewController new];
            askVC.hidesBottomBarWhenPushed = YES;
             askVC.model = _dataArry[indexPath.row];
            [weakSelf.navigationController pushViewController:askVC animated:YES];
    
        }
        
   
    }];
}




@end
