//
//  DocAnswerTableViewCell.h
//  TSMedicine
//
//  Created by lyy on 15-8-9.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAnswerModel.h"
#import "MyPatQuestModel.h"

@interface DocAnswerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *answerLab;

@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) MyAnswerModel *model;

-(void)loadDataWithDataArray:(NSMutableArray *)dataArray andWithIndexPath:(NSIndexPath *)indexPath;

@end
