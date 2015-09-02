//
//  DetailsViewController.h
//  TSMedicine
//
//  Created by 123 on 15/7/29.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface DetailsViewController : BaseViewController
@property(nonatomic,strong)NSString *Namelable;
@property(nonatomic,strong)NSString *forLable;
@property(nonatomic,strong)NSString *dataTime;
@property(nonatomic,strong)NSString *caseLable;

@property(nonatomic,strong)NewsModel  *NewsModel;//记录ID的值


@end
