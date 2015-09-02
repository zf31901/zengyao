//
//  MyAnswerModel.m
//  TSMedicine
//
//  Created by lyy on 15-8-9.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyAnswerModel.h"

@implementation MyAnswerModel


-(void)setUqacontent:(NSString *)uqacontent
{
    _uqacontent = uqacontent;
    
    NSString *str = [NSString stringWithFormat:@"答: %@",uqacontent];
    _contentSize = [str sizeWithWidth:ScreenWidth - 20 withFont:17];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

@end
