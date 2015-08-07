//
//  MyQuestTableViewCell.m
//  TSMedicine
//
//  Created by lyy on 15-8-7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyQuestTableViewCell.h"

@implementation MyQuestTableViewCell

- (void)awakeFromNib {
    // Initialization code
}



-(void)setModel:(MyPatQuestModel *)model
{
    _model = model;
    
    _questLab.text = model.uqcontent;
    
    NSString *dateStr = [model.uqcreatedate substringWithRange:NSMakeRange(0, 10)];
    _dateLab.text = dateStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
