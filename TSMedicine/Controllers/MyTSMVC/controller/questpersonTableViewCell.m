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
        
        NSString *nameStr = [NSString stringWithFormat:@"%@",model.uqusername];
        if (nameStr.length == 11) {
            NSMutableString *name = [NSMutableString stringWithFormat:@"%@",nameStr];
            NSString *replaceStr = @"****";
            [name replaceCharactersInRange:NSMakeRange(3, 4) withString:replaceStr];
            _nameLable.text = name;
        }else{
            _nameLable.text = model.uqusername;
        }
        
        NSString *dateStr = [model.uqcreatedate substringWithRange:NSMakeRange(0, 10)];
        NSString *timeStr = [model.uqcreatedate substringWithRange:NSMakeRange(11, 5)];
        _dateLab.text = [NSString stringWithFormat:@"%@ %@",dateStr,timeStr];
        
        _answerLab.text = [NSString stringWithFormat:@"问: %@",model.uqcontent];
        _answerLab.numberOfLines = 0;
        _answerLab.font=[UIFont systemFontOfSize:17.0f];
        
        CGSize size = [_answerLab.text sizeWithWidth:ScreenWidth - 20 withFont:17];
        _answerLab.height = size.height+10;
        NSLog(@"123---%f",model.contentSize.height);
        
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
    _answerLab.font=[UIFont systemFontOfSize:17.0f];
    _answerLab.height = model.contentSize.height+10;
    
}



@end
