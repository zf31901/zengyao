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
    _verifyBtn.layer.borderWidth = 1.0;
    _verifyBtn.layer.cornerRadius = 4.0;
    _verifyBtn.layer.borderColor = UIColorFromRGB(0xa075e6).CGColor;
    [_verifyBtn setTitleColor:UIColorFromRGB(0xa075e6) forState:UIControlStateNormal];
    
    _nextBtn.layer.cornerRadius = 4.0;
    [_nextBtn setBackgroundColor:Common_Btn_BgColor];
    
    _phoneNumbTF.keyboardType = UIKeyboardTypeNumberPad;
    
}

//获取验证码
- (IBAction)getVerifyCodeBtnClick:(id)sender {
    
    if (![self cheakPhoneNumber]) {
        return;
    }
    
    if (_isFindPass)
    {
        //找回密码
        NSDictionary *parameters = @{@"u":_phoneNumbTF.text};
        [HttpRequest_MyApi GETURLString:@"/User/findpassword/sendverifycode/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObj) {
             NSDictionary *rqDic = (NSDictionary *)responseObj;
            if([rqDic[HTTP_STATE] boolValue]){
                NSDictionary *dic = (NSDictionary *)[rqDic[HTTP_DATA] objectFromJSONString];
//                NSLog(@"dic === %@",dic);
                
                _sessionkey = dic[@"sessionkey"];
                _userlogin = dic[@"userlogin"];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error == %@",error);
        }];
        
    }else{
        //注册新账号
        NSDictionary *parameters = @{@"phone":_phoneNumbTF.text};
        [HttpRequest_MyApi GETURLString:@"/User/register/sendverifycode/" userCache:NO parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObj) {
            
            NSDictionary *rqDic = (NSDictionary *)responseObj;
            if ([rqDic[@"state"] boolValue]) {
                NSDictionary *dic = (NSDictionary *)[rqDic[@"data"] objectFromJSONString];
                //            NSLog(@"dic ==== %@",dic);
                
                _sessionkey = dic[@"sessionkey"];
                
                if ([dic[@"result"] boolValue]) {
                    
                    NSLog(@"验证码发送成功");
                    
                }else{
                    NSLog(@"验证码发送失败");
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error == %@",error);
        }];
        
    }
    
    _second = 60;
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
        
        [_verifyBtn setTitle:[NSString stringWithFormat:@"重发(%ld)",_second] forState:UIControlStateNormal];
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
         NSDictionary *parameters = @{@"u": _phoneNumbTF.text, @"verifycode": _verifyTF.text, @"sessionkey": _sessionkey};
        [HttpRequest_MyApi GETURLString:@"/User/findpassword/checkverifycode/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObj) {
            NSDictionary *rqDic = (NSDictionary *)responseObj;
            if([rqDic[HTTP_STATE] boolValue]){
                NSDictionary *dataDic = (NSDictionary *)[rqDic[HTTP_DATA] objectFromJSONString];
                NSLog(@"dataDic == %@",dataDic);
                if([dataDic[@"result"] boolValue]){
                    
                    RegisterNextViewController *nextRgster = [[RegisterNextViewController alloc] init];
                    nextRgster.navTitle = @"设置新密码";
                    nextRgster.phoneNum = _phoneNumbTF.text;
                    nextRgster.isChangePassWord = YES;
                    [self.navigationController pushViewController:nextRgster animated:YES];
                
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error == %@",error);
        }];
        
        
    }else{
        //注册新账号
        NSDictionary *dic = @{@"phone":_phoneNumbTF.text,@"verifycode":_verifyTF.text,@"sessionkey":_sessionkey};
        [HttpRequest_MyApi GETURLString:@"/User/register/checkverifycode/" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObj){
            NSDictionary *rqDic = (NSDictionary *)responseObj;
            if ([rqDic[@"state"] boolValue]) {
                NSDictionary *dic = (NSDictionary *)[rqDic[@"data"] objectFromJSONString];
//                NSLog(@"dic ==== %@",dic);
                
                if ([dic[@"result"] boolValue]) {
                    NSLog(@"进入下一步");
                    
                    RegisterNextViewController *nextRgster = [[RegisterNextViewController alloc] init];
                    nextRgster.navTitle = @"设置密码";
                    nextRgster.phoneNum = _phoneNumbTF.text;
                    [self.navigationController pushViewController:nextRgster animated:YES];
                }
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
        [self showAlertViewWithTitle:@"验证码输入有误，请重新输入！" andDelay:1.5];
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
