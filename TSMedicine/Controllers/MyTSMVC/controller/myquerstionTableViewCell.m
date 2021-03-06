//
//  myquerstionTableViewCell.m
//  TSMedicine
//
//  Created by 123 on 15/8/9.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "myquerstionTableViewCell.h"

@implementation myquerstionTableViewCell

- (void)awakeFromNib {
   
    _countBtn.hidden = YES;
    _countBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
}
-(void)setModel:(MyPatQuestModel *)model
{
    if (model) {
        _model = model;
    }
    
    
    _uqcontent1.text = model.uqcontent;
    _uqcontent1.numberOfLines=0;
    _uqcontent1.font=[UIFont systemFontOfSize:17.0f];
   // _uqcontent1.height=model.contentSize.height;
    
    
    _uqcreatedate.y=_uqcontent1.height-5;
    NSString *dateStr = [model.uqcreatedate substringWithRange:NSMakeRange(0, 10)];
    _uqcreatedate.text = dateStr;
    
    _uqstats.y=_uqcontent1.height-5;
    
    _uqstats.text=[NSString stringWithFormat:@"%@人回答",model.uqcount];
       //_countBtn.y=_uqcontent1.height-5;
    
//    NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"%ld%@",_indexPath.row,model.uqid]];
    
    if ([model.uqunreadcount integerValue] > 0) {
        
        
//        if (row == _indexPath.row) {
//            
//            _countBtn.hidden = YES;
//        }else{
        
            _countBtn.hidden = NO;
     
            [_countBtn setTitle:[NSString stringWithFormat:@"%ld",[model.uqunreadcount integerValue]] forState:UIControlStateNormal];
            [_countBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
            
//        }
       
    }else{
        _countBtn.hidden = YES;
    }
    
    
//    NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"%ld%@",_indexPath.row,model.uqid]];
//    [[GlobalMethod sharedInstance] getDoctorAnswerCountWithQuestionModel:model newResponseCount:^(NSInteger count) {
//        
//        if (count > 0) {
//            
//            _countBtn.hidden = NO;
//            [_countBtn setTitle:[NSString stringWithFormat:@"%ld",count] forState:UIControlStateNormal];
//            [_countBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
//          
//        }else{
//            
//            if (row == _indexPath.row) {
//                
//                _countBtn.hidden = YES;
//            }
//            
//        }
//        
//    }];
    
}


@end
