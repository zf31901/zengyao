//
//  MyUserInfoTableViewCell.m
//  TSMedicine
//
//  Created by lyy on 15-8-20.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyUserInfoTableViewCell.h"

@implementation MyUserInfoTableViewCell

- (void)awakeFromNib {
    
    _contentLab.textColor = UIColorFromRGB(0x929292);
    _contentLab.userInteractionEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
