//
//  DonationCell.m
//  TSMedicine
//
//  Created by lyy on 15-6-19.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DonationCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailModel.h"
@implementation DonationCell

-(void)loadDataWithDataArray:(NSMutableArray *)dataArray andWithIndexPath:(NSIndexPath *)indexPath{
     _dataArr = dataArray;
    DetailModel *model=nil;
    if (_dataArr.count>0) {
       model  = [_dataArr objectAtIndex:indexPath.row];
  
    }
    
    _donation_contentlab.text=model.pname;
    _donation_unitlab.text=[NSString stringWithFormat:@"发起人单位:%@",model.pfaqidanwei];

    _donation_contentlab.text=model.pshiyingzheng;
    _donation_contentlab.numberOfLines = 0;
    
   _donation_contentlab.height = model.contentSize.height;
    [_donation_imgView sd_setImageWithURL:[NSURL URLWithString:model.pimage] placeholderImage:[UIImage imageNamed:nil] options:SDWebImageRefreshCached];



}
-(CGFloat)getCellHeight;
{
    return 88;
}
@end
