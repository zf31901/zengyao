//
//  DonationCell.m
//  TSMedicine
//
//  Created by lyy on 15-6-19.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DonationCell.h"
#import "UIImageView+AFNetworking.h"

@implementation DonationCell

-(void)update
{
    
   
  
    [self.donation_imgView setImageWithURL:[NSURL URLWithString:self.cellData[@"donation_imgView"]] placeholderImage:nil];
    
    self.donation_titleLab.text = self.cellData[@"donation_titleLab"];
  
    self.donation_unitlab.text=[NSString stringWithFormat:@"发起人单位：%@",self.cellData[@"donation_unitlab"]];
    self.donation_contentlab.text=self.cellData[@"donation_contentlab"];
    
//    NSString *lab = [NSString stringWithFormat:@"%@",self.cellData[@"donation_contentlab"]];
//    NSString *donation_contentlab =  [lab stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
//    self.donation_contentlab.text = donation_contentlab;
//    NSLog(@"%@",self.cellData[@"donation_contentlab"]);

}
-(CGFloat)getCellHeight;
{
    return 88;
}
@end
