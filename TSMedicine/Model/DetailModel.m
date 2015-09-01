//
//  DetailModel.m
//  TSMedicine
//
//  Created by 123 on 15/7/30.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel
-(void)setUqcontent:(NSString *)uqcontent
{
   _pshiyingzheng= uqcontent;
    
    _contentSize = [uqcontent sizeWithWidth:ScreenWidth - 20 withFont:17];
    
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}
@end
