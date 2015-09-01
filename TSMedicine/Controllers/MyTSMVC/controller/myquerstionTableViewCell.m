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
    _model = model;
    
    _uqcontent1.text = model.uqcontent;
    _uqcontent1.numberOfLines=0;
//    CGRect rect = [_uqcontent1.text boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_uqcontent1.font} context:nil];
//    _uqcontent1.frame = CGRectMake(0, 0, 320, rect.size.height);
    _uqcontent1.height=model.contentSize.height;
    NSString *dateStr = [model.uqcreatedate substringWithRange:NSMakeRange(0, 10)];
    _uqcreatedate.text = dateStr;
    
    _uqstats.text=[NSString stringWithFormat:@"%@人回答",model.uqcount];
    
    
    NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"%ld%@",_indexPath.row,model.uqid]];
    
    if ([model.uqunreadcount integerValue] > 0) {
        
        
        if (row == _indexPath.row) {
            
            _countBtn.hidden = YES;
        }else{
            
            _countBtn.hidden = NO;
            [_countBtn setTitle:[NSString stringWithFormat:@"%ld",[model.uqunreadcount integerValue]] forState:UIControlStateNormal];
            [_countBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
            
        }
       
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
