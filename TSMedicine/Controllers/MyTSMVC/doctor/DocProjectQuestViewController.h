//
//  DocProjectQuestViewController.h
//  TSMedicine
//
//  Created by lyy on 15-8-7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "BaseViewController.h"
#import "MyProjectModel.h"

@interface DocProjectQuestViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) MyProjectModel *model;

@end
