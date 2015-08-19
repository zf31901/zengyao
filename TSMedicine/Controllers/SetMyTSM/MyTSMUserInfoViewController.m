//
//  MyTSMUserInfoViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-4.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyTSMUserInfoViewController.h"
#import "MyTSMResetViewController.h"
#import "MyUserInforView.h"

#import "UIImage+Rotation.h"
#import "UIImage+Resize.h"

NSString *const UserInforView = @"MyUserInforView";
@interface MyTSMUserInfoViewController () <UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) MyUserInforView *inforView;

@property (nonatomic, strong) UIActionSheet *pageActionSheet;
@property (nonatomic,strong) UIImage *userImage;

@end

@implementation MyTSMUserInfoViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _inforView.nickNameLab.text = [NSString stringWithFormat:@"%@",UserInfoData.nickName];
    _inforView.sexLab.text = [NSString stringWithFormat:@"%@",UserInfoData.sex];
    _inforView.ageLab.text = [NSString stringWithFormat:@"%@",UserInfoData.Age];
    _inforView.phoneLab.text = [NSString stringWithFormat:@"%@",UserInfoData.phone];
    _inforView.addreLab.text = [NSString stringWithFormat:@"%@",UserInfoData.Area];
    _inforView.streetLab.text = [NSString stringWithFormat:@"%@",UserInfoData.Address];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavView];
    
    [self createUI];
    
}

-(void)setNavView
{
    self.navigationController.navigationBarHidden = NO;
    self.title = @"个人资料";
    
}
-(void)createUI
{
    
    _inforView = [[[NSBundle mainBundle] loadNibNamed:UserInforView owner:self options:nil] lastObject];
    [self.view addSubview:_inforView];
    
    //头像
    [_inforView.headView sd_setImageWithURL:[NSURL URLWithString:UserInfoData.headPic] placeholderImage:[UIImage imageNamed:default_head] options:SDWebImageRefreshCached];
    
    //换头像
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectHeadImage)];
    [_inforView.headView addGestureRecognizer:headTap];
    
    //性别
    UITapGestureRecognizer *sexTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectSex)];
    [_inforView.sexLab addGestureRecognizer:sexTap];
    
    //昵称
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTap:)];
    [_inforView.nickNameLab addGestureRecognizer:tap1];
    
    //年龄
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTap:)];
    [_inforView.ageLab addGestureRecognizer:tap2];
    
    //手机号
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTap:)];
    [_inforView.phoneLab addGestureRecognizer:tap3];
    
    //地址
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTap:)];
    [_inforView.addreLab addGestureRecognizer:tap4];
    
    //街道
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTap:)];
    [_inforView.streetLab addGestureRecognizer:tap5];
    
}

#pragma mark ----------头像修改------------------------
-(void)selectHeadImage
{
     NSLog(@"换头像");
    [self.pageActionSheet showInView:self.view];
}

