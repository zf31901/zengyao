//
//  MyquestionViewController.h
//  TSMedicine
//
//  Created by 123 on 15/8/7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProjectModel.h"
#import "MyAppModel.h"


@interface MyquestionViewController : BaseViewController
@property(nonatomic,strong) MyProjectModel  *goodIndex;//记录ID的值

@property(nonatomic,strong) MyAppModel *model;

@property (nonatomic,assign) BOOL isWeb;


@end
