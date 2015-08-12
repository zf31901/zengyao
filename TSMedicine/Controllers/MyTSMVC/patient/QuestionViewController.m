//
//  QuestionViewController.m
//  TSMedicine
//
//  Created by 123 on 15/8/9.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestPersoNTableViewCell.h"
#import "QuestionTurnViewController.h"



#import "MyPatQuestModel.h"
#import "MyAnswerModel.h"

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
    [self setNavlable];
    _dataArr=[[NSMutableArray alloc]init];
    
    
    [self StaNav];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"项目";
}

-(void)settabView{
    _mytableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _mytableView.delegate =self;
    _mytableView.dataSource =self;
    _mytableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:_mytableView];
    
    [_mytableView registerNib:[UINib nibWithNibName:@"QuestPersoNTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}
-(void)StaNav{
    
    
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    NSDictionary *dic = @{@"uqid":@"0",@"userid":@"0",@"pageid":@"1",@"pagesize":@"10"};
    [rq GETURLString:URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
        NSLog(@"responseObj123456 === %@",responseObj);
        
        // NSMutableArray *arr2 = [NSMutableArray array];
        for (NSDictionary *dic in responseObj[@"data"]) {
            MyAnswerModel *model = [[MyAnswerModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
            [_dataArr addObject:model];
            
        }
        NSLog(@"13123------%@",_dataArr);
        [self settabView];
        [_mytableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error===%@",error);
    }];
    
}
#pragma mark --------UITableViewDataSource--------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

   QuestPersoNTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[QuestPersoNTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    MyAnswerModel *model1=_dataArr[indexPath.row];
    
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:model1.uqauserimage] placeholderImage:[UIImage imageNamed:default_head] options:SDWebImageRefreshCached];
    
    cell.nameLable.text = model1.uqausername;
    
    NSString *dateStr = [model1.uqcreatedate substringWithRange:NSMakeRange(0, 10)];
    NSString *timeStr = [model1.uqcreatedate substringWithRange:NSMakeRange(11, 5)];
    cell.dateLab.text = [NSString stringWithFormat:@"%@ %@",dateStr,timeStr];
    
    cell.answerLab.text = [NSString stringWithFormat:@"问: %@",model1.uqacontent];
    cell.answerLab.numberOfLines = 0;
    cell.answerLab.height = model1.contentSize.height;
   // NSLog(@"123123678----%@",model1.uqauserimage);
    
    
    return cell;
    
}
#pragma mark --------UITableViewDelegate--------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(void)setNavlable{
    
    
    [self buidRightBtn:@"提问"];
    
//    UIButton *btn = [UIButton buttonWithType:0];
//    
//    btn.frame = CGRectMake(325, 0, 60, 120);
//    [btn setTitle:@"提问" forState:0];
//    [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
//    [btn setTitleColor:[UIColor whiteColor] forState:0];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    [btn addTarget:self action:@selector(nextpageVC) forControlEvents:UIControlEventTouchUpInside];
//    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0,40);
//    
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -23, 0, 0);
}

-(void)commit
{
    QuestionTurnViewController *commitVC = [QuestionTurnViewController new];
    [self.navigationController pushViewController:commitVC animated:YES];
}
- (void)nextpageVC
{
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
        return 100;
    
}

@end
