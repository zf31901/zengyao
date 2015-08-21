//
//  MyUserInfoHeadTableViewCell.m
//  TSMedicine
//
//  Created by lyy on 15-8-20.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyUserInfoHeadTableViewCell.h"

@implementation MyUserInfoHeadTableViewCell

- (void)awakeFromNib {
    
    [_headImageView makeCorner:_headImageView.size.width/2];
    _headImageView.userInteractionEnabled = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
