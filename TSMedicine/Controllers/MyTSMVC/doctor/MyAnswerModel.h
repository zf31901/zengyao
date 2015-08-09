//
//  MyAnswerModel.h
//  TSMedicine
//
//  Created by lyy on 15-8-9.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "BaseModel.h"

@interface MyAnswerModel : BaseModel

@property (nonatomic,copy) NSString *uqacontent;
@property (nonatomic,copy) NSString *uqaid;
@property (nonatomic,copy) NSString *uqauqid;
@property (nonatomic,copy) NSString *uqauserid;
@property (nonatomic,copy) NSString *uqauserimage;
@property (nonatomic,copy) NSString *uqausername;
@property (nonatomic,copy) NSString *uqcreatedate;

@property (nonatomic,assign) CGSize contentSize;


@end
