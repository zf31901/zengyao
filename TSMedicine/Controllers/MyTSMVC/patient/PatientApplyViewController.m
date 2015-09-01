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
    NSInteger _pageID;

    
}
@end

@implementation PatientApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    _pagesize=6;
    [super viewDidLoad];
    
    [self setNavView];
    
    [self setTableView];
    
    [self loadData];
    [self addRefresh];
    

}
-(void)loadData{
    _dataArr = [[NSMutableArray alloc]init];
       _pageID = _pageID!=0?_pageID:1;
    NSString *pageStr = [NSString stringWithFormat:@"%ld",_pagesize];
        NSString *pageID = [NSString stringWithFormat:@"%ld",_pageID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    [dic setObject:UserInfoData.im forKey:@"userid"];
    [dic setObject:pageID              forKey:@"pageid"];
    [dic setObject:pageStr   forKey:@"pagesize"];
    YYHttpRequest *hq=[[YYHttpRequest alloc]init];
    [hq GETURLString:URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
         BOOL state = NO;
        if ([responseObj objectForKey:@"data"] !=nil) {
            NSArray *dataArr =[responseObj objectForKey:@"data"];
            if (dataArr.count == 0) {
                state = YES;
            }

            for (NSDictionary *dic in dataArr)
            {
                MyAppModel *model = [[MyAppModel alloc] init];
               
                [model setValuesForKeysWithDictionary:dic];
                
                [_dataArr addObject:model];
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
        _pagesize = 6;
        [_dataArr removeAllObjects];
        [ctl loadData];
    }];

}
-(void)setTableView
{
     _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, ScreenHeight-25) style:UITableViewStyleGrouped];
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
   cell.upname.numberOfLines=0;
    NSString *dateStr = [model.upcreatedate substringWithRange:NSMakeRange(0, 10)];
    NSString *timeStr = [model.upcreatedate substringWithRange:NSMakeRange(11, 5)];
   
    cell.dataTime.text = [NSString stringWithFormat:@"%@ %@",dateStr,timeStr];


    
    if ([model.upstate boolValue] == 0) {
        cell.upstate.text=@"审核未通过";
        cell.upstate.textColor=UIColorFromRGB(0xFF6600);
    }
    else if ([model.upstate boolValue] == 1) {
        cell.upstate.text=@"未审核";
        cell.upstate.textColor=UIColorFromRGB(0x20A456);
    }
    else if ([[NSString stringWithFormat:@"%@",model.upstate] isEqualToString:@"2"]){
        cell.upstate.text=@"审核通过";
        cell.upstate.textColor=UIColorFromRGB(0xFF6600);
    }else{
        cell.upstate.text=@"用户正提交申请";
        cell.upstate.textColor=UIColorFromRGB(0x20A456);
    
    
    }
    
    if (![model.upimage isKindOfClass:[NSNull class]]) {
    
      [cell.upimage sd_setImageWithURL:[NSURL URLWithString:model.upimage] placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];
    }

    NSLog(@"upimage1--%@",model.upimage);
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 82.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    APPlicationProgressViewController *nav=[[APPlicationProgressViewController alloc]init];
    MyAppModel *model = _dataArr[indexPath.row];
    nav.Goodmodel = model;
    [self.navigationController pushViewController:nav animated:YES];
    
}



@end
