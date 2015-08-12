//
//  CanonicalormTableViewCell.m
//  TSMedicine
//
//  Created by 123 on 15/8/12.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "CanonicalormTableViewCell.h"
#import "CanonFormViewController.h"
@implementation CanonicalormTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)CanonicaForm:(id)sender {
    CanonFormViewController *nav=[[CanonFormViewController alloc]init];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
