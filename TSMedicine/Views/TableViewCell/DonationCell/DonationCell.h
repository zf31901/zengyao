//
//  DonationCell.h
//  TSMedicine
//
//  Created by lyy on 15-6-19.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DonationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *donation_imgView;
@property (weak, nonatomic) IBOutlet UILabel *donation_titleLab;
@property (weak, nonatomic) IBOutlet UILabel *donation_contentlab;
@property (weak, nonatomic) IBOutlet UILabel *donation_unitlab;
@property (nonatomic,strong) NSMutableArray *dataArr;

-(void)loadDataWithDataArray:(NSMutableArray *)dataArray andWithIndexPath:(NSIndexPath *)indexPath;
@end
