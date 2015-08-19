//
//  MyTSMFeedBackViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-6.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyTSMFeedBackViewController.h"

@interface MyTSMFeedBackViewController () <UITextViewDelegate>

@property (nonatomic,strong) UILabel *placeholderLab;

@end

@implementation MyTSMFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    
    [self createUI];
   
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"意见反馈";
    
    [self buidRightBtn:@"提交"];
}

-(void)createUI
{
     _feedBackTextView.delegate = self;
    
    _placeholderLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 10*2, 40)];
    _placeholderLab.text = @"Hi,如果您在使用过程中遇到什么系统问题，或者有什么功能建议的话，欢迎提给我们。谢谢！";
    _placeholderLab.numberOfLines = 0;
    _placeholderLab.textColor = Commom_TextColor_Gray;
    _placeholderLab.enabled = NO;
    _placeholderLab.backgroundColor = [UIColor clearColor];
    _placeholderLab.font = [UIFont systemFontOfSize:14];
    _placeholderLab.textColor = [UIColor lightGrayColor];
    [_feedBackTextView addSubview:_placeholderLab];
    
}
-(void)commit
{
    NSLog(@"意见反馈提交");
    
    if (![self cheakText]) {
        return;
    }
    
    
    YYHttpRequest *http = [[YYHttpRequest alloc] init];
    
    NSString *currentTime = [WITool getCurrentTime];
    NSDictionary *dic = @{@"fdid":@(0),@"fdtitle":@"string",@"fdcontent":_feedBackTextView.text,@"fduserid":UserInfoData.Id,@"fdusername":UserInfoData.nickName,@"fdcreatedate":currentTime,@"fdstate":@(0),@"fduserphone":UserInfoData.phone,@"fduseremail":UserInfoData.email};
    [http POSTURLString:@"http://app.aixinland.cn/api/feedback/Add" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"responseObject == %@",responseObject)
        
//        NSLog(@"responseObject == %@",responseObject[@"status"]);
        if ([responseObject[@"status"] isEqualToString:@"Success"]) {
            
            [self.navigationController popViewControllerAnimated:YES];
//            [self showAlertViewWithTitle:@"提交成功，感谢您的建议!" andDelay:1.0];
            [self showHUDInView:KEY_WINDOW WithText:@"提交成功" andDelay:LOADING_TIME];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
    }];
}

#pragma mark ---------UITextViewDelegate---------------
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _placeholderLab.hidden = YES;
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] == 0) {
        _placeholderLab.hidden = NO;
    }else{
        _placeholderLab.hidden = YES;
    }
}

-(BOOL)cheakText
{
    if (_feedBackTextView.text.length == 0) {
        [self showAlertViewWithTitle:@"意见不能为空" andDelay:1.0];
        return NO;
    }
    return YES;
}

-(void)showAlertViewWithTitle:(NSString *)title andDelay:(CGFloat)time
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [WITool hideAllKeyBoard];
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
