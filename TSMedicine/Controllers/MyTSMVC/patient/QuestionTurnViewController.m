//
//  QuestionTurnViewController.m
//  TSMedicine
//
//  Created by 123 on 15/8/10.
//  Copyright (c) 2015年 ewt. All rights reserved.
//


#import "QuestionTurnViewController.h"
#import "MyAnswerModel.h"
#import "QuestionViewController.h"

#define ONANSWER @"http://app.aixinland.cn:80/api/userquestionanswer/Add"
#define IS_IPHONE_5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface QuestionTurnViewController ()<UITextViewDelegate>
{
    
    NSMutableArray *_dataArr;
    
}
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *TextViewLab;


@end

@implementation QuestionTurnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buidRightBtn:@"发表"];
    
    [self Nav];
    _dataArr=[[NSMutableArray alloc]init];
    

    
    _TextViewLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 10*2, 40)];
    
    _TextViewLab.numberOfLines=0;
    _TextViewLab.textColor=Commom_TextColor_Gray;
    _TextViewLab.enabled=NO;
    //_TextViewLab.text=@"欢迎给我们提宝贵的意见";
    _TextViewLab.backgroundColor=[UIColor clearColor];
    _TextViewLab.font=[UIFont systemFontOfSize:14];
    _TextViewLab.textColor=[UIColor lightGrayColor];
    [_textView addSubview:_TextViewLab];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTap)];
    [self.view addGestureRecognizer:tap];
    
}
-(void)myTap{
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [WITool hideAllKeyBoard];
}

-(void)Nav
{
    self.navigationController.navigationBarHidden = NO;
    
}
-(void)commit{
    
    NSLog(@"发表");
    
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    //UserInfoData.im
    NSString *currentTime = [WITool getCurrentTime];
    NSDictionary *dic = @{@"uqid":@(0),@"uqpid":_model.uppid,@"uqpname":UserInfoData.trueName,@"uqname":UserInfoData.nickName,@"uqcontent":_textView.text,@"uquserid":_model.upuserid,@"uqcreatedate":currentTime,@"uqusername":UserInfoData.userName,@"uqstate":@(0)};
    
    [rq POSTURLString:@"http://app.aixinland.cn/api/userquestion/Add" parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject ==== %@",responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"Success"]) {
           _textView.text = @"";
            
            NSLog(@"responseObject-123123%@",responseObject[@"message"]);
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
    }];
    
    
}
@end
