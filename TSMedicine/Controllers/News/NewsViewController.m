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
#import "FootLabel.h"


#import "UIImageView+AFNetworking.h"

#define URLisr @"http://app.aixinland.cn//page/news_detail.html?dataId=%@"


@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

{
    NSMutableArray  *brr;
    NSMutableArray  *arr;
    
    NSMutableArray *_dataArr;
    UITableView *_mytableView;
    NSString *tree;
    NSInteger a_id;
    
    
    
    
}
@property(nonatomic,strong)FootLabel *footerLabel;
@property (nonatomic,assign)NSInteger count;//控制行数
@property (nonatomic,assign)CGSize recordSize;//记录当前UITableView的ContentSize;
@end

@implementation NewsViewController
-(void)dealloc{
    
    //移除观察者
    [_mytableView   removeObserver:self forKeyPath:@"contentOffset"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self  caselable];
    
    _dataArr=[[NSMutableArray alloc]init];
    
    _mytableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _mytableView.delegate =self;
    _mytableView.dataSource =self;
    
    [_mytableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
    
    [_mytableView registerNib:[UINib nibWithNibName:@"newCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_mytableView];
    
    
    self.title = @"新闻";

   [self UILABLE];
   
    
    
}
-(void)caselable{
    
    //关闭优化机制
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //实例化一个FootLabel类型的对象
    self.footerLabel = [[FootLabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    
    self.footerLabel.textAlignment = NSTextAlignmentCenter;
    self.footerLabel.text = @"加载更多";
    
    //设置为UITabelView的尾部视图
    _mytableView.tableFooterView = self.footerLabel;

    //观察myTableView的contentSize
    
    [_mytableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];

}


-(void)UILABLE{
    
    
    
    arr = [[NSMutableArray alloc] init];
    brr=[[NSMutableArray alloc]init];
    
  
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    [dic setObject:@"1"              forKey:@"pageid"];
    [dic setObject:@"4"      forKey:@"pagesize"];

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
                newModel.a_AddDate = [dataDic objectForKey:@"a_AddDate"];
                
                newModel.a_SmallImg=[dataDic objectForKey:@"a_SmallImg"];
                newModel.a_ID=[dataDic objectForKey:@"a_ID"];
                [_dataArr addObject:newModel];
                
             //   NSLog(@"rqdic1111----%@",dataDic);
                

                
            }

            [_mytableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];



}
-(void)finish{
    
    //增加行数
    self.count += 3;
    
    //恢复为非加载状态
    self.footerLabel.isFreshState = NO;
    
    //恢复文字显示
    self.footerLabel.text = @"加载更多";
    
    [_mytableView reloadData];
    
    
}

#pragma mark- KVO回调方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    
    //判断是否为对应的观者属性
    if ([keyPath isEqualToString:@"contentOffset"] && object == _mytableView) {
        
        NSLog(@"change = %@",change);
        NSLog(@"%f",_mytableView.contentSize.height);
        
        //取得偏移量的值
        NSValue *offsetValue = change[@"new"];
        CGPoint offsetPoint = [offsetValue CGPointValue];
        
        if (offsetPoint.y + _mytableView.frame.size.height >= _mytableView.contentSize.height) {
            
            //保证如果 处于加载状态，期间再触发此方法，也不会重复加载
            if (!self.footerLabel.isFreshState) {
                self.footerLabel.isFreshState = YES;
                
                //滑动到最底端
                self.footerLabel.text = @"加载刷新中.....";
                
                //延时执行某个方法
                [self performSelector:@selector(finish) withObject:nil afterDelay:3.0f];
            }
            
            
        }
        
        
    }
    
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
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
        CGRect rect = [cell.fromeLable.text boundingRectWithSize:CGSizeMake(200, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell.fromeLable.font} context:nil];

        cell.fromeLable.frame = CGRectMake(0, 0, 320, rect.size.height);
        
        cell.newlabel.text=model.a_From;
        cell.dataTimew.text=model.a_AddDate;
      
       
        
        [cell.iamgeView setImageWithURL:[NSURL URLWithString:model.a_SmallImg]];
          return cell;
    }

    else{
      
        NewsTableViewCell *cell1=[tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
        NewsModel *model = [_dataArr objectAtIndex:indexPath.row];
        
        cell1.newlab.text=model.a_Title;
        cell1.newlab.numberOfLines=0;
       
        cell1.fromLab.text=model.a_From;

        CGRect rect = [cell1.newlab.text boundingRectWithSize:CGSizeMake(200, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:cell1.newlab.font} context:nil];
    cell1.newlab.frame = CGRectMake(0, 0, 200, rect.size.height);
       
        
        NSLog(@"cell1.fromLab-----%@",cell1.newlab);
      //  NSLog(@"cell1.fromLab%@",cell1.fromLab);
       
        cell1.dataTimelab.text=model.a_AddDate;
            
            [cell1.iamge setImageWithURL:[NSURL URLWithString:model.a_SmallImg] ];
            
           
    
        return cell1;

   

    return nil;
}
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row ) {
        return 170;
    }else
    {
        return 100;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *ctl2=[[DetailsViewController alloc]init];
    NewsModel *arr=_dataArr[indexPath.row];
    ctl2.goodIndex=arr.a_ID;
    [self.navigationController pushViewController:ctl2 animated:YES];
}


@end
