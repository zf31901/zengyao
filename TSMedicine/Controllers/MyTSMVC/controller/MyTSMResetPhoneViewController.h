//
//  MyTSMResetPhoneViewController.h
//  TSMedicine
//
//  Created by lyy on 15-8-28.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "BaseViewController.h"

@interface MyTSMResetPhoneViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumbTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (nonatomic, strong) UIButton *verifyBtn;
@property (nonatomic,copy) NSString *navTitle;

@end
