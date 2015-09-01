//
//  myquerstionTableViewCell.h
//  TSMedicine
//
//  Created by 123 on 15/8/9.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPatQuestModel.h"
@interface myquerstionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *uqcontent1;

@property (weak, nonatomic) IBOutlet UILabel *uqcreatedate;

@property (weak, nonatomic) IBOutlet UILabel *uqstats;

@property (weak, nonatomic) IBOutlet UIButton *countBtn;

@property (nonatomic,strong) NSIndexPath *indexPath;


@property (nonatomic,strong)MyPatQuestModel *model;

@end
