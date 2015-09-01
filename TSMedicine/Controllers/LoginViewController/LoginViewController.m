//
//  LoginViewController.m
//  TSMedicine
//
//  Created by lyy on 15-7-6.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UserObj.h"
#import "YYHttpRequest.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self setNavView];
    
}

-(void)setUI
{
    
    [_loginBtn makeCorner:5];
    [_loginBtn setBackgroundColor:Common_Btn_BgColor];
    [_loginBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [_registerBtn makeCorner:5];
    [_registerBtn setBackgroundColor:UIColorFromRGB(0xd8d8d8)];
    [_registerBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    
//    _nikeName.text = @"903050";
//    _pawssWorld.text = @"111222";
    _pawssWorld.secureTextEntry = YES;
    
    _nikeName.clearButtonMode = UITextFieldViewModeAlways;
    _pawssWorld.clearButtonMode = UITextFieldViewModeAlways;
    
    
    
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"登录";
}


#pragma mark -------登录-------------
- (IBAction)loginBtn:(id)sender {
    
//    [self saveUserIdentifyByObj:@"1"];
    
    [self loginRquest];
    
}

////用户
//- (IBAction)userBtnClick:(id)sender {
//    
//    [self saveUserIdentifyByObj:@"1"];
//    [self loginRquest];
//}

////医生
//- (IBAction)docBtnClick:(id)sender {
//    
//    [self saveUserIdentifyByObj:@"2"];
//     [self loginRquest];
//}

////协管员
//- (IBAction)managerBtnClick:(id)sender {
//    
//    [self saveUserIdentifyByObj:@"3"];
//     [self loginRquest];
//}

////药房
//- (IBAction)medBtnClick:(id)sender {
//    
//    [self saveUserIdentifyByObj:@"4"];
//     [self loginRquest];
//}

//-(void)saveUserIdentifyByObj:(id)obj
//{
//    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:@"userId"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}


-(void)loginRquest
{
    
    if (![self cheakText]) {
        return;
    }
    
    [self showHUDInView:self.view WithText:@"正在登录"];
    
    NSDictionary *parameters = @{@"u": _nikeName.text, @"pwd": _pawssWorld.text};
    YYHttpRequest *hq = [YYHttpRequest shareInstance_myapi];
    [hq POSTURLString:@"/User/login/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *rqDic = (NSDictionary *)responseObject;
//        NSLog(@"errcode == %@",rqDic[@"errcode"]);
        if ([rqDic[@"state"] boolValue]) {
            NSLog(@"rqdic == %@",rqDic);
            NSDictionary *dic_login = (NSDictionary *)[rqDic[@"data"] objectFromJSONString];
            NSLog(@"dic_login = %@",dic_login);
            
            NSDictionary *param = @{@"u": _nikeName.text, @"clientkey": dic_login[@"clientkey"]};
            //获取用户信息
            [self loadUserInfoDataWithApiDic:param andLoginInfo:dic_login];
            
        }else{
            NSLog(@"errorMsg: %@",rqDic[HTTP_MSG]);
            
            [self hideHUDInView:self.view];
            
            if ([rqDic[HTTP_ERRCODE] intValue] == 100) {
                [self showHUDInView:self.view WithText:@"帐号不存在" andDelay:LOADING_TIME];
            } else if ([rqDic[HTTP_ERRCODE] intValue] == 101) {
                [self showHUDInView:self.view WithText:@"验证码错误" andDelay:LOADING_TIME];
            } else if ([rqDic[HTTP_ERRCODE] intValue] == 102) {
                [self showHUDInView:self.view WithText:@"密码和账号不匹配" andDelay:LOADING_TIME];
            } else if ([rqDic[HTTP_ERRCODE] intValue] == 103) {
                [self showHUDInView:self.view WithText:@"账号未激活" andDelay:LOADING_TIME];
            } else if ([rqDic[HTTP_ERRCODE] intValue] == 104) {
                [self showHUDInView:self.view WithText:@"邮箱未验证，无法通过邮箱登录" andDelay:LOADING_TIME];
            } else if ([rqDic[HTTP_ERRCODE] intValue] == 105) {
                [self showHUDInView:self.view WithText:@"手机未验证，无法通过手机登录" andDelay:LOADING_TIME];
            } else if ([rqDic[HTTP_ERRCODE] intValue] == 106) {
                [self showHUDInView:self.view WithText:@"账户被冻结" andDelay:LOADING_TIME];
            } else if ([rqDic[HTTP_ERRCODE] intValue] == 107) {
                [self showHUDInView:self.view WithText:@"验证码失效" andDelay:LOADING_TIME];
            } else if ([rqDic[HTTP_ERRCODE] intValue] == 108) {
                [self showHUDInView:self.view WithText:@"密码和账号不匹配" andDelay:LOADING_TIME];
            } else if ([rqDic[HTTP_ERRCODE] intValue] == 109) {
                [self showHUDInView:self.view WithText:@"密码和账号不匹配" andDelay:LOADING_TIME];
            } else if ([rqDic[HTTP_ERRCODE] intValue] == 200) {
                [self showHUDInView:self.view WithText:@"其他错误" andDelay:LOADING_TIME];
            } else {
                [self showHUDInView:self.view WithText:[NSString stringWithFormat:@"%@:%@",rqDic[HTTP_ERRCODE],rqDic[HTTP_MSG]] andDelay:LOADING_TIME];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@ , %@",operation,error);
        [self hideHUDInView:self.view];
        [self showHUDInView:self.view WithText:@"网络请求失败" andDelay:LOADING_TIME];
    }];
    
    [self hidKeyBoard];
    
}

// 获取用户信息
-(void)loadUserInfoDataWithApiDic:(NSDictionary *)param andLoginInfo:(NSDictionary *)dic_login
{
    YYHttpRequest *hq = [YYHttpRequest shareInstance_myapi];
    [hq GETURLString:@"/User/info/" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObj) {
        
        NSDictionary *rqDic = (NSDictionary *)responseObj;
        if ([rqDic[@"state"] boolValue]) {
            NSDictionary *infoDic = (NSDictionary *)[rqDic[@"data"] objectFromJSONString];
            NSLog(@"infoDic === %@",infoDic);
            
            NSLog(@"Sex == %@",infoDic[@"Sex"]);
            
            //保存用户信息
            [self saveUserInfor:infoDic withLoginInfo:dic_login];
        }else{
            
            NSLog(@"errorMsg: %@",rqDic[HTTP_MSG]);
            [self hideHUDInView:self.view];
            [self showHUDInView:self.view WithText:[NSString stringWithFormat:@"%@:%@",rqDic[HTTP_ERRCODE],rqDic[HTTP_MSG]] andDelay:LOADING_TIME];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error = %@",error);
        
        [self hideHUDInView:self.view];
        [self showHUDInView:self.view WithText:NETWORKERROR andDelay:LOADING_TIME];
    }];
    
}

//保存用户信息
-(void)saveUserInfor:(NSDictionary *)dic withLoginInfo:(NSDictionary *)dic_login
{
    UserObj *user = [[UserObj alloc] init];
    
    [user setUserName:dic[@"Mobile"]];
    [user setPassword:_pawssWorld.text];
    [user setIm:dic[@"UserLogin"]];
    [user setPhone:dic[@"Mobile"]];
    [user setClientkey:dic_login[@"clientkey"]];
    [user setIsLogin:YES];
    [user setNickName:dic[@"Nick"]];
    [user setTrueName:dic[@"TrueName"]];
    [user setSex:dic[@"Sex"]];
    [user setHeadPic:dic[@"HeadPicture"]];
    [user setEmail:dic[@"Email"]];
    [user setEmailState:[dic[@"EmailState"] boolValue]];
    [user setPhoneState:[dic[@"MobileState"] boolValue]];
    [user setRegTime:dic[@"RegDateTime"]];
    
    [user setAddress:dic[@"Address"]];
    [user setAge:dic[@"Age"]];
    [user setArea:dic[@"Area"]];
    [user setCity:dic[@"City"]];
    [user setHospital:dic[@"Hospital"]];
    [user setId:dic[@"Id"]];
    [user setProvince:dic[@"Province"]];
    [user setType:dic[@"Type"]];
    [user setKeshi:dic[@"keshi"]];
    [user setZhicheng:dic[@"zhicheng"]];
    
    [GlobalMethod saveObject:user withKey:USEROBJECT];
    [GlobalMethod saveLoginInStatus:YES];
    [GlobalMethod sharedInstance].isLogin = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark --------------注册---------------
- (IBAction)regainBtn:(id)sender {
    
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    registerVC.navTitle = @"手机验证";
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark  -----------忘记密码-------------
- (IBAction)forgetPWBtnAction:(id)sender {
    
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    registerVC.navTitle = @"找回密码";
    registerVC.isFindPass = YES;
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

#pragma mark  -----------自动登录-------------
- (IBAction)autoLoginBtnAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        _selectImageView.image = [UIImage imageNamed:@"choose40_selected"];
        [GlobalMethod sharedInstance].isAutoLogin = YES;
        
    }else{
        _selectImageView.image = [UIImage imageNamed:@"choose40_nomal"];
        [GlobalMethod sharedInstance].isAutoLogin = NO;
    }
    
}

- (BOOL)cheakText
{
    if (_nikeName.text.length == 0) {
        [self showAlertViewWithTitle:@"帐号不能为空" andDelay:1.5];
        return NO;
    }
    if (_pawssWorld.text.length == 0) {
        [self showAlertViewWithTitle:@"密码不能为空" andDelay:1.5];
        return NO;
    }
    return YES;
}

- (void)showAlertViewWithTitle:(NSString *)title andDelay:(CGFloat)time
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [self performSelector:@selector(removeAlert:) withObject:alert afterDelay:time];
    
}
- (void)removeAlert:(UIAlertView *)alertView
{
    [alertView removeFromSuperview];
    alertView = nil;
}

-(void)hidKeyBoard
{
    [WITool hideAllKeyBoard];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hidKeyBoard];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden  = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
