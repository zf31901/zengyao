//
//  MyUserInforView.m
//  TSMedicine
//
//  Created by lyy on 15-8-18.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "MyUserInforView.h"

@implementation MyUserInforView

-(void)awakeFromNib
{
    [_headView makeCorner:_headView.size.width/2];
    
    _nickNameLab.textColor = UIColorFromRGB(0x929292);
    _sexLab.textColor = UIColorFromRGB(0x929292);
    _ageLab.textColor = UIColorFromRGB(0x929292);
    _phoneLab.textColor = UIColorFromRGB(0x929292);
    _addreLab.textColor = UIColorFromRGB(0x929292);
    _streetLab.textColor = UIColorFromRGB(0x929292);
    
    _headView.userInteractionEnabled = YES;
    _nickNameLab.userInteractionEnabled = YES;
    _sexLab.userInteractionEnabled = YES;
    _ageLab.userInteractionEnabled = YES;
    _phoneLab.userInteractionEnabled = YES;
    _addreLab.userInteractionEnabled = YES;
    _streetLab.userInteractionEnabled = YES;
    
    
    _nickNameLab.tag = 200;
    _ageLab.tag = 201;
    _phoneLab.tag = 202;
    _addreLab.tag = 203;
    _streetLab.tag = 204;

}

@end
