//
//  MyquestionViewController.m
//  TSMedicine
//
//  Created by 123 on 15/8/7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyquestionViewController.h"
#import "MYquestion.h"
#import "MYquestionTableViewCell.h"


#define URL @"http://app.aixinland.cn/api/userquestion/List"


@interface MyquestionViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_mytableView;
    NSMutableArray *_dataArr;
    
    
}

@end

@implementation MyquestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self setNavView];
    
    [self setTableView];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    [dic setObject:@"0" forKey:@"pid"];
    [dic setObject:@"903050" forKey:@"userid"];
    [dic setObject:@"1"              forKey:@"pageid"];
    [dic setObject:@"10"    forKey:@"pagesize"];
   
    
    _dataArr = [NSMutableArray array];
    YYHttpRequest *hq=[[YYHttpRequest alloc]init];
    
    [hq GETURLString:URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
        
       
        
        if ([responseObj objectForKey:@"data"] !=nil) {
            NSArray *dataArr =[responseObj objectForKey:@"data"];
                      
            for (NSDictionary *dic in dataArr)
            {
                MYquestion *model = [[MYquestion alloc] init];
                model.uqcontent1=[dic objectForKey:@"uqcontent"];
               model.uqcreatedate1=[dic objectForKey:@"uqcreatedate"];
               
                model.uqstate1=[dic  objectForKey:@"uqstate"];
               
               [_dataArr addObject:model];
            }
            
            
            
            [_mytableView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error123--%@",error);
    }];
    
    

}
-(void)setTableView
{
    _mytableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _mytableView.delegate =self;
    _mytableView.dataSource =self;
    [self.view addSubview:_mytableView];
    
  [_mytableView registerNib:[UINib nibWithNibName:@"MYquestionTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的提问";
}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MYquestionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        
        cell=[[MYquestionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    
    MYquestion *model=[_dataArr objectAtIndex:indexPath.row];
    
    cell.uqcontent.text= model.uqcontent1;
    cell.uqcreatedate.text= model.uqcreatedate1;
    cell.uqstate.text=model.uqstate1;
   
    
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    AppprogressViewController *nav=[[AppprogressViewController alloc]init];
//    [self.navigationController pushViewController:nav animated:YES];
    
}
@end
