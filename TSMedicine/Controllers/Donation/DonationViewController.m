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
#import "DonationCell.h"

#define URL @"http://app.aixinland.cn/api/projects/List"
#define HTMURL @"http://app.aixinland.cn/api/userproject/CheckState?dataId=%@&userid=%@"
#define Patient_Type1 @"01"         //患者
#define Patient_Type2 @""           //患者


@interface DonationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArry;
  
    UITableView *_mytableView;

//    // 下拉刷新变量
//    BOOL _isPull;
     NSInteger _page;
    NSInteger  _dataId;
    NSInteger _pageID;

    
}

@end

@implementation DonationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.title = @"捐助项目";
    _dataArry=[[NSMutableArray alloc]init];
    _page=10;
    
     [self UItabview];
    [self crealade];
    [self addRefresh];
   
    
}
-(void)UItabview{
    _mytableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-44-64) style:UITableViewStyleGrouped];
    _mytableView.delegate =self;
    _mytableView.dataSource =self;
    
    [_mytableView registerNib:[UINib nibWithNibName:@"DonationCell" bundle:nil] forCellReuseIdentifier:@"DonaCell"];
  
    [self.view addSubview:_mytableView];

}
- (NSMutableArray *)_dataArry
{
    if (_dataArry == nil) {
        _dataArry = [NSMutableArray array];
    }
    return _dataArry;
}


-(void)crealade{
 
    _pageID = _pageID!=0?_pageID:1;
    NSString *pageStr = [NSString stringWithFormat:@"%ld",_page];
    NSString *pageID = [NSString stringWithFormat:@"%ld",_pageID];
 
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    [dic setObject:pageID       forKey:@"pageid"];
    [dic setObject:pageStr      forKey:@"pagesize"];
    YYHttpRequest *hq=[YYHttpRequest shareInstance];
    [hq GETURLString:URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        BOOL state = NO;
        if ([responseObj objectForKey:@"data"] !=nil)
        {
            NSArray *dataArr =[responseObj objectForKey:@"data"];
            if (dataArr.count == 0) {
                state = YES;
            }
            for (int i = 0; i < dataArr.count; i++)
            {
                DetailModel *model=[[DetailModel alloc]init];
                NSDictionary *dataDic = (NSDictionary *)[dataArr objectAtIndex:i];
                
                [model setValuesForKeysWithDictionary:dataDic];
                [_dataArry addObject:model];
                
            }
          
            
            [_mytableView reloadData];
        }
            [_mytableView.header endRefreshing];
            [_mytableView.footer endRefreshing];
            
            if (state)
            {
              _mytableView.footer.state = MJRefreshFooterStateNoMoreData;
                
             }
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {


        
    }];

}
#pragma mark - 上下啦刷新
- (void)addRefresh
{
    __weak DonationViewController * ctl = self;
    [_mytableView addLegendHeaderWithRefreshingBlock:^{
        _page = 10;
        _pageID=1;
        [_dataArry removeAllObjects];
    
        [ctl crealade];
    }];
    [_mytableView addLegendFooterWithRefreshingBlock:^{
        _pageID++;
    
        [ctl crealade];
    }];
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}

#pragma mark - UITableViewDelegate

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DonationCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"DonaCell"];
    if (!cell1) {
        cell1 = [[DonationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DonaCell"];
    }

    
    [cell1 loadDataWithDataArray:_dataArry andWithIndexPath:indexPath];
  
        return cell1;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 90.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    
    if ([GlobalMethod sharedInstance].isLogin) {
        
        DetailModel *model = _dataArry[indexPath.row];
        
        NSString *prm=[NSString stringWithFormat:HTMURL,model.pid,UserInfoData.im];
        
        [rq GET:prm parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
//            NSLog(@"responseObject1234已登陆--%@",responseObject);
//            NSLog(@"message == %@",responseObject[@"message"]);
            
            if ([responseObject[@"data"] boolValue]) {
                
                AskForDonationViewController *askVC = [AskForDonationViewController new];
                                     askVC.hidesBottomBarWhenPushed = YES;
                
            if ([UserInfoData.Type isEqualToString:Patient_Type1] || [UserInfoData.Type isEqualToString:Patient_Type2]) {
                    askVC.userID = UserInfoData.im;
                                    }
                
            askVC.model = _dataArry[indexPath.row];
          [self.navigationController pushViewController:askVC animated:YES];
                
            }else{
                
                AskForDonationViewController *askVC = [AskForDonationViewController new];
                                    askVC.hidesBottomBarWhenPushed = YES;
                                     askVC.model = _dataArry[indexPath.row];
                                   [self.navigationController pushViewController:askVC animated:YES];
                
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    }else{
        
        AskForDonationViewController *askVC = [AskForDonationViewController new];
        askVC.hidesBottomBarWhenPushed = YES;
        askVC.model = _dataArry[indexPath.row];
        [self.navigationController pushViewController:askVC animated:YES];

        
    }
    
    





}

//-(void)lable{
//    
//    WEAKSELF
//    [self.tableView addCellEventListenerWithName:@"DonationCell" block:^(X_TableViewCell *cell) {
//        
//        NSIndexPath *indexPath = [weakSelf.tableView indexPathForCell:cell];
//        NSLog(@"-----cell-->>\n%ld",(long)indexPath.row);
//        
//        YYHttpRequest *rq = [[YYHttpRequest alloc] init];
//        
//        if ([GlobalMethod sharedInstance].isLogin) {
//            
//            DetailModel *model = _dataArry[indexPath.row];
//            
//            NSString *prm=[NSString stringWithFormat:HTMURL,model.pid,UserInfoData.im];
//            
//            [rq GET:prm parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                
//                NSLog(@"responseObject1234已登陆--%@",responseObject);
//                NSLog(@"message == %@",responseObject[@"message"]);
//                
//                if ([responseObject[@"data"] boolValue]) {
//                    
//                     AskForDonationViewController *askVC = [AskForDonationViewController new];
//                     askVC.hidesBottomBarWhenPushed = YES;
//                    
//                    if ([UserInfoData.Type isEqualToString:Patient_Type1] || [UserInfoData.Type isEqualToString:Patient_Type2]) {
//                            askVC.userID = UserInfoData.im;
//                    }
//                
//                    askVC.model = _dataArry[indexPath.row];
//                    [weakSelf.navigationController pushViewController:askVC animated:YES];
//                    
//                }else{
//                    
//                    AskForDonationViewController *askVC = [AskForDonationViewController new];
//                    askVC.hidesBottomBarWhenPushed = YES;
//                     askVC.model = _dataArry[indexPath.row];
//                    [weakSelf.navigationController pushViewController:askVC animated:YES];
//                
//                }
//                
//                
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                
//            }];
//            
//        }else{
//           
//            AskForDonationViewController *askVC = [AskForDonationViewController new];
//            askVC.hidesBottomBarWhenPushed = YES;
//             askVC.model = _dataArry[indexPath.row];
//            [weakSelf.navigationController pushViewController:askVC animated:YES];
//    
//        }
//        
//   
//    }];
//}




@end
