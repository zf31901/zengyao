//
//  DocProjectAnswerViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-9.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DocProjectAnswerViewController.h"
#import "DocAnswerTableViewCell.h"

#import "MyPatQuestModel.h"
#import "MyAnswerModel.h"

NSString *const AnswerTableViewCell = @"DocAnswerTableViewCell";

@interface DocProjectAnswerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UITextField *textField;

@end

@implementation DocProjectAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self loadData];
    [self setNavView];

}
-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"问题详情";
    [self buidRightBtn:@"回答"];
}

-(void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 60) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
     [_tableView registerNib:[UINib nibWithNibName:AnswerTableViewCell bundle:nil] forCellReuseIdentifier:AnswerTableViewCell];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, _tableView.maxY + 15, ScreenWidth - 20*2, 30)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.backgroundColor = [UIColor clearColor];
    _textField.placeholder = @"输入回答";
    [self.view addSubview:_textField];
}

#pragma mark --------UITableViewDataSource--------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArr[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DocAnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AnswerTableViewCell];
    if (!cell) {
        cell = [[DocAnswerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AnswerTableViewCell];
    }
    
    [cell loadDataWithDataArray:_dataArr andWithIndexPath:indexPath];
    
    return cell;
}

#pragma mark --------UITableViewDelegate--------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        MyPatQuestModel *model = _dataArr[indexPath.section][indexPath.row];
        
        return 80.0 + model.contentSize.height;
        
    }else{
        MyAnswerModel *model = _dataArr[indexPath.section][indexPath.row];
        
        return 80.0 + model.contentSize.height;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1f;
    }else{
        return 3.0f;
    }
    
}

-(void)loadData
{
    _dataArr = [NSMutableArray array];
    NSMutableArray *arr1 = [NSMutableArray array];
    [arr1 addObject:self.model];
    [_dataArr addObject:arr1];
    
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    NSDictionary *dic = @{@"uqid":@(0),@"userid":@(0),@"pageid":@"1",@"pagesize":@"10"};
    [rq GETURLString:@"http://app.aixinland.cn/api/userquestionanswer/List" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj) {
//        NSLog(@"responseObj === %@",responseObj);
        
        NSMutableArray *arr2 = [NSMutableArray array];
        for (NSDictionary *dic in responseObj[@"data"]) {
            MyAnswerModel *model = [[MyAnswerModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [arr2 addObject:model];
        }
        [_dataArr addObject:arr2];
        [self createUI];
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error===%@",error);
    }];
}

//回答问题
- (void)commit
{
    NSLog(@"回答");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
