//
//  ReportViewContrlller.h
//  TSMedicine
//
//  Created by lyy on 15-6-26.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPatientModel.h"

@interface ReportViewContrlller : BaseViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;


@property (nonatomic,strong) MyPatientModel *model;

@end
