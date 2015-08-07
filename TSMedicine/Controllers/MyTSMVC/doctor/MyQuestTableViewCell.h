//
//  MyQuestTableViewCell.h
//  TSMedicine
//
//  Created by lyy on 15-8-7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPatQuestModel.h"

@interface MyQuestTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *questLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@property (nonatomic,strong) MyPatQuestModel *model;

@end
