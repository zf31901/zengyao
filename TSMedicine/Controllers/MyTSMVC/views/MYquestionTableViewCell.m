//
//  MYquestionTableViewCell.m
//  TSMedicine
//
//  Created by 123 on 15/8/7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MYquestionTableViewCell.h"

@implementation MYquestionTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    
        self.uqcontent = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 150, 30)];
    
        self.uqcontent.font = [UIFont boldSystemFontOfSize:20];
        self.uqcontent.numberOfLines=0;
        CGRect rect = [self.uqcontent.text boundingRectWithSize:CGSizeMake(200, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.uqcontent.font} context:nil];
        self.uqcontent.frame = CGRectMake(0, 0, 320, rect.size.height);
        

        [self.contentView addSubview:self.uqcontent];
        
        //时间
        self.uqcreatedate = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 30)];
        self.uqcreatedate.font = [UIFont systemFontOfSize:14];
        self.uqcreatedate.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.uqcreatedate];
        //回答
        self.uqstate=[[UILabel alloc]initWithFrame:CGRectMake(250, 20, 40, 40)];
        self.uqstate.font=[UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:self.uqstate];
        
        
    }
    
    return self;
    
    
}



@end
