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
    // Initialization code
}
-(void)setModel:(MyPatQuestModel *)model
{
    _model = model;
    
    _uqcontent1.text = model.uqcontent;
    _uqcontent1.numberOfLines=0;
    CGRect rect = [_uqcontent1.text boundingRectWithSize:CGSizeMake(200, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_uqcontent1.font} context:nil];
    _uqcontent1.frame = CGRectMake(0, 0, 320, rect.size.height);
    
    NSString *dateStr = [model.uqcreatedate substringWithRange:NSMakeRange(0, 10)];
    _uqcreatedate.text = dateStr;
    
    _uqstats.text=[NSString stringWithFormat:@"%@人回答",model.uqcount];

  
    
    
}


@end
