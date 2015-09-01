//
//  ShopCell.m
//  customCellByCode
//
//  Created by Imanol on 11/10/14.
//  Copyright (c) 2014 ImanolZhang. All rights reserved.
//
#import "UIImageView+AFNetworking.h"


#import "NewsModel.h"

#define kCellBorder 20
#define kCellCenterX self.frame.size.width/2
#define kNameFont [UIFont systemFontOfSize:16]
#define kDescriptionFont [UIFont systemFontOfSize:14]
#define kImageWH 70
    
#import "NewsTableViewCell.h"
#import "ShopFrame.h"



@interface NewsTableViewCell ()
    
    
@end
    
@implementation NewsTableViewCell
    
-(void)loadCellWith:(NewsModel*)newsModel
{
    self.dataTimelab.text = newsModel.a_time;
    self.dataTimelab.frame = newsModel.a_timeF;
    self.dataTimelab. textColor = RGB(147, 139, 148);
    
    self.fromLab.text = newsModel.a_From;
    self.fromLab.frame = newsModel.a_FromF;
    self.fromLab.textColor = RGB(147, 139, 148);
    
    self.newlab.text = newsModel.a_Title;
    self.newlab.frame = newsModel.a_TitleF;
    self.newlab.textColor = [UIColor blackColor];
    
    if ([newsModel.a_SmallImg isEqualToString:@""]) {
        self.iamge.hidden=YES;
    }
    else{
         self.iamge.hidden=NO;
    [self.iamge sd_setImageWithURL:[NSURL URLWithString:newsModel.a_SmallImg] placeholderImage:nil];

    }
        self.iamge.frame = newsModel.a_SmallImgF;
}

    

    
    @end





