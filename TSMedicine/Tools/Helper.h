//
//  Helper.h
//  PalmKitchen
//
//  Created by apple on 14-10-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Helper : NSObject

+(UIButton *)createButton:(CGRect)frame title:(NSString *)title image:(UIImage *)image target:(id)target selector:(SEL)selector;

//字符串文字的长度
+(CGFloat)widthOfString:(NSString *)string font:(UIFont*)font height:(CGFloat)height;

//字符串文字的高度
+(CGFloat)heightOfString:(NSString *)string font:(UIFont*)font width:(CGFloat)width;

+(void)setRoundview:(UIView*)view borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;

//获取今天的日期：年月日
+(NSDictionary *)getTodayDate;

//邮箱
+ (BOOL) justEmail:(NSString *)email;

//手机号码验证
+ (BOOL) justMobile:(NSString *)mobile;

//车牌号验证
+ (BOOL) justCarNo:(NSString *)carNo;

//车型
+ (BOOL) justCarType:(NSString *)CarType;

//用户名
+ (BOOL) justUserName:(NSString *)name;

//密码
+ (BOOL) justPassword:(NSString *)passWord;

//昵称
+ (BOOL) justNickname:(NSString *)nickname;

//创建UIImageView
+(UIImageView *)creatUIImageViewWithframe:(CGRect)frame onView:(UIView*)view;

//身份证号
+ (BOOL) justIdentityCard: (NSString *)identityCard;

//创建button
+(UIButton*)creatButton:(CGRect)frame title:(NSString*)title target:(id)target selector:(SEL)selector onview:(UIView*)view;

//创建提醒视图
+(UIAlertView*)alertviewWith:(NSString*)title;

//显示正在加载
+ (void)showMBProgessHUD:(UIView *)superView animated:(BOOL)animated;

//隐藏正在加载
+ (void)hideMBProgessHUD:(UIView *)superView animated:(BOOL)animated;

//判断日周月
+(NSString*)dateType:(NSString*)dateTypeNum;

//获取信用度
+(NSArray*)getCredit:(NSString*)LoanPurpose;

//还款方式
+(NSString*)RepaymentWay:(NSString *)RepaymentWay;

//判断添加银行卡信息反馈代码对应的字符串
+(void)getAddBankCardState:(NSString*)ErrorCode;

//判断提现信息反馈代码对应的字符串
+(void)getWithdrawCodeState:(NSString*)ErrorCode;

//判断注册错误代码对应的字符串
+(void)getCodeStr:(NSString*)ErrorCode;

//判断验证码请求反馈代码对应的字符串
+(void)getCodeState:(NSString*)ErrorCode;

//判断提交订单信息反馈代码对应的字符串
+(void)getOrderState:(NSString*)ErrorCode;

//判断增加地址信息反馈代码对应的字符串
+(void)getaddressCodeState:(NSString*)ErrorCode;

//判断手机充值下一步反馈对应的字符串
+(void)getNextSlectState:(NSString *)ErrorCode;

//判断手机充值立即充值反馈对应的字符串
+(void)getPayState:(NSString *)ErrorCode;

//添加手势点击事件
+(void)addGestureRecognizer:(UIView*)View Target:(id)target action:(SEL)action;

//担保公司类型
+(NSString *)getAssureType:(NSString*)Type;

//创建label
+(UILabel *)creatLabelWithframe:(CGRect)frame title:(NSString*)title font:(CGFloat)font onView:(UIView*)view;

//创建UITextField
+(UITextView *)creatUITextViewWithframe:(CGRect)frame text:(NSString*)text font:(CGFloat)font onView:(UIView*)view;

//修改webView的字体大小
+(void)setWebView:(UIWebView*)webView TextSize:(CGFloat)TextSize;

//修改webview字体颜色
+(void)setWebView:(UIWebView *)webView TextColor:(NSString*)TextColor;

//动态计算webView的高度   -----此方法必须在webview代理方法中调用
+(void)setWebViewHeight:(UIWebView*)webView defaultHeight :(CGFloat)defaultHeight;


//根据时间错求时间yyyy-MM-dd HH:mm
+(NSString*)getDate:(NSString*)timersp;

//根据时间错求时间yyyy-MM-dd 
+(NSString*)getDateNYR:(NSString*)timersp;

//正则表达式匹配字符串
+(NSMutableArray*)getStringRangeByRegstring:(NSString *)Regstring searchString:(NSString*)searchString;

//设置文本框
+(void)setTextField:(UITextField*)textField text:(NSString*)text;

//给金额每三位插入一个逗号
+(NSString *)countNumAndChangeformat:(NSString *)AmountStr;


//判断投标请求反馈代码对应的字符串
+(void)getBidCodeState:(NSString*)ErrorCode;

//限制textfield只能输入数字 在textfield shouldChangeCharactersInRange 代理中使用
+(BOOL)textFieldInputNum :(NSString*)string;

//用颜色值创建UIimage
+ (UIImage *)createImageWithColor:(UIColor *)color;

//实名认证反馈代码对应的字符串
+(void)getRealNameCodeState:(NSString*)ErrorCode;

#pragma mark-获取银行卡图片以及名字
+(NSString *)getBankIcon:(NSString*)bankName;

#pragma mark-获取银行信息
+(NSArray *)getBankList;

//webview图片等比缩放
+(void)setWebViewScale:(UIWebView *)webView ImageSize:(CGFloat)ImageSize;

//求字符串长度
+(int)charNumber:(NSString*)strtemp;

#pragma mark 判段是否有中文字符串
+(BOOL)IsChinese:(NSString *)str;

#pragma mark 设置文本属性
+(void)setTextAttribute:(NSDictionary*)Attribute regtag:(NSString *)regtag label:(UILabel*)label;

#pragma mark - 行间距
+(void)setLabel:(UILabel *)label string:(NSString *)str withLineSpacing:(CGFloat)space;

//标状态
+(NSArray*)LoanStatus:(NSString*)Status;

//标状态字符串转 标号
+(NSString*)getNumWithLoanstatu:(NSString*)loanstatus;

//标类型转字符串
+(NSString*)getLoanTypeWith:(NSString*)loanTypeNum;

//判断银行卡号是否正确
+(BOOL)isValidCreditNumber:(NSString *)cardNo;

#pragma mark 删除导航器下面的线
+(void)removeLine:(UINavigationBar*)navigationBar;

@end


