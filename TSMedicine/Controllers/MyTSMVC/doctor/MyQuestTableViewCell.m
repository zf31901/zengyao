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
    
    _dateLab.textColor = Commom_TextColor_Gray;
}

-(void)setModel:(MyPatQuestModel *)model
{
    _model = model;
    
    _questLab.text = model.uqcontent;
    _questLab.numberOfLines = 0;
    _questLab.height = model.contentSize.height;
    
    _dateLab.y = _questLab.height + 10;
    NSString *dateStr = [model.uqcreatedate substringWithRange:NSMakeRange(0, 10)];
    NSString *timeStr = [model.uqcreatedate substringWithRange:NSMakeRange(11, 5)];
    _dateLab.text = [NSString stringWithFormat:@"%@ %@",dateStr,timeStr];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
