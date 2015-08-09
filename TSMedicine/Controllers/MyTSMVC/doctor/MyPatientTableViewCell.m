//
//  MyPatientTableViewCell.m
//  TSMedicine
//
//  Created by lyy on 15-8-7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyPatientTableViewCell.h"

@implementation MyPatientTableViewCell

- (void)awakeFromNib {
    
    _nameLab.textColor = Commom_TextColor_Main;
    _phoneLab.textColor = Commom_TextColor_Gray;
    
}

-(void)setModel:(MyPatientModel *)model
{
    _model = model;
    
    _nameLab.text = model.name;
    _phoneLab.text = model.phoneNum;
    if (model.isReport) {
        _stateLab.text = @"已举报";
        _stateLab.textColor = UIColorFromRGB(0xc7c7c7);
    }else{
        _stateLab.text = @"举报";
        _stateLab.textColor = UIColorFromRGB(0x929292);
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
