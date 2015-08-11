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
@property (nonatomic,assign) BOOL isFirst;

@end

@implementation DocProjectAnswerViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _isFirst = YES;
    
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
//    NSLog(@"frame == %@",NSStringFromCGRect(_textField.frame));
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTap)];
    [self.view addGestureRecognizer:tap];
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
//         NSLog(@"%f",model.contentSize.height);
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
        
        if (_isFirst) {
            [self createUI];
            _isFirst = NO;
        }
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error===%@",error);
    }];
}

//回答问题
- (void)commit
{
    NSLog(@"回答提问");
    
    if (![self cheakText]) {
        return;
    }
    
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    
    NSString *currentTime = [WITool getCurrentTime];
    NSDictionary *dic = @{@"uqaid":@(0),@"uqauqid":@(0),@"uqauserid":UserInfoData.Id,@"uqausername":UserInfoData.nickName,@"uqacontent":_textField.text,@"uqcreatedate":currentTime};
    
    [rq POSTURLString:@"http://app.aixinland.cn/api/userquestionanswer/Add" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"responseObject ==== %@",responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"Success"]) {
            
            [self loadData];
            _textField.text = @"";
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"error == %@",error);
    }];
    
}

-(BOOL)cheakText
{
    if (_textField.text.length == 0) {
        [self showAlertViewWithTitle:@"回答不能为空!" andDelay:1.0];
        return NO;
    }
    return YES;
}

-(void)showAlertViewWithTitle:(NSString *)title andDelay:(CGFloat)time
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


-(void)myTap
{
    [WITool hideAllKeyBoard];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
