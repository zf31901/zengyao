//
//  RegisterViewController.h
//  TSMedicine
//
//  Created by lyy on 15-7-30.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumbTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;
@property (nonatomic, strong) UIButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (nonatomic,copy) NSString *navTitle;

@property (nonatomic,assign) BOOL isFindPass;

@end
