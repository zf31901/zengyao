//
//  QuestionTurnViewController.m
//  TSMedicine
//
//  Created by 123 on 15/8/10.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "QuestionTurnViewController.h"


#define ONANSWER @"http://app.aixinland.cn:80/api/userquestionanswer/Add"

@interface QuestionTurnViewController ()<UITextViewDelegate>
{
    UITextView *_textView;
    

}
@end

@implementation QuestionTurnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buidRightBtn:@"发表"];
    
    [self Nav];
    _textView.returnKeyType=UIReturnKeyDone;//设置键盘中return 为 Done 完成
    _textView.scrollEnabled=NO;
    _textView.font=[UIFont fontWithName:@"Arial" size:16.0];
    _textView.text = @"详解";
    _textView.delegate=self;
    _textView.editable=YES;
    _textView.keyboardType=UIKeyboardTypeDefault;
    
    [self.view addSubview:_textView];

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [WITool hideAllKeyBoard];
}

-(void)Nav
{
    self.navigationController.navigationBarHidden = NO;
 
}
- (void)textViewDidChange:(UITextView *)textView{
    //计算文本的高度
    CGSize constraintSize;
    constraintSize.width = textView.frame.size.width-16;
    constraintSize.height = MAXFLOAT;

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder]; 
        
        return NO;
        
    }
    
    return YES;
    
}
//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView{




}
-(void)commit{

    NSLog(@"发表");

}

@end
