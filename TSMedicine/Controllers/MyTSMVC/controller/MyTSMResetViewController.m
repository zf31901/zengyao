//
//  MyTSMResetViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-18.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyTSMResetViewController.h"

@interface MyTSMResetViewController ()

@end

@implementation MyTSMResetViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [_inputTF becomeFirstResponder];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    
    [self setUI];
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = _navTitle;
    [self buidRightBtn:@"确定"];
    
}

-(void)setUI
{
    _inputTF.clearButtonMode = UITextFieldViewModeAlways;
    
    switch (_sendTag) {
        case 201:
        {
            _inputTF.placeholder = @"输入昵称";
        }
            break;
            
        case 203:
        {
            _inputTF.placeholder = @"输入年龄";
        }
            break;
            
        case 204:
        {
            _inputTF.placeholder = @"输入手机号";
        }
            break;
            
        case 206:
        {
            _inputTF.placeholder = @"输入街道";
        }
            break;
            
        default:
            break;
    }

    if (_sendTag == 206) {
        _textLab.hidden = NO;
    }else{
        _textLab.hidden = YES;
    }
    
}

-(void)commit
{
    NSLog(@"确定");
    
    if (![self cheakText]) {
        return;
    }
    
    switch (_sendTag) {
        case 201:
        {
            NSDictionary *parameters = @{@"u":UserInfoData.im,@"UserLogin":UserInfoData.im,@"clientkey":UserInfoData.clientkey,@"Nick":_inputTF.text};
            [self resetInfoWithParameter:parameters];
        }
            break;
            
        case 203:
        {
            NSDictionary *parameters = @{@"u":UserInfoData.im,@"UserLogin":UserInfoData.im,@"clientkey":UserInfoData.clientkey,@"Age":_inputTF.text};
            [self resetInfoWithParameter:parameters];
        }
            break;
            
        case 204:
        {
            if (![self cheakPhoneNumber]) {
                return;
            }
            
            NSDictionary *parameters = @{@"u":UserInfoData.im,@"UserLogin":UserInfoData.im,@"clientkey":UserInfoData.clientkey,@"Mobile":_inputTF.text};
            [self resetInfoWithParameter:parameters];
        }
            break;
            
        case 206:
        {
            NSDictionary *parameters = @{@"u":UserInfoData.im,@"UserLogin":UserInfoData.im,@"clientkey":UserInfoData.clientkey,@"Address":_inputTF.text};
            [self resetInfoWithParameter:parameters];
        }
            break;
            
        default:
            break;
    }
}

-(void)resetInfoWithParameter:(NSDictionary *)parameter
{
    [HttpRequest_MyApi POSTURLString:@"/User/update/" parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"responseObject == %@",responseObject);
        
        if ([responseObject[@"state"] boolValue]) {
            
            NSDictionary *dataDic = (NSDictionary *)[responseObject[@"data"] objectFromJSONString];
//            NSLog(@"dataDic == %@",dataDic)
            
            if ([dataDic[@"result"] boolValue]) {
                
                 NSLog(@"修改成功");
                
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

-(BOOL)cheakPhoneNumber
{
    if ([WITool isValidateMobile:_inputTF.text]){
        return YES;
    }else{
        [self showAlertViewWithTitle:@"手机输入有误，请重新输入！" andDelay:1.5];
        return NO;
    }
}

- (BOOL)cheakText
{
    if (_inputTF.text.length == 0) {
        [self showAlertViewWithTitle:@"修改内容不能为空" andDelay:1.5];
        return NO;
    }
    return YES;
}

- (void)showAlertViewWithTitle:(NSString *)title andDelay:(CGFloat)time
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
