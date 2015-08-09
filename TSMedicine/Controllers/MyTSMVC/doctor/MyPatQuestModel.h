//
//  MyPatQuestModel.h
//  TSMedicine
//
//  Created by lyy on 15-8-7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "BaseModel.h"

@interface MyPatQuestModel : BaseModel

@property (nonatomic,copy) NSString *uqcontent;
@property (nonatomic,copy) NSString *uqcount;
@property (nonatomic,copy) NSString *uqcreatedate;
@property (nonatomic,copy) NSString *uqid;
@property (nonatomic,copy) NSString *uqname;
@property (nonatomic,copy) NSString *uqpid;
@property (nonatomic,copy) NSString *uqpname;
@property (nonatomic,copy) NSString *uqstate;
@property (nonatomic,copy) NSString *uquserid;
@property (nonatomic,copy) NSString *uquserimage;
@property (nonatomic,copy) NSString *uqusername;

@property (nonatomic,assign) CGSize contentSize;

@end
