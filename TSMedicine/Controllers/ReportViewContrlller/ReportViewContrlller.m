//
//  ReportViewContrlller.m
//  TSMedicine
//
//  Created by lyy on 15-6-26.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "ReportViewContrlller.h"

@interface ReportViewContrlller ()<UITextViewDelegate>

@property (nonatomic,strong) UILabel *placeholderLab;

@end

@implementation ReportViewContrlller

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setNavView];
    
    [self createUI];
}

-(void)setNavView
{
    self.title = @"举报患者";
    [self buidRightBtn:@"提交"];
}

-(void)createUI
{
    _textView.delegate = self;
    
    _placeholderLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.view.bounds.size.width - 10*2, 20)];
    _placeholderLab.text = @"举报说明";
    _placeholderLab.numberOfLines = 0;
    _placeholderLab.textColor = RGB(199, 199, 199);
    _placeholderLab.enabled = NO;
    _placeholderLab.backgroundColor = [UIColor clearColor];
    _placeholderLab.font = [UIFont systemFontOfSize:14];
    _placeholderLab.textColor = [UIColor lightGrayColor];
    [_textView addSubview:_placeholderLab];

}

//举报提交
-(void)commit
{
    if (![self cheakText]) {
        return;
    }
    
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    
     NSString *currentTime = [WITool getCurrentTime];
    NSDictionary *dic = @{@"urid":_model.id,@"urtouserid":_model.userlogin,@"urtousername":_model.nick,@"urfromuserid":UserInfoData.im,@"urfromusername":UserInfoData.nickName,@"urphone":UserInfoData.phone,@"urcontent":_textView.text,@"urstate":_model.mobilestate,@"urcreatedate":currentTime};
    
    [rq POSTURLString:@"http://app.aixinland.cn/api/userreport/Add" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSLog(@"responseObject === %@",responseObject);
        
         if ([responseObject[@"status"] isEqualToString:@"Success"]) {
             NSLog(@"message == %@",responseObject[@"message"]);
             
             [self showHUDInView:KEY_WINDOW WithText:@"举报成功" andDelay:LOADING_TIME];
             [self.navigationController popViewControllerAnimated:YES];
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
    if (_textView.text.length == 0) {
        [self showAlertViewWithTitle:@"举报内容不能为空" andDelay:1.0];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
