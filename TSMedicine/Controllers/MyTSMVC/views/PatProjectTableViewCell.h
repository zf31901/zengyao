//
//  PatProjectTableViewCell.h
//  TSMedicine
//
//  Created by lyy on 15-8-31.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProjectModel.h"

@interface PatProjectTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *projectNameLab;
@property (weak, nonatomic) IBOutlet UIButton *countBtn;

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) MyProjectModel *model;

@end
