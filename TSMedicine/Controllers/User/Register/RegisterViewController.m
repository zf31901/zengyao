//
//  RegisterViewController.m
//  TSMedicine
//
//  Created by lyy on 15-7-30.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterNextViewController.h"

@interface RegisterViewController ()

@property (nonatomic,copy) NSString *sessionkey;
@property (nonatomic,copy) NSString *userlogin;

@property (nonatomic,assign) NSInteger second;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation RegisterViewController

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
    
    _nextBtn.layer.cornerRadius = 4.0;
    [_nextBtn setBackgroundColor:Common_Btn_BgColor];
    
    _phoneNumbTF.keyboardType = UIKeyboardTypeNumberPad;
    
}

//获取验证码
-(void)getVerifyCodeBtnClick {
    
    if (![self cheakPhoneNumber]) {
        return;
    }
    
    [self runingTimer];
    
    if (_isFindPass)
    {
        //找回密码
        NSDictionary *parameters = @{@"u":_phoneNumbTF.text};
        [HttpRequest_MyApi GETURLString:@"/User/findpassword/sendverifycode/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObj) {
            NSDictionary *rqDic = (NSDictionary *)responseObj;
            //            NSLog(@"rqDic == %@",rqDic);
            if([rqDic[HTTP_STATE] boolValue]){
                
                NSDictionary *dic = (NSDictionary *)[rqDic[HTTP_DATA] objectFromJSONString];
                NSLog(@"dic === %@",dic);
                
                if ([dic[@"result"] boolValue]) {
                    NSLog(@"验证码发送成功");
                    
                    _sessionkey = dic[@"sessionkey"];
                    _userlogin = dic[@"userlogin"];
                    
                }else{
                    NSLog(@"验证码发送失败");
                }
                
                
            }else{
                
                [self showHUDInView:self.view WithText:[NSString stringWithFormat:@"%@",rqDic[HTTP_MSG]] andDelay:LOADING_TIME];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error == %@",error);
        }];
        
    }else{
        //注册新账号
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

    
}

-(void)runingTimer
{
    _second = 60;
    [self time];
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(time) userInfo:nil repeats:YES];
    _verifyBtn.enabled = NO;
    
}

-(void)time
{
    
    _second--;
    if (_second <= 0) {
        
        _verifyBtn.layer.borderColor = UIColorFromRGB(0xa075e6).CGColor;
        [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verifyBtn setTitleColor:UIColorFromRGB(0xa075e6) forState:UIControlStateNormal];
        _verifyBtn.enabled = YES;
        
        [_timer invalidate];
        _timer = nil;
        
    }else{
        
        [_verifyBtn setTitle:[NSString stringWithFormat:@"重发(%ld)",(long)_second] forState:UIControlStateNormal];
        [_verifyBtn setTitleColor:Commom_TextColor_Gray forState:UIControlStateNormal];
        _verifyBtn.layer.borderColor = Commom_TextColor_Gray.CGColor;
        _verifyBtn.enabled = NO;
    }
    
}

//下一步 核对验证码
- (IBAction)nextBtnClick:(id)sender {
    
    if (![self cheakPhoneNumber]) {
        return;
    }
    
    if (![self cheakText]) {
        return;
    }
    
    if (_isFindPass)
    {
        //找回密码
        
        NSDictionary *parameters = nil;
        if (_sessionkey) {
            parameters = @{@"u": _phoneNumbTF.text, @"verifycode": _verifyTF.text, @"sessionkey": _sessionkey};
        }else{
            [self showHUDInView:KEY_WINDOW WithText:@"请输入正确的手机号和验证码" andDelay:LOADING_TIME];
            return;
        }
        
        [HttpRequest_MyApi GETURLString:@"/User/findpassword/checkverifycode/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObj) {
            NSDictionary *rqDic = (NSDictionary *)responseObj;
            NSLog(@"rqDic == %@",rqDic);
            
            if([rqDic[HTTP_STATE] boolValue]){
                NSDictionary *dataDic = (NSDictionary *)[rqDic[HTTP_DATA] objectFromJSONString];
                NSLog(@"dataDic == %@",dataDic);
                if([dataDic[@"result"] boolValue]){
                    
                    RegisterNextViewController *nextRgster = [[RegisterNextViewController alloc] init];
                    nextRgster.navTitle = @"设置新密码";
                    nextRgster.phoneNum = _phoneNumbTF.text;
                    nextRgster.isChangePassWord = YES;
                    [self.navigationController pushViewController:nextRgster animated:YES];
                    
                }else{
                    
                    [self showHUDInView:KEY_WINDOW WithText:@"验证码输入有误" andDelay:LOADING_TIME];
                }
            }else{
                
                [self showHUDInView:self.view WithText:[NSString stringWithFormat:@"%@",rqDic[HTTP_MSG]] andDelay:LOADING_TIME];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error == %@",error);
        }];
        
        
    }else{
        
        //注册新账号
        
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
                //                NSLog(@"dic ==== %@",dic);
                
                if ([dic[@"result"] boolValue]) {
                    NSLog(@"进入下一步");
                    
                    RegisterNextViewController *nextRgster = [[RegisterNextViewController alloc] init];
                    nextRgster.navTitle = @"设置密码";
                    nextRgster.phoneNum = _phoneNumbTF.text;
                    [self.navigationController pushViewController:nextRgster animated:YES];
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
