//
//  MyPatientModel.h
//  TSMedicine
//
//  Created by lyy on 15-8-7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "BaseModel.h"

@interface MyPatientModel : BaseModel

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phoneNum;
@property (nonatomic,copy) NSString *state;

@property (nonatomic,assign) BOOL isReport;

@end
