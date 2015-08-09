//
//  MyPatQuestModel.m
//  TSMedicine
//
//  Created by lyy on 15-8-7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyPatQuestModel.h"

@implementation MyPatQuestModel

-(void)setUqcontent:(NSString *)uqcontent
{
    _uqcontent = uqcontent;
    
    _contentSize = [uqcontent sizeWithWidth:ScreenWidth - 20 withFont:17];
    
}

@end
