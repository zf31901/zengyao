//
//  NewsModel.h
//  TSMedicine
//
//  Created by lyy on 15-7-7.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property (nonatomic, strong)             NSString *a_ID;
@property (nonatomic, strong)             NSString * title;
@property (nonatomic, strong)             NSString *a_Category;
@property (nonatomic, strong)             NSString *a_time;
@property (nonatomic, strong)             NSString *a_Content;
@property (nonatomic, strong)             NSString *a_SecondTitle;
@property (nonatomic, strong)             NSString *a_Title;
@property (nonatomic, strong)             NSString *a_From;
@property(nonatomic,strong)               NSString  *a_SmallImg;




@property(nonatomic,assign)               CGRect a_TitleF;
@property(nonatomic,assign)               CGRect a_FromF;
@property(nonatomic,assign)               CGRect a_timeF;
@property(nonatomic,assign)               CGRect a_SmallImgF;

@property(nonatomic,assign)               CGFloat CellH;


-(void)loadModel:(NSDictionary *)dict;
@end
