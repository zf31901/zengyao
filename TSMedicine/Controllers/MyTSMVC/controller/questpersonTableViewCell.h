//
//  QuestPersoNTableViewCell.h
//  TSMedicine
//
//  Created by 123 on 15/8/12.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPatQuestModel.h"
#import "MyAnswerModel.h"
@interface QuestPersoNTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@property (weak, nonatomic) IBOutlet UILabel *answerLab;


@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) MyAnswerModel *model;
-(void)loadDataWithDataArray:(NSMutableArray *)dataArray andWithIndexPath:(NSIndexPath *)indexPath;
@end
