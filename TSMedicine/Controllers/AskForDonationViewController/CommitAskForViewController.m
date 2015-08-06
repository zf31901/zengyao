//
//  CommitAskForViewController.m
//  TSMedicine
//
//  Created by lyy on 15-6-19.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "CommitAskForViewController.h"
#import "RegisterViewController.h"
@interface CommitAskForViewController ()
@property (weak, nonatomic) IBOutlet X_TableView *tableView;

@end

@implementation CommitAskForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIlable];
    
    self.title = @"申请捐助";
    NSArray *titleArr = @[@"姓名",@"身份证",@"区域",@"通讯住址"];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i <titleArr.count; i++) {
        [arr addObject:[@{
                          kCellTag:@"AskForCell",
                          kCellDidSelect:@"AskForCell",
                          @"nameLab":[titleArr objectAtIndex:i],
                          @"detaillab":@"",
                          @"rightImgHidden":i== 2?@NO:@YES,
                          } mutableCopy]];
        [arr addObject:[@{
                          kCellTag:@"ThinLine",
                          kCellDidSelect:@"f1",
                          @"l":@"12",
                          } mutableCopy]];
        
    }
    self.tableView.xDataSource = arr;
}
-(void)UIlable{
    UIButton *btn = [UIButton buttonWithType:0];
    
    btn.frame = CGRectMake(320, 0, 40, 120);
    [btn setTitle:@"提交" forState:0];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(nextpageVC) forControlEvents:UIControlEventTouchUpInside];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0,40);
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);



}
- (void)nextpageVC
{
    RegisterViewController *commitVC = [RegisterViewController new];
    [self.navigationController pushViewController:commitVC animated:YES];
    
}



@end
