//
//  MyTSMUserInfoViewController.m
//  TSMedicine
//
//  Created by lyy on 15-8-4.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyTSMUserInfoViewController.h"
#import "MyUserInfoView.h"

#import "UIImage+Rotation.h"
#import "UIImage+Resize.h"

NSString *const UserInfoView = @"MyUserInfoView";
@interface MyTSMUserInfoViewController () <UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) MyUserInfoView *infoView;

@property (nonatomic, strong) UIActionSheet *pageActionSheet;
@property (nonatomic,strong) UIImage *userImage;

@end

@implementation MyTSMUserInfoViewController

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
    _infoView = [[[NSBundle mainBundle] loadNibNamed:UserInfoView owner:self options:nil] lastObject];
    _infoView.frame = CGRectMake(0, 0, ScreenWidth, 286);
    [self.view addSubview:_infoView];
    
    if ([GlobalMethod sharedInstance].headImageURL.length > 0) {
         [_infoView.headImageView sd_setImageWithURL:[NSURL URLWithString:[GlobalMethod sharedInstance].headImageURL] placeholderImage:[UIImage imageNamed:default_head] options:SDWebImageRefreshCached];
    }else{
         [_infoView.headImageView sd_setImageWithURL:[NSURL URLWithString:UserInfoData.headPic] placeholderImage:[UIImage imageNamed:default_head] options:SDWebImageRefreshCached];
    }
   
    
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectHeadImage)];
    [_infoView.headImageView addGestureRecognizer:headTap];
    _infoView.headImageView.userInteractionEnabled = YES;
    
    
    _infoView.sexLab.text = @"男";
    _infoView.ageLab.text = @"25";
    _infoView.phoneLab.text = [NSString stringWithFormat:@"%@",UserInfoData.phone];
    _infoView.addreLab.text = @"广东";
    _infoView.streetLab.text = @"蛇口大道";
    
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
    _infoView.headImageView.image = renderedImage;
    
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
            NSLog(@"头像更新成功");
             NSDictionary *dataDic = (NSDictionary *)[responseObject[@"data"] objectFromJSONString];
            
//            NSLog(@"dataDic == %@",dataDic);
            
            [GlobalMethod sharedInstance].headImageURL = dataDic[@"fileurl"];
            
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
