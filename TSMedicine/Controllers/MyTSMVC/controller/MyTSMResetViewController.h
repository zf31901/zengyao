//
//  MyTSMResetViewController.h
//  TSMedicine
//
//  Created by lyy on 15-8-18.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "BaseViewController.h"

@interface MyTSMResetViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *inputTF;
@property (weak, nonatomic) IBOutlet UILabel *textLab;

@property (nonatomic,copy) NSString *navTitle;
@property (nonatomic,assign) NSInteger sendTag;



@end
