//
//  UserObj.m
//  EwtStores
//
//  Created by Harry on 13-12-2.
//  Copyright (c) 2013年 Harry. All rights reserved.
//

#import "UserObj.h"

#define USERNAME    @"userName"
#define PASSWORD    @"password"
#define ATLOGIN     @"atLogin"
#define ISLOGIN     @"isLogin"
#define IM          @"im"
#define PHONE       @"phone"
#define CLIENTKEY   @"clientkey"
#define NICKNAME    @"nickName"
#define TRUENAME    @"trueName"
#define SEX         @"sex"
#define HEADPIC     @"headPic"
#define EMAIL       @"email"
#define EMAILSTATE  @"emailState"
#define PHONESTATE  @"phoneState"
#define REGTIME     @"regTime"

#define ADDRE       @"Address"
#define AGE         @"Age"
#define AREA        @"Area"
#define CITY        @"City"
#define HOSPIT      @"Hospital"
#define ID          @"Id"
#define PROVIN      @"Province"
#define TYPE        @"Type"
#define KESHI       @"keshi"
#define ZHICHENG    @"zhicheng"

@implementation UserObj

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self != nil)
    {
        self.userName   = [aDecoder decodeObjectForKey:USERNAME];
        self.password   = [aDecoder decodeObjectForKey:PASSWORD];
        self.atLogin    = [aDecoder decodeBoolForKey:ATLOGIN];
        self.isLogin    = [aDecoder decodeBoolForKey:ISLOGIN];
        self.im         = [aDecoder decodeObjectForKey:IM];
        self.phone      = [aDecoder decodeObjectForKey:PHONE];
        self.clientkey  = [aDecoder decodeObjectForKey:CLIENTKEY];
        self.nickName   = [aDecoder decodeObjectForKey:NICKNAME];
        self.trueName   = [aDecoder decodeObjectForKey:TRUENAME];
        self.sex        = [aDecoder decodeObjectForKey:SEX];
        self.headPic    = [aDecoder decodeObjectForKey:HEADPIC];
        self.email      = [aDecoder decodeObjectForKey:EMAIL];
        self.emailState = [aDecoder decodeBoolForKey:EMAILSTATE];
        self.phoneState = [aDecoder decodeBoolForKey:PHONESTATE];
        self.regTime    = [aDecoder decodeObjectForKey:REGTIME];
        
        self.Address      = [aDecoder decodeObjectForKey:ADDRE];
        self.Age          = [aDecoder decodeObjectForKey:AGE];
        self.Area         = [aDecoder decodeObjectForKey:AREA];
        self.City         = [aDecoder decodeObjectForKey:CITY];
        self.Hospital     = [aDecoder decodeObjectForKey:HOSPIT];
        self.Id           = [aDecoder decodeObjectForKey:ID];
        self.Province     = [aDecoder decodeObjectForKey:PROVIN];
        self.Type         = [aDecoder decodeObjectForKey:TYPE];
        self.keshi        = [aDecoder decodeObjectForKey:KESHI];
        self.zhicheng     = [aDecoder decodeObjectForKey:ZHICHENG];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userName forKey:USERNAME];
    [aCoder encodeObject:self.password forKey:PASSWORD];
    [aCoder encodeBool:self.isAtLogin  forKey:ATLOGIN];
    [aCoder encodeBool:self.isLogin    forKey:ISLOGIN];
    [aCoder encodeObject:self.im       forKey:IM];
    [aCoder encodeObject:self.phone    forKey:PHONE];
    [aCoder encodeObject:self.clientkey forKey:CLIENTKEY];
    [aCoder encodeObject:self.nickName forKey:NICKNAME];
    [aCoder encodeObject:self.trueName forKey:TRUENAME];
    [aCoder encodeObject:self.sex  forKey:SEX];
    [aCoder encodeObject:self.headPic    forKey:HEADPIC];
    [aCoder encodeObject:self.email       forKey:EMAIL];
    [aCoder encodeBool:self.emailState    forKey:EMAILSTATE];
    [aCoder encodeBool:self.phoneState forKey:PHONESTATE];
    [aCoder encodeObject:self.regTime       forKey:REGTIME];
    
    [aCoder encodeObject:self.Address       forKey:ADDRE];
    [aCoder encodeObject:self.Age       forKey:AGE];
    [aCoder encodeObject:self.Area       forKey:AREA];
    [aCoder encodeObject:self.City       forKey:CITY];
    [aCoder encodeObject:self.Hospital       forKey:HOSPIT];
    [aCoder encodeObject:self.Id       forKey:ID];
    [aCoder encodeObject:self.Province       forKey:PROVIN];
    [aCoder encodeObject:self.Type       forKey:TYPE];
    [aCoder encodeObject:self.keshi       forKey:KESHI];
    [aCoder encodeObject:self.zhicheng       forKey:ZHICHENG];
    
    
}

@end
