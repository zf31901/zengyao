//
//  MyAppCellTableViewCell.h
//  TSMedicine
//
//  Created by 123 on 15/8/4.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAppModel.h"
@interface MyAppCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *upname;
@property (weak, nonatomic) IBOutlet UIImageView *upimage;
@property (weak, nonatomic) IBOutlet UILabel *dataTime;

@property (weak, nonatomic) IBOutlet UILabel *upstate;

@property(nonatomic,strong)MyAppModel *model;



@end
