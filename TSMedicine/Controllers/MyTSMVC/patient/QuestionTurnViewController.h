//
//  QuestionTurnViewController.h
//  TSMedicine
//
//  Created by 123 on 15/8/10.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProjectModel.h"
#import "MyAppModel.h"


@interface QuestionTurnViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITextView *textView;

@property(nonatomic,strong)MyProjectModel *model;

@property(nonatomic,strong) MyAppModel *appModel;


@end
