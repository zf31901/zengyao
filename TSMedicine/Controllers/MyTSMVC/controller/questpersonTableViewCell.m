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
-(void)loadDataWithDataArray:(NSMutableArray *)dataArray andWithIndexPath:(NSIndexPath *)indexPath
{
    _dataArr = dataArray;
    if (indexPath.section == 0) {
        
        MyPatQuestModel *model = _dataArr[indexPath.section][indexPath.row];
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.uquserimage] placeholderImage:[UIImage imageNamed:default_head] options:SDWebImageRefreshCached];
        
        _nameLable.text = model.uqusername;
        
        NSString *dateStr = [model.uqcreatedate substringWithRange:NSMakeRange(0, 10)];
        NSString *timeStr = [model.uqcreatedate substringWithRange:NSMakeRange(11, 5)];
        _dateLab.text = [NSString stringWithFormat:@"%@ %@",dateStr,timeStr];
        
        _answerLab.text = [NSString stringWithFormat:@"问: %@",model.uqcontent];
        _answerLab.numberOfLines = 0;
        _answerLab.height = model.contentSize.height;
        
    }else{
        
        MyAnswerModel *model = _dataArr[indexPath.section][indexPath.row];
        self.model = model;
    }
    
}

-(void)setModel:(MyAnswerModel *)model
{
    _model = model;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.uqauserimage] placeholderImage:[UIImage imageNamed:default_head] options:SDWebImageRefreshCached];
    
    _nameLable.text = [NSString stringWithFormat:@"%@ 医师",model.uqausername];
    
    NSString *dateStr = [model.uqcreatedate substringWithRange:NSMakeRange(0, 10)];
    NSString *timeStr = [model.uqcreatedate substringWithRange:NSMakeRange(11, 5)];
    _dateLab.text = [NSString stringWithFormat:@"%@ %@",dateStr,timeStr];
    
    _answerLab.text = [NSString stringWithFormat:@"答: %@",model.uqacontent];
    _answerLab.numberOfLines = 0;
    _answerLab.height = model.contentSize.height;
    
}



@end
