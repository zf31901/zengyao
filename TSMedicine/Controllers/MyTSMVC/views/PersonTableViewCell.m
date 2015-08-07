//
//  PersonTableViewCell.m
//  TSMedicine
//
//  Created by 123 on 15/8/7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "PersonTableViewCell.h"

@implementation PersonTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
  
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 150, 30)];
        //设置加粗字体
        self.nameLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.contentView addSubview:self.nameLabel];
        
        //实例化头像视图
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(250, 20, 40, 40)];
        
        [self.contentView addSubview:self.headImageView];
        

        
    }
    
    return self;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
