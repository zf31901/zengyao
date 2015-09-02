//
//  PatProjectTableViewCell.m
//  TSMedicine
//
//  Created by lyy on 15-8-31.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "PatProjectTableViewCell.h"

@implementation PatProjectTableViewCell

- (void)awakeFromNib {
    
    _countBtn.hidden = YES;
    _countBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
}

-(void)setModel:(MyProjectModel *)model
{
    _model = model;
    
    _projectNameLab.text = model.upname;
    
    
//    NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"%ld%@",_indexPath.row,model.uppid]];
    
    if ([model.upqaunreandcount integerValue] > 0) {
        
//        if (row == _indexPath.row) {
//            
//            _countBtn.hidden = YES;
//        }else{
        
            _countBtn.hidden = NO;
            [_countBtn setTitle:[NSString stringWithFormat:@"%ld",[model.upqaunreandcount integerValue]] forState:UIControlStateNormal];
            [_countBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
            
//        }
        
    }else{
        
        _countBtn.hidden = YES;
    }
    
//    [self loadCountWithProjectModel:model];
    
}


//-(void)loadCountWithProjectModel:(MyProjectModel *)model
//{
//    
//    [[GlobalMethod sharedInstance] getDoctorAnswerCountWithProjectModel:model newResponseCount:^(NSInteger count) {
//        
//        if (count > 0) {
//            
//            _countBtn.hidden = NO;
//            [_countBtn setTitle:[NSString stringWithFormat:@"%ld",count] forState:UIControlStateNormal];
//            [_countBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
//            
//        }else{
//            _countBtn.hidden = YES;
//        }
//        
//    }];
//
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
