//
//  RegisterNextViewController.m
//  TSMedicine
//
//  Created by lyy on 15-7-31.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "RegisterNextViewController.h"

@interface RegisterNextViewController ()

@end

@implementation RegisterNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    [self drawUI];
    
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden  = NO;
    self.title = _navTitle;
    
}

-(void)drawUI
{
    _finishBtn.layer.cornerRadius = 5.0;
    [_finishBtn setBackgroundColor:Common_Btn_BgColor];
    
    _passWordTF1.secureTextEntry = YES;
    _passWordTF2.secureTextEntry = YES;
    
}
- (IBAction)finishBtnClick:(id)sender {
   
    if (![self cheakText]) {
        return;
    }
    NSLog(@"提交");
    
    if (_isChangePassWord)
    {
        //修改密码
        NSDictionary *parameters = @{@"pwd": _passWordTF2.text, @"u": _phoneNum};
        [HttpRequest_MyApi POSTURLString:@"/User/findpassword/resetpassword/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *rqDic = (NSDictionary *)responseObject;
//            NSLog(@"rqDic == %@",rqDic);
            if([rqDic[@"state"] boolValue]){
                 NSDictionary *dic = (NSDictionary *)[rqDic[@"data"] objectFromJSONString];
                if ([dic[@"result"] boolValue]) {
                    NSLog(@"密码修改成功");
                    UserObj *user = [[UserObj alloc] init];
                    [user setUserName:_phoneNum];
                    [user setPassword:_passWordTF2.text];
                    [GlobalMethod saveObject:user withKey:USEROBJECT];
                    [self showAlertViewWithTitle:@"密码修改成功!" andDelay:1.5];
                    
                }
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"error == %@",error);
        }];
        
    }else{
        
        //设置密码
        NSDictionary *parameters = @{@"pwd": _passWordTF2.text, @"phone": _phoneNum};
        [HttpRequest_MyApi POSTURLString:@"/User/register/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *rqDic = (NSDictionary *)responseObject;
            NSLog(@"rqDic == %@",rqDic);
            if([rqDic[@"state"] boolValue]){
                NSLog(@"注册成功");
                NSDictionary *dic = (NSDictionary *)[rqDic[@"data"] objectFromJSONString];
                NSString *userlogin = dic[@"userlogin"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册成功" message:[NSString stringWithFormat:@"您的爱心号: %@",userlogin] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }else{
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error == %@",error);
        }];
    }
    
    
}

-(BOOL)cheakText
{
    if (_passWordTF1.text.length == 0 || _passWordTF2.text.length == 0) {
        [self showAlertViewWithTitle:@"密码不能为空！" andDelay:1.5];
        return NO;
    }
    if (![_passWordTF1.text isEqualToString: _passWordTF2.text]) {
        [self showAlertViewWithTitle:@"两次密码输入不一致，请检查重新输入！" andDelay:1.5];
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
