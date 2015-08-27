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

@interface DocProjectAnswerViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIView *textBgView;
@property (nonatomic,assign) BOOL isFirst;
@property (nonatomic,assign) CGRect saveFrame;

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
    
    //监听键盘
    [self setKeyboard];
    
}
-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"问题详情";
    [self buidRightBtn:@"回答"];
}

-(void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 50) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
     [_tableView registerNib:[UINib nibWithNibName:AnswerTableViewCell bundle:nil] forCellReuseIdentifier:AnswerTableViewCell];
    
    _textBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _tableView.maxY, ScreenWidth, 50)];
    _textBgView.backgroundColor = UIColorFromRGB(0xf8f8f8);;
    [self.view addSubview:_textBgView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, _textBgView.width - 20*2, 30)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.backgroundColor = [UIColor clearColor];
    _textField.placeholder = @"输入回答";
    _textField.delegate = self;
    [_textBgView addSubview:_textField];
    
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
    [_dataArr removeAllObjects];
    _dataArr = [NSMutableArray array];
    NSMutableArray *arr1 = [NSMutableArray array];
    [arr1 addObject:self.model];
    [_dataArr addObject:arr1];
    
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    NSDictionary *dic = @{@"uqid":_model.uqid,@"userid":@"0",@"pageid":@"1",@"pagesize":@"10"};
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
//    NSLog(@"uqid = %@",_model.uqid);
    NSDictionary *dic = @{@"uqaid":@"0",@"uqauqid":_model.uqid,@"uqauserid":UserInfoData.im,@"uqausername":UserInfoData.nickName,@"uqacontent":_textField.text,@"uqcreatedate":currentTime};
    
    [rq POSTURLString:@"http://app.aixinland.cn/api/userquestionanswer/Add" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"responseObject ==== %@",responseObject);
//        NSLog(@"message ==== %@",responseObject[@"message"]);
        
        if ([responseObject[@"status"] isEqualToString:@"Success"]) {
            
            [self loadData];
            _textField.text = @"";
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"error == %@",error);
    }];
    
    [WITool hideAllKeyBoard];
    
}

#pragma mark -------------监听键盘------------
-(void)setKeyboard
{
    //添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)not{
    
    //获取键盘的y坐标
//    NSLog(@"%@",not.userInfo);
    
    CGRect keyboardFrame = [not.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
     CGFloat distance = CGRectGetMaxY(_textBgView.frame) - keyboardFrame.origin.y;
    
    if (distance > 0) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            _textBgView.frame = CGRectMake(0, keyboardFrame.origin.y - 50 - 64, ScreenWidth, 50);
        }];
    }
}

-(void)keyboardWillHide:(NSNotification *)not{
    
    _textBgView.frame = _saveFrame;
}

#pragma mark ---------UITextFieldDelegate----------
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _saveFrame = _textBgView.frame;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.25 animations:^{
        _textBgView.frame = _saveFrame;
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
