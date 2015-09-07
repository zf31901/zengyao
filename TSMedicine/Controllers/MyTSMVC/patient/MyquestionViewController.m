//
//  MyquestionViewController.m
//  TSMedicine
//
//  Created by 123 on 15/8/7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyquestionViewController.h"
#import "MYquestion.h"
#import "myquerstionTableViewCell.h"
#import "QuestionTurnViewController.h"
#import "QuestionViewController.h"
#import "MJRefresh.h"

#define URL @"http://app.aixinland.cn/api/userquestion/List"


@interface MyquestionViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_mytableView;

    NSInteger _pagesize;
    NSInteger _pagID;
    
    
}
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation MyquestionViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self loadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    _pagesize=30;
    [self setNavView];
 
    [self setTableView];
    [self addRefresh];
    
}

#pragma mark ---------------- 上下啦刷新-------------
- (void)addRefresh
{
    __weak MyquestionViewController * ctl = self;
    [_mytableView addLegendHeaderWithRefreshingBlock:^{
       _pagesize = 10;
        _pagID=1;
        [_dataArr removeAllObjects];
        [ctl loadData];
    }];
//    [_mytableView addLegendFooterWithRefreshingBlock:^{
//        _pagID++;
//        
//       [ctl loadData];
//    }];


}
-(void)loadAlertUI
{
    UILabel *label = [WIBaseLabel createClassWithTitle:@"您暂无提问" andWithFrame:CGRectMake(0, 0, 120, 20) andWithFont:17];
    label.center = self.view.center;
    label.midY = label.center.y - 50;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}
-(void)loadData{
   
    
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    _pagID =_pagID!=0?_pagID:1;
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_pagesize];
    NSString *pageID=[NSString stringWithFormat:@"@%ld",(long)_pagID];
    
    NSDictionary *dic = nil;
    if (_goodIndex) {
        
        dic = @{@"pid":_goodIndex.uppid,@"userid":UserInfoData.im,@"pageid":@"1",@"pagesize":pageStr};
    }
    if (_model) {
        
        dic = @{@"pid":_model.uppid,@"userid":UserInfoData.im,@"pageid":@"1",@"pagesize":pageStr};
    }
    
    [rq GETURLString:@"http://app.aixinland.cn/api/userquestion/List" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
//        NSLog(@"responseObj555 == %@",responseObj);
//        BOOL state = NO;
//        NSArray *dataArr =[responseObj objectForKey:@"data"];
//        if (dataArr.count == 0) {
//            state = YES;
       // }
        for (NSDictionary *dic in responseObj[@"data"]) {
            MyPatQuestModel *model = [[MyPatQuestModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArr addObject:model];
        }
       // if (_dataArr.count>0) {
            [_mytableView reloadData];
      //  }
      //  else{
//            [_mytableView removeFromSuperview];
//            _mytableView=nil;
//            [self loadAlertUI];
//            
//        }
    
        [_mytableView.header endRefreshing];
        [_mytableView.footer endRefreshing];
//        if (state)
//        {
//            _mytableView.footer.state = MJRefreshFooterStateNoMoreData;
//            
//        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
    
    }];


}
-(void)setTableView
{
    _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-44) style:UITableViewStyleGrouped];
    _mytableView.delegate =self;
    _mytableView.dataSource =self;
    [self.view addSubview:_mytableView];
  [_mytableView registerNib:[UINib nibWithNibName:@"myquerstionTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}
- (void)commit
{
    QuestionTurnViewController *commitVC = [QuestionTurnViewController new];
    if (_goodIndex) {
        commitVC.model= _goodIndex;
    }
    if (_model) {
        commitVC.appModel= _model;
    }
    [self.navigationController pushViewController:commitVC animated:YES];
    
}
-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的提问";
    [self buidRightBtn:@"提问"];
    
}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   if (_dataArr.count > 0)
{
    return _dataArr.count;
}
else{
    return 0;
}
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myquerstionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        
    cell=[[myquerstionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.indexPath = indexPath;
    MyPatQuestModel *model1=nil;
    if (_dataArr.count>0) {
       model1 = _dataArr[indexPath.row];
    }

    cell.model = model1;
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    MyPatQuestModel *model=nil;
    if (_dataArr.count>0) {
       model = _dataArr[indexPath.row];
    }
    
    return  80.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QuestionViewController *nav=[[QuestionViewController alloc]init];
    
    MyPatQuestModel *model = _dataArr[indexPath.row];
    nav.model = model;
    
//    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:[NSString stringWithFormat:@"%ld%@",indexPath.row,model.uqid]];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController pushViewController:nav animated:YES];

}

- (void)back
{
    if (_isWeb) {
        
        [self.navigationController popToViewController:self.navigationController.viewControllers[2] animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
