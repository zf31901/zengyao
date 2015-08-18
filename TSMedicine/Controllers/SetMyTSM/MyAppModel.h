//
//  MyAppModel.h
//  TSMedicine
//
//  Created by 123 on 15/8/4.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAppModel : NSObject
@property (nonatomic, strong)             NSString *upimage;
@property (nonatomic, strong)             NSString *upname;
@property (nonatomic, strong)             NSString *upcreatedate;
@property(nonatomic,strong)              NSString *upstate;
@property(nonatomic,strong)               NSString *upqacount;
@property(nonatomic,strong)               NSString *upid;
@property(nonatomic,strong)               NSString *uppid;
@property(nonatomic,strong)               NSString *upuserid;
@property(nonatomic,strong)               NSString *upuseridcard;
@property(nonatomic,strong)               NSString *upusersex;
@property(nonatomic,strong)               NSString *upqcount;
@property(nonatomic,strong)               NSString *dataId;
@property(nonatomic,strong)               NSString *idNumber;
@property(nonatomic,strong)               NSString *phone;
@property(nonatomic,strong)               NSString *management;
@property(nonatomic,strong)               NSString *managementPhone;

@property(nonatomic,strong)               NSString *hospitalList;
@property(nonatomic,strong)               NSString *upuseraddress;
@property(nonatomic,strong)               NSString *upuserphone;

@property(nonatomic,strong)               NSString *upcode;



@property (nonatomic,assign) BOOL isReport;

@end
