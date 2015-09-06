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

@property (nonatomic,strong) UILabel *TextViewLab;


@end

@implementation QuestionTurnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buidRightBtn:@"发表"];
    
    [self Nav];
    _dataArr=[[NSMutableArray alloc]init];
    _textView.delegate=self;

    
    _TextViewLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 10*2, 40)];
    
    _TextViewLab.numberOfLines=0;
    _TextViewLab.textColor=Commom_TextColor_Gray;
    _TextViewLab.enabled=NO;
    _TextViewLab.text=@"Hi,请简要描叙您的问题或者建议！";
    _TextViewLab.backgroundColor=[UIColor clearColor];
    _TextViewLab.font=[UIFont systemFontOfSize:14];
    _TextViewLab.textColor=[UIColor lightGrayColor];
    [_textView addSubview:_TextViewLab];
    
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
    if (![self cheakText]) {
        return;
    }
    
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    //UserInfoData.im
    NSString *currentTime = [WITool getCurrentTime];
    NSDictionary *dic;
    if (_model) {
      dic = @{@"uqid":@(0),@"uqpid":_model.uppid,@"uqpname":UserInfoData.trueName,@"uqname":UserInfoData.nickName,@"uqcontent":_textView.text,@"uquserid":_model.upuserid,@"uqcreatedate":currentTime,@"uqusername":UserInfoData.userName,@"uqstate":@(0)};
    }
    if (_appModel) {
        
        dic = @{@"uqid":@(0),@"uqpid":_appModel.uppid,@"uqpname":UserInfoData.trueName,@"uqname":UserInfoData.nickName,@"uqcontent":_textView.text,@"uquserid":_appModel.upuserid,@"uqcreatedate":currentTime,@"uqusername":UserInfoData.userName,@"uqstate":@(0)};
    }
    
    [rq POSTURLString:@"http://app.aixinland.cn/api/userquestion/Add" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject ==== %@",responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"Success"]) {
           _textView.text = @"";
            
            NSLog(@"responseObject-123123%@",responseObject[@"message"]);
            [self.navigationController popViewControllerAnimated:YES];
           [self showHUDInView:KEY_WINDOW WithText:@"发表成功" andDelay:LOADING_TIME];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
    }];
    
    
}
#pragma mark ---------UITextViewDelegate---------------
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _TextViewLab.hidden = YES;
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] == 0) {
        _TextViewLab.hidden = NO;
        
        
        
    }else if([_textView.text length]>120){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于120个" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        _textView.text = [textView.text substringToIndex:120];

    }
    else{
    _TextViewLab.hidden = YES;
    
    }
}

-(BOOL)cheakText
{
    if (_textView.text.length == 0) {
        [self showAlertViewWithTitle:@"发表提问不能为空" andDelay:1.0];
        return NO;
    }
    if (_textView.text.length < 8) {
        [self showAlertViewWithTitle:@"发表内容不能小于8个字符！" andDelay:1.0];
        return NO;
    }
   
    return YES;
}
-(void)showAlertViewWithTitle:(NSString *)title andDelay:(CGFloat)time
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}



@end