#pragma mark ------------头像选择弹出框---------------
- (UIActionSheet *)pageActionSheet
{
    if(!_pageActionSheet) {
        _pageActionSheet = [[UIActionSheet alloc]
                            initWithTitle:nil
                            delegate:self
                            cancelButtonTitle:nil
                            destructiveButtonTitle:nil
                            otherButtonTitles:nil];
        _pageActionSheet.tag = 20;
        
//        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//        {
//            [_pageActionSheet addButtonWithTitle:NSLocalizedString(@"拍照", @"")];
//        }
        [_pageActionSheet addButtonWithTitle:NSLocalizedString(@"拍照", @"")];
        [_pageActionSheet addButtonWithTitle:NSLocalizedString(@"从相册中选择", @"")];
        
        [_pageActionSheet addButtonWithTitle:NSLocalizedString(@"取消", @"")];
        _pageActionSheet.cancelButtonIndex = [self.pageActionSheet numberOfButtons]-1;
    }
    return _pageActionSheet;
}
#pragma mark ------------------------ UIActionSheetDelegate------------------
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 20) {
        NSString *actTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
        if ([actTitle isEqualToString:@"拍照"])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            picker.allowsEditing = YES;
            
            [self presentModalViewController:picker animated:YES];
        }
        else if([actTitle isEqualToString:@"从相册中选择"])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            picker.allowsEditing = YES;
            
            [self presentModalViewController:picker animated:YES];
        }
        self.pageActionSheet = nil;
        
    }else if (actionSheet.tag == 21){
        switch (buttonIndex) {
            case 0:
            {
                _inforView.sexLab.text = @"男";
                NSDictionary *parameters = @{@"u":UserInfoData.im,@"UserLogin":UserInfoData.im,@"clientkey":UserInfoData.clientkey,@"Sex":_inforView.sexLab.text};
                [self resetSexWithParameter:parameters];
            }
                break;
            case 1:
            {
                _inforView.sexLab.text = @"女";
                 NSDictionary *parameters = @{@"u":UserInfoData.im,@"UserLogin":UserInfoData.im,@"clientkey":UserInfoData.clientkey,@"Sex":_inforView.sexLab.text};
                [self resetSexWithParameter:parameters];
            }
                break;
                
            default:
                break;
        }
        
    }else{
        
    }
    
}
#pragma -mark ---------------------相片选取相关-----------------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //图片压缩
    UIImage *renderedImage = [image rotate];
    renderedImage = [renderedImage resizedImageWithContentMode:UIViewContentModeScaleAspectFill
                                                        bounds:CGSizeMake(80, 80)
                                          interpolationQuality:kCGInterpolationDefault];
    self.userImage = renderedImage;
    _inforView.headView.image = renderedImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self upDateHeadImage];
}
#pragma mark ---------------头像数据上传-----------------
-(void)upDateHeadImage
{
    NSData *pictureData = nil;
    if (self.userImage) {
        pictureData = UIImagePNGRepresentation(self.userImage);
    }
    
    NSDictionary *dic = @{@"clientkey":UserInfoData.clientkey,@"UserLogin":UserInfoData.im};
    
    [HttpRequest_MyApi POSTURLString:@"/User/updateavatarfile/" parameters:dic imageData:pictureData success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//         NSLog(@"responseObject == %@",responseObject);
        
        if ([responseObject[@"state"] boolValue]) {
             NSDictionary *dataDic = (NSDictionary *)[responseObject[@"data"] objectFromJSONString];
            if ([dataDic[@"result"] boolValue]) {
                 NSLog(@"头像更新成功");
            }
            
            [[GlobalMethod sharedInstance] reloadUserInfoDataSuccess:^(NSString *status) {
                if ([status isEqualToString:@"success"]) {
                    NSLog(@"用户数据更新成功");
                }
            } failure:^{
                
            }];
            
        }else{
            [self showHUDInView:self.view WithText:[NSString stringWithFormat:@"%@:%@",responseObject[HTTP_ERRCODE],responseObject[HTTP_MSG]] andDelay:LOADING_TIME];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error == %@",error);
    }];
    
}

#pragma mark ----------------选择性别------------------
-(void)selectSex
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    sheet.tag = 21;
    [sheet showInView:self.view];
    
}

-(void)myTap:(UIGestureRecognizer *)sender
{
    switch (sender.view.tag) {
        case 200:
        {
//             NSLog(@"修改昵称");
            MyTSMResetViewController *resetVC = [[MyTSMResetViewController alloc] init];
            resetVC.navTitle = @"修改昵称";
            resetVC.sendTag = 200;
            [self.navigationController pushViewController:resetVC animated:YES];
        }
            break;
            
        case 201:
        {
//            NSLog(@"修改年龄");
            MyTSMResetViewController *resetVC = [[MyTSMResetViewController alloc] init];
            resetVC.navTitle = @"修改年龄";
            resetVC.sendTag = 201;
            [self.navigationController pushViewController:resetVC animated:YES];
        }
            break;
            
        case 202:
        {
//            NSLog(@"修改手机号");
            MyTSMResetViewController *resetVC = [[MyTSMResetViewController alloc] init];
            resetVC.navTitle = @"修改手机号";
            resetVC.sendTag = 202;
            [self.navigationController pushViewController:resetVC animated:YES];
        }
            break;
            
        case 203:
        {
//            NSLog(@"修改地址");
            MyTSMResetViewController *resetVC = [[MyTSMResetViewController alloc] init];
            resetVC.navTitle = @"修改地址";
            resetVC.sendTag = 203;
            [self.navigationController pushViewController:resetVC animated:YES];
            
        }
            break;
            
        case 204:
        {
//            NSLog(@"修改街道");
            MyTSMResetViewController *resetVC = [[MyTSMResetViewController alloc] init];
            resetVC.navTitle = @"修改街道";
            resetVC.sendTag = 204;
            [self.navigationController pushViewController:resetVC animated:YES];
        }
            break;
            
        default:
            break;
    }

}

#pragma mark ----------修改性别---------------
-(void)resetSexWithParameter:(NSDictionary *)parameter
{
    [HttpRequest_MyApi POSTURLString:@"/User/update/" parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"responseObject == %@",responseObject);
        
        if ([responseObject[@"state"] boolValue]) {
            
            NSDictionary *dataDic = (NSDictionary *)[responseObject[@"data"] objectFromJSONString];
            
            if ([dataDic[@"result"] boolValue]) {
                NSLog(@"性别修改成功");
                
                [[GlobalMethod sharedInstance] reloadUserInfoDataSuccess:^(NSString *status) {
                    if ([status isEqualToString:@"success"]) {
                        NSLog(@"用户数据更新成功");
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
