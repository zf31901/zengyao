//
//  BaseViewController.m
//  TSMedicine
//
//  Created by lyy on 15-6-10.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<MBProgressHUDDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setBarTintColor:VioletColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:RGBS(255), NSFontAttributeName:[UIFont systemFontOfSize:18]};
    
    [self buidLeftBtn];
    
    [self setbgView];
   
}
-(void)setbgView
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bgImageView.backgroundColor = UIColorFromRGB(0xf8f8f8);
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
}

-(void)createNavView
{
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,StatusBar_Height)];
    navView.backgroundColor = VioletColor;
    [self.view addSubview:navView];
    
}

- (void)buidLeftBtn
{
    if((int)[self.navigationController.viewControllers count]!=1)
    {
        UIButton *btn = [UIButton buttonWithType:0];
        [btn setImage:[UIImage imageNamed:@"arrow-left26x42_white"] forState:0];
        btn.frame = CGRectMake(0, 0, 60, 120);
        [btn setTitle:@"返回" forState:0];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0,40);
        
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -23, 0, 0);
    }
}
- (void)buidRightBtn:(NSString *)title
{
    if((int)[self.navigationController.viewControllers count]!=1)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 80, 60);
//        [btn setBackgroundColor:[UIColor redColor]];
        [btn setTitle:title forState:0];
        btn.titleLabel.textAlignment = NSTextAlignmentRight;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [btn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0,40);
        
        if (btn.titleLabel.text.length == 2) {
            
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 33, 0, 0);
            
        }else{
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
    
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)commit
{
    
}

#pragma mark -----------显示隐藏HUD---------------
- (void)showHUDInView:(UIView *)view WithDetailText:(NSString *)text andDelay:(float)delay
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:CGRectMake(60, 200, 200, 180)];
    [hud setDelegate:self];
    [view addSubview:hud];
    [hud setDetailsLabelText:text];
    [hud removeFromSuperViewOnHide];
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
    
    //tag by harry 2014-02-20: 加载数据过程可以返回
    // [self.view bringSubviewToFront:barView];
}

- (void)showHUDInView:(UIView *)view WithText:(NSString *)text andDelay:(float)delay withTag:(NSInteger)tag
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:CGRectMake(60, 200, 200, 180)];
    [hud setDelegate:self];
    [hud setTag:tag];
    [view addSubview:hud];
    [hud setLabelText:text];
    [hud removeFromSuperViewOnHide];
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
    
    //tag by harry 2014-02-20: 加载数据过程可以返回
    //[self.view bringSubviewToFront:barView];
}

- (void)showHUDInView:(UIView *)view WithText:(NSString *)text andDelay:(float)delay
{
    [self showHUDInView:view WithText:text andDelay:delay withTag:0];
}

- (void)showHUDInView:(UIView *)view WithText:(NSString *)text withTag:(NSInteger)tag
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [hud setTag:tag];
    [view addSubview:hud];
    [hud setLabelText:text];
    [hud removeFromSuperViewOnHide];
    [hud show:YES];
    
    //tag by harry 2014-02-20: 加载数据过程可以返回
//    [self.view bringSubviewToFront:barView];
}

- (void)showHUDInView:(UIView *)view WithText:(NSString *)text
{
    [self showHUDInView:view WithText:text withTag:0];
}

- (void)hideHUDInView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

#pragma mark ---------------MBHUDDelegate----------------
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
