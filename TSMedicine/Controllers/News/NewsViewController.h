//
//  NewsViewController.h
//  TSMedicine
//
//  Created by lyy on 15-6-10.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;

@interface NewsViewController : BaseViewController
//HUD
- (void)showHUDInView:(UIView *)view WithDetailText:(NSString *)text andDelay:(float)delay;
- (void)showHUDInView:(UIView *)view WithText:(NSString *)text andDelay:(float)delay withTag:(NSInteger)tag; //延迟消失
- (void)showHUDInView:(UIView *)view WithText:(NSString *)text andDelay:(float)delay; //延迟消失
- (void)showHUDInView:(UIView *)view WithText:(NSString *)text withTag:(NSInteger)tag;//显示（一直不消失）
- (void)showHUDInView:(UIView *)view WithText:(NSString *)text;//显示（一直不消失）
- (void)hideHUDInView:(UIView *)view;//消失
- (void)hudWasHidden:(MBProgressHUD *)hud; //消失后进入该方法


@end
