//
//  NewsViewController.m
//  TSMedicine
//
//  Created by lyy on 15-6-10.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsModel.h"
#import "DetailsViewController.h"
#import "NewsTableViewCell.h"
#import "newCell.h"

#import "UIImageView+AFNetworking.h"
#import "MJRefresh.h"

//#import "UIView+Extension.h"


#define URLisr @"http://app.aixinland.cn//page/news_detail.html?dataId=%@"
@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

{
    NSMutableArray  *brr;
    NSMutableArray  *arr;
    
    NSMutableArray *_dataArr;
    UITableView *_mytableView;
    NSString *tree;
    //NSInteger a_id;
    NSInteger _page;
    NSInteger _pageID;
}


@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr=[[NSMutableArray alloc]init];
    _page=10;
    _mytableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-44-64) style:UITableViewStyleGrouped];
    _mytableView.delegate =self;
    _mytableView.dataSource =self;
    
    [_mytableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
    
    [_mytableView registerNib:[UINib nibWithNibName:@"newCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_mytableView];
    [self addRefresh];
    
    
    self.title = @"新闻";
    [self UILABLE];
    
}
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr  = [NSMutableArray array];
    }
    return _dataArr ;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}
#pragma mark - 上下啦刷新
- (void)addRefresh
{
    __weak NewsViewController * ctl = self;
    [_mytableView addLegendHeaderWithRefreshingBlock:^{
        _page = 10;
        _pageID = 1;
        [_dataArr removeAllObjects];
        [ctl UILABLE];
    }];
    [_mytableView addLegendFooterWithRefreshingBlock:^{
        _pageID++;
        [ctl UILABLE];
    }];
}
-(void)UILABLE{
    
    
    
    arr = [[NSMutableArray alloc] init];
    brr=[[NSMutableArray alloc]init];
    _pageID = _pageID!=0?_pageID:1;
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_page];
    NSString *pageID = [NSString stringWithFormat:@"%ld",(long)_pageID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    [dic setObject:pageID       forKey:@"pageid"];
    [dic setObject:pageStr      forKey:@"pagesize"];
    
    YYHttpRequest *hq = [[YYHttpRequest alloc] init];
    
    [hq POSTURLString:@"http://app.aixinland.cn/api/news/List2" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL state = NO;
        if ([responseObject objectForKey:@"data"] !=nil)
        {
            NSArray *dataArr =[responseObject objectForKey:@"data"];
            if (dataArr.count == 0) {
                state = YES;
            }
            
            for (int i = 0; i < dataArr.count; i ++)
            {
                NewsModel *newModel = [[NewsModel alloc] init];
                NSDictionary *dataDic = (NSDictionary *)[dataArr objectAtIndex:i];
                [newModel loadModel:dataDic];
                
                [_dataArr addObject:newModel];
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
        NSLog(@"error");
    }];
}


#pragma mark - UITableViewDelegate

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (0 == indexPath.row)
    {
        newCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell == nil)
        {
            cell = [[newCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        NewsModel *model = [_dataArr objectAtIndex:indexPath.row];
        
        cell.fromeLable.text=model.a_Title;
        cell.fromeLable.numberOfLines=0;
        CGRect rect = [cell.fromeLable.text boundingRectWithSize:CGSizeMake(300, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell.fromeLable.font} context:nil];
        
        cell.fromeLable.frame = CGRectMake(10, 0, 300, rect.size.height);
        
        CGRect frame = cell.fromeLable.frame;
        cell.iamgeView.y = frame.size.height + 10;
        
        cell.newlabel.text=model.a_From;
        cell.dataTimew.text=model.a_time;
        
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        [imageView setImageWithURL:[NSURL URLWithString:model.a_SmallImg]];
        
        cell.iamgeView.height = imageView.image.size.height;
        
        CGRect imageViewFrame = cell.iamgeView.frame;
        cell.newlabel.y = frame.size.height + 10 + imageViewFrame.size.height + 10;
        cell.dataTimew.y = frame.size.height + 10 + imageViewFrame.size.height + 10;
        
        [cell.iamgeView setImage:imageView.image];
        
        return cell;
    }
    
    else{
        
        NewsTableViewCell *cell1=[tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
        NewsModel *model = [_dataArr objectAtIndex:indexPath.row];
        
        [cell1 loadCellWith:model];
        
        
        
        return cell1;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row ) {
        
        NewsModel *model = [_dataArr objectAtIndex:indexPath.row];
        
        CGRect rect = [model.a_Title boundingRectWithSize:CGSizeMake(304, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.a_SmallImg]]];
        
        return 40 + rect.size.height + image.size.height ;
        
    }else{
        NewsModel *model = [_dataArr objectAtIndex:indexPath.row];
        
        return model.CellH;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *ctl2=[[DetailsViewController alloc]init];
    
    NewsModel *arr=_dataArr[indexPath.row];
    
    ctl2.model=arr.a_ID;
    [self.navigationController pushViewController:ctl2 animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
    
}

@end
