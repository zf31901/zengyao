//
//  QuestionViewController.m
//  TSMedicine
//
//  Created by 123 on 15/8/9.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "QuestionViewController.h"

#import "questionpersmodel.h"
#import "questpersonTableViewCell.h"


#define URL @"http://app.aixinland.cn/api/userquestionanswer/List"


@interface QuestionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
UITableView *_mytableView;
}
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self StaNavlABLE];
    
}

-(void)settabView{
    _mytableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _mytableView.delegate =self;
    _mytableView.dataSource =self;
    [self.view addSubview:_mytableView];
    
    [_mytableView registerNib:[UINib nibWithNibName:@"myquerstionTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];



}
-(void)StaNavlABLE{

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    [dic setObject:@"0" forKey:@"uqid"];
    [dic setObject:@"0" forKey:@"userid"];
    [dic setObject:@"1"              forKey:@"pageid"];
    [dic setObject:@"3"      forKey:@"pagesize"];
    YYHttpRequest *hq=[YYHttpRequest shareInstance];
    
    [hq GETURLString:URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
        
        //        NSLog(@"111111111%@",responseObj);
        
        if ([responseObj objectForKey:@"data"] !=nil) {
            NSArray *dataArr =[responseObj objectForKey:@"data"];
            
            //            NSLog(@"222222%lu",(unsigned long)dataArr.count);
            
            for (int i = 0; i < dataArr.count; i++)
            {
                questionpersmodel *model=[[questionpersmodel alloc]init];
                NSDictionary *dataDic = (NSDictionary *)[dataArr objectAtIndex:i];
                
                
                model.uqausername=[dataDic objectForKey:@"uqausername"];
                model.uqcreatedate=[dataDic objectForKey:@"uqcreatedate"];
                model.uqacontent=[dataDic objectForKey:@"uqacontent"];
                model.uqauserimage=[dataDic  objectForKey:@"uqauserimage"];
                
                [_dataArr addObject:model];
                
                
            }
            
            
            [_mytableView reloadData];
            
        }
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}



@end
