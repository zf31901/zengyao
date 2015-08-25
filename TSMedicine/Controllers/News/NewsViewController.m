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




#define URLisr @"http://app.aixinland.cn//page/news_detail.html?dataId=%@"

#define IS_IPHONE_5    ([[UIScreen mainScreen ] bounds] .size.height)

@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
//MBProgressHUDDelegate
{
    NSMutableArray  *brr;
    NSMutableArray  *arr;
    
    NSMutableArray *_dataArr;
    UITableView *_mytableView;
    NSString *tree;
    //NSInteger a_id;
    NSInteger _page;
}


@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr=[[NSMutableArray alloc]init];
      _page=30;
    _mytableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, IS_IPHONE_5-44-64) style:UITableViewStyleGrouped];
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
        _page = 30;
        [_dataArr removeAllObjects];
        [ctl UILABLE];
    }];
//    [_mytableView addLegendFooterWithRefreshingBlock:^{
//       // _page += 10;
//       // [ctl UILABLE];
//    }];
}
-(void)UILABLE{
    
    
    
    arr = [[NSMutableArray alloc] init];
    brr=[[NSMutableArray alloc]init];
    
    NSString *pageStr = [NSString stringWithFormat:@"%ld",_page];
  
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    [dic setObject:@"1"              forKey:@"pageid"];
    [dic setObject:pageStr     forKey:@"pagesize"];

    YYHttpRequest *hq = [[YYHttpRequest alloc] init];
    
    [hq POSTURLString:@"http://app.aixinland.cn/api/news/List2" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//       NSLog(@"12390---%@",responseObject);
        
        if ([responseObject objectForKey:@"data"] !=nil)
        {
            NSArray *dataArr =[responseObject objectForKey:@"data"];
            for (int i = 0; i < dataArr.count; i ++)
            {
                NewsModel *newModel = [[NewsModel alloc] init];
                NSDictionary *dataDic = (NSDictionary *)[dataArr objectAtIndex:i];
                newModel.a_Title = [dataDic objectForKey:@"a_Title"];
                newModel.a_From = [dataDic objectForKey:@"a_From"];
                newModel.a_time = [dataDic objectForKey:@"time"];
                
                newModel.a_SmallImg=[dataDic objectForKey:@"a_SmallImg"];
                newModel.a_ID=[dataDic objectForKey:@"a_ID"];
                [_dataArr addObject:newModel];
            }

            [_mytableView reloadData];
            [_mytableView.header endRefreshing];
            [_mytableView.footer endRefreshing];
            
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
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.a_SmallImg]]];
//         NSLog(@"%f-----%f",image.size.width,image.size.height);
        
        cell.iamgeView.height = image.size.height;
        
        CGRect imageViewFrame = cell.iamgeView.frame;
        cell.newlabel.y = frame.size.height + 10 + imageViewFrame.size.height + 10;
        cell.dataTimew.y = frame.size.height + 10 + imageViewFrame.size.height + 10;
        
        [cell.iamgeView setImageWithURL:[NSURL URLWithString:model.a_SmallImg]];
        
          return cell;
    }

    else{
      
        NewsTableViewCell *cell1=[tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
        NewsModel *model = [_dataArr objectAtIndex:indexPath.row];
        
        cell1.newlab.text=model.a_Title;
        cell1.newlab.numberOfLines=0;
        
        cell1.fromLab.text=model.a_From;
        
        CGRect rect1 = [cell1.newlab.text boundingRectWithSize:CGSizeMake(200, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell1.newlab.font} context:nil];
        cell1.newlab.bounds = CGRectMake(0, 0, rect1.size.width, 120);
        
        cell1.dataTimelab.text=model.a_time;
        
        [cell1.iamge setImageWithURL:[NSURL URLWithString:model.a_SmallImg] ];
        
        return cell1;
        
    return nil;
}
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row ) {
        
        NewsModel *model = [_dataArr objectAtIndex:indexPath.row];
        
        CGRect rect = [model.a_Title boundingRectWithSize:CGSizeMake(304, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.a_SmallImg]]];
        
//        NSLog(@"image_Height == %f",image_Height);
        
        return 50 + rect.size.height + image.size.height ;
        
    }else{
        NewsModel *model = [_dataArr objectAtIndex:indexPath.row];
        
         CGRect rect1 = [model.a_Title boundingRectWithSize:CGSizeMake(200, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        
        return 87+rect1.size.height;
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

@end
