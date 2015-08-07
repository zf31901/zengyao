//
//  MyAppCellTableViewCell.m
//  TSMedicine
//
//  Created by 123 on 15/8/4.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyAppCellTableViewCell.h"

@implementation MyAppCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(MyAppModel *)model
{
    _model = model;
    
    
    if (model.isReport) {
       _upstate.text = @"申请通过";
        _upstate.textColor = UIColorFromRGB(0xc7c7c7);
    }else{
        _upstate.text = @"拒绝申请";
       _upstate.textColor = UIColorFromRGB(0x929292);
    }
    
    
}

@end
