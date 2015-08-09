//
//  UserObj.h
//  EwtStores
//
//  Created by Harry on 13-12-2.
//  Copyright (c) 2013年 Harry. All rights reserved.
//

#import "BaseModel.h"

@interface UserObj : BaseModel

@property (nonatomic, strong)             NSString *userName;   //用户名
@property (nonatomic, strong)             NSString *password;   //密码
@property (nonatomic, getter = isAtLogin) BOOL      atLogin;    //是否要自动登录
@property (nonatomic, getter = isLogin)   BOOL      isLogin;    //是否登录
@property (nonatomic, strong)             NSString *im;         //im号
@property (nonatomic, strong)             NSString *phone;      //手机号
@property (nonatomic, strong)             NSString *clientkey;  //身份状态标识
@property (nonatomic, strong)             NSString *nickName;   //昵称
@property (nonatomic, strong)             NSString *trueName;   //真实名称
@property (nonatomic, strong)             NSString *sex;        //性别
@property (nonatomic, strong)             NSString *headPic;    //头像地址
@property (nonatomic, strong)             NSString *email;      //电子邮箱
@property (nonatomic, getter = isEmailState)  BOOL      emailState; //邮箱是否认证
@property (nonatomic, getter = isPhoneState)  BOOL      phoneState; //手机号是否认证
@property (nonatomic, strong)             NSString *regTime;     //注册时间


@property (nonatomic,strong) NSString *Address;  //地址
@property (nonatomic,strong) NSString *Age;      //年龄
@property (nonatomic,strong) NSString *Area;     //地区
@property (nonatomic,strong) NSString *City;     //城市
@property (nonatomic,strong) NSString *Hospital; //医院
@property (nonatomic,strong) NSString *Id;       //
@property (nonatomic,strong) NSString *Province; //省份
@property (nonatomic,strong) NSString *Type;     //角色类型
@property (nonatomic,strong) NSString *keshi;    //
@property (nonatomic,strong) NSString *zhicheng; //职称



@end
