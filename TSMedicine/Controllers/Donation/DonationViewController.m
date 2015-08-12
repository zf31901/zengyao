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

#define URL @"http://app.aixinland.cn/api/projects/List"




@interface DonationViewController ()
{
    NSMutableArray *_dataArry;
    
}
@property (weak, nonatomic) IBOutlet X_TableView *tableView;

@end

@implementation DonationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.title = @"捐助项目";
    _dataArry=[[NSMutableArray alloc]init];
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
   // NSMutableArray *testArr = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    [dic setObject:@"1"              forKey:@"pageid"];
    [dic setObject:@"3"      forKey:@"pagesize"];
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

                
                [arr addObject:[@{
                                  kCellTag:@"DonationCell",
                                  kCellDidSelect:@"DonationCell",
                                  @"donation_titleLab":[dataDic objectForKey:@"pname"],
                                  @"donation_contentlab":[dataDic objectForKey:@"pjieshao"],
                                  @"donation_unitlab":[dataDic objectForKey:@"pfaqidanwei"],
                                  @"donation_imgView":[dataDic  objectForKey:@"pimage"],
                                  } mutableCopy]];
           
                
            }
            self.tableView.xDataSource = arr;
            
            [self.tableView reloadData];
            
        }
        [self lable];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
