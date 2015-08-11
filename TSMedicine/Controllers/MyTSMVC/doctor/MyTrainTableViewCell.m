//
//  MyTrainTableViewCell.m
//  TSMedicine
//
//  Created by lyy on 15-8-7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyTrainTableViewCell.h"

@implementation MyTrainTableViewCell

- (void)awakeFromNib {
    
    _projectLab.textColor = Commom_TextColor_Main;
    _timeLab.textColor = Commom_TextColor_Gray;
    
}

-(void)setModel:(MyTrainModel *)model
{
    _model = model;
    
    if (model.timage) {
        [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.timage] placeholderImage:[UIImage imageNamed:default_head] options:SDWebImageRefreshCached];
    }
    
    _projectLab.text = model.tname;
    
    NSString *dateStr = [model.tcreatedate substringWithRange:NSMakeRange(0, 10)];
    NSString *timeStr = [model.tcreatedate substringWithRange:NSMakeRange(11, 5)];
    _timeLab.text = [NSString stringWithFormat:@"%@ %@",dateStr,timeStr];
    
    NSString *state = [NSString stringWithFormat:@"%@",model.tstate];
    
    if ([state isEqualToString:@"0"]) {
        _stateLab.text = @"待考核";
        _stateLab.textColor = UIColorFromRGB(0xff6600);
        
    }else if([state isEqualToString:@"1"]){
        _stateLab.text = @"考核通过";
        _stateLab.textColor = UIColorFromRGB(0x20a456);
       
    }else{
        
    }
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
