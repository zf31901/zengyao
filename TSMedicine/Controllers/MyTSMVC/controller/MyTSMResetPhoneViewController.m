//
//  MyTSMResetPhoneViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-28.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyTSMResetPhoneViewController.h"

@interface MyTSMResetPhoneViewController ()

@property (nonatomic,copy) NSString *sessionkey;
@property (nonatomic,copy) NSString *userlogin;

@property (nonatomic,assign) NSInteger second;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation MyTSMResetPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    [self drawUI];
    
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = _navTitle;
}
-(void)drawUI
{
    
    _verifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _verifyBtn.frame = CGRectMake(200, 6, 100, 32);
    _verifyBtn.backgroundColor = [UIColor clearColor];
    [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _verifyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    _verifyBtn.layer.borderWidth = 1.0;
    _verifyBtn.layer.cornerRadius = 4.0;
    _verifyBtn.layer.borderColor = UIColorFromRGB(0xa075e6).CGColor;
    [_verifyBtn setTitleColor:UIColorFromRGB(0xa075e6) forState:UIControlStateNormal];
    [_verifyBtn setTitleColor:Commom_TextColor_Gray forState:UIControlStateHighlighted];
    
    [_verifyBtn addTarget:self action:@selector(getVerifyCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_verifyBtn];
    
    _finishBtn.layer.cornerRadius = 4.0;
    [_finishBtn setBackgroundColor:Common_Btn_BgColor];
    
    _phoneNumbTF.keyboardType = UIKeyboardTypeNumberPad;
    
}

-(void)getVerifyCodeBtnClick{
    
    if (![self cheakPhoneNumber]) {
        return;
    }
    
    [self runingTimer];
    
    NSDictionary *parameters = @{@"phone":_phoneNumbTF.text};
    [HttpRequest_MyApi GETURLString:@"/User/register/sendverifycode/" userCache:NO parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
        NSDictionary *rqDic = (NSDictionary *)responseObj;
        NSLog(@"rqDic == %@",rqDic);
        
        if ([rqDic[@"state"] boolValue]){
            
            NSDictionary *dic = (NSDictionary *)[rqDic[@"data"] objectFromJSONString];
            NSLog(@"dic ==== %@",dic);
            
            if ([dic[@"result"] boolValue]) {
                NSLog(@"验证码发送成功");
                
                _sessionkey = dic[@"sessionkey"];
                
            }else{
                NSLog(@"验证码发送失败");
            }
            
        }else{
            
            [self showHUDInView:self.view WithText:[NSString stringWithFormat:@"%@",rqDic[HTTP_MSG]] andDelay:LOADING_TIME];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
    }];
    
}

- (IBAction)finishAction:(id)sender {
    
    if (![self cheakPhoneNumber]) {
        return;
    }
    
    if (![self cheakText]) {
        return;
    }
    
    NSDictionary *dic = nil;
    if (_sessionkey) {
        dic = @{@"phone":_phoneNumbTF.text,@"verifycode":_verifyTF.text,@"sessionkey":_sessionkey};
    }else{
        [self showHUDInView:KEY_WINDOW WithText:@"请输入正确的手机号和验证码" andDelay:LOADING_TIME];
        return;
    }
    
    [HttpRequest_MyApi GETURLString:@"/User/register/checkverifycode/" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj){
        NSDictionary *rqDic = (NSDictionary *)responseObj;
        if ([rqDic[@"state"] boolValue]){
            NSDictionary *dic = (NSDictionary *)[rqDic[@"data"] objectFromJSONString];
            if ([dic[@"result"] boolValue]) {
                NSLog(@"进入下一步");
                
                [self resetPhomeNumber];
                
            }else{
                [self showHUDInView:KEY_WINDOW WithText:@"验证码输入有误" andDelay:LOADING_TIME];
            }
            
        }else{
            
            [self showHUDInView:self.view WithText:[NSString stringWithFormat:@"%@",rqDic[HTTP_MSG]] andDelay:LOADING_TIME];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
    }];
    
}

-(void)resetPhomeNumber
{
    
    NSDictionary *parameters = @{@"u":UserInfoData.im,@"UserLogin":UserInfoData.im,@"clientkey":UserInfoData.clientkey,@"Mobile":_phoneNumbTF.text};
    [HttpRequest_MyApi POSTURLString:@"/User/update/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"responseObject == %@",responseObject);
        
        if ([responseObject[@"state"] boolValue]) {
            
            NSDictionary *dataDic = (NSDictionary *)[responseObject[@"data"] objectFromJSONString];
//            NSLog(@"dataDic == %@",dataDic)
            
            if ([dataDic[@"result"] boolValue]) {
                
                NSLog(@"修改成功");
                [self showAlertViewWithTitle:@"修改手机号成功" andDelay:1.5];
                
                //更新用户数据
                [[GlobalMethod sharedInstance] reloadUserInfoDataSuccess:^(NSString *status) {
                    if ([status isEqualToString:@"success"]) {
                        NSLog(@"用户数据更新成功");
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                } failure:^{
                }];
            }
            
        }else{
            [self showHUDInView:self.view WithText:[NSString stringWithFormat:@"%@:%@",responseObject[HTTP_ERRCODE],responseObject[HTTP_MSG]] andDelay:LOADING_TIME];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error == %@",error);
    }];

}

-(void)runingTimer
{
    _second = 60;
    //    [self time];
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(time) userInfo:nil repeats:YES];
    [_timer fire];
}

-(void)time
{
    _second--;
    [_verifyBtn setEnabled:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (_second == 0) {
            
            [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateHighlighted];
            [_verifyBtn setTitleColor:UIColorFromRGB(0xa075e6) forState:UIControlStateNormal];
            _verifyBtn.layer.borderColor = UIColorFromRGB(0xa075e6).CGColor;
            [_verifyBtn setEnabled:YES];
            
        }else{
            [_verifyBtn setTitle:[NSString stringWithFormat:@"重发(%ld)",(long)_second] forState:UIControlStateNormal];
            [_verifyBtn setTitle:[NSString stringWithFormat:@"重发(%ld)",(long)_second] forState:UIControlStateHighlighted];
            _verifyBtn.layer.borderColor = Commom_TextColor_Gray.CGColor;
        }
        
    });
    
    [_verifyBtn setTitleColor:RGBS(101) forState:UIControlStateNormal];
    
    if(_second == 0)
    {
        NSLog(@"可以重新获取验证码");
        [_timer invalidate];
        _timer = nil;
        
    } else {
        
        [_verifyBtn setEnabled:NO];
    }
    
}

-(BOOL)cheakPhoneNumber
{
    if ([WITool isValidateMobile:_phoneNumbTF.text]){
        return YES;
    }else{
        [self showAlertViewWithTitle:@"手机输入有误，请重新输入！" andDelay:1.5];
        return NO;
    }
}

-(BOOL)cheakText
{
    if (_verifyTF.text.length != 4) {
        [self showHUDInView:KEY_WINDOW WithText:@"验证码输入有误" andDelay:LOADING_TIME];
        return NO;
    }
    return YES;
}

-(void)showAlertViewWithTitle:(NSString *)message andDelay:(CGFloat)time
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hidKeyBoard];
}
-(void)hidKeyBoard
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
