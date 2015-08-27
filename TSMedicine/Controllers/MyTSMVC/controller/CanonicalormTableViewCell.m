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
    
    
}

- (IBAction)Phone1button:(id)sender {
   NSString *numbe=@"010-55144411";
      NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",numbe];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
  
}

- (IBAction)Phone2button:(id)sender {
    NSString *numbe=@"010-55133455";
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",numbe];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
