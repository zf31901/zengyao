//
//  NewsModel.m
//  TSMedicine
//
//  Created by lyy on 15-7-7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "NewsModel.h"


#define Margin 8

@implementation NewsModel


-(void)loadModel:(NSDictionary *)dict
{
    
    self.title =[dict objectForKey:@"title"];
    
    self.a_Title = [dict objectForKey:@"a_Title"];
    self.a_From = [dict objectForKey:@"a_From"];
    self.a_time = [dict objectForKey:@"time"];
    
    self.a_SmallImg=[dict objectForKey:@"a_SmallImg"];
    self.a_ID=[dict objectForKey:@"a_ID"];
    
    
    
    
    //图片frame
    CGFloat a_SmallImgWH = 80;
    CGFloat a_SmallImgY = Margin;
    CGFloat a_SmallImgX = ScreenW - a_SmallImgWH-a_SmallImgY;
    
    self.a_SmallImgF = CGRectMake(a_SmallImgX, a_SmallImgY, a_SmallImgWH, a_SmallImgWH);
    
    //内容frame
    CGFloat a_ContentX = Margin;
    CGFloat a_ContenY  = Margin;
    CGFloat a_ContenW ;
    
    //时间frame
    CGFloat a_timeX;
    CGFloat a_timeH = 21;
    CGFloat a_timeW = [Helper widthOfString:self.a_time font:[UIFont systemFontOfSize:13] height:a_timeH];
    CGFloat a_timeY;
    
    if ([self.a_SmallImg isEqualToString:@""]) {
        
        //没图片的时候
        a_ContenW = ScreenW - 2*a_ContentX;
        
        a_timeX = ScreenW - a_timeW - Margin;
        
    }
    else{
        a_ContenW = ScreenW - 3*a_ContentX - a_SmallImgWH;
        
        a_timeX = a_SmallImgX - a_timeW - Margin;
    }
    
    CGFloat a_ContenH = [Helper heightOfString:self.a_Title font:[UIFont systemFontOfSize:18] width:a_ContenW];
    
    self.a_TitleF = CGRectMake(a_ContentX, a_ContenY, a_ContenW, a_ContenH);
    
    //来源frame
    CGFloat a_FromX = Margin;
    CGFloat a_FromY = CGRectGetMaxY(self.a_TitleF)+Margin;
    CGFloat a_FromH = 21;
    CGFloat a_FromW = [Helper widthOfString:self.a_From font:[UIFont systemFontOfSize:15] height:a_FromH];
    self.a_FromF = CGRectMake(a_FromX, a_FromY, a_FromW, a_FromH);
    
    
    a_timeY = a_FromY;
    self.a_timeF = CGRectMake(a_timeX, a_timeY, a_timeW, a_timeH);
    
    
    //cell的高度
    
    CGFloat ImageMaxY = CGRectGetMaxY(self.a_SmallImgF);
    CGFloat timeMaxY = CGRectGetMaxY(self.a_timeF);
    self.CellH = (timeMaxY >=ImageMaxY ? timeMaxY :ImageMaxY) + Margin;
    
}

@end
