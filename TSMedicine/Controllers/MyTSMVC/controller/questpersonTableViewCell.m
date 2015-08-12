//
//  QuestPersoNTableViewCell.m
//  TSMedicine
//
//  Created by 123 on 15/8/12.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "QuestPersoNTableViewCell.h"

@implementation QuestPersoNTableViewCell

- (void)awakeFromNib {
    
    _dateLab.textColor = Commom_TextColor_Gray;
    _model = [[MyAnswerModel alloc] init];
    
    [_headImageView makeCorner:_headImageView.size.width/2];
    
}

@end
