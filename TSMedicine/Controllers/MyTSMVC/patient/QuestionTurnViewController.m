//
//  QuestionTurnViewController.m
//  TSMedicine
//
//  Created by 123 on 15/8/10.
//  Copyright (c) 2015年 ewt. All rights reserved.
//


#import "QuestionTurnViewController.h"
#import "MyAnswerModel.h"
#import "QuestionViewController.h"

#define ONANSWER @"http://app.aixinland.cn:80/api/userquestionanswer/Add"
#define IS_IPHONE_5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface QuestionTurnViewController ()<UITextViewDelegate>
{
    
    NSMutableArray *_dataArr;
    
}
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation QuestionTurnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buidRightBtn:@"发表"];
    
    [self Nav];
    _dataArr=[[NSMutableArray alloc]init];
    
    _textView.returnKeyType=UIReturnKeyDone;//设置键盘中return 为 Done 完成
    _textView.scrollEnabled=NO;
    _textView.font=[UIFont fontWithName:@"Arial" size:16.0];
    _textView.text = @"详解";
    _textView.delegate=self;
    _textView.editable=YES;
    _textView.keyboardType=UIKeyboardTypeDefault;
    
    [self.view addSubview:_textView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTap)];
    [self.view addGestureRecognizer:tap];
    
}
-(void)myTap{
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [WITool hideAllKeyBoard];
}

-(void)Nav
{
    self.navigationController.navigationBarHidden = NO;
    
}
-(void)commit{
    
    NSLog(@"发表");
    
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    
    NSString *currentTime = [WITool getCurrentTime];
    NSDictionary *dic = @{@"uqaid":@(0),@"uqauqid":@(0),@"uqauserid":UserInfoData.Id,@"uqausername":UserInfoData.nickName,@"uqacontent":_textView.text,@"uqcreatedate":currentTime};
    
    [rq POSTURLString:@"http://app.aixinland.cn/api/userquestionanswer/Add" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject ==== %@",responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"Success"]) {
            _textView.text = @"";
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
    }];
    
    
}





-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self.scrollView setContentOffset:CGPointMake(0, IS_IPHONE_5?50:100) animated:YES];
    return YES;
}

-(void)showAlertViewWithTitle:(NSString *)title andDelay:(CGFloat)time
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
@end
