//
//  Helper.m
//  PalmKitchen
//
//  Created by apple on 14-10-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Helper.h"
#import "MBProgressHUD.h"

@implementation Helper

+(UIButton *)createButton:(CGRect)frame title:(NSString *)title image:(UIImage *)image target:(id)target selector:(SEL)selector
{
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.frame=frame;
    CGRect newFrame=frame;
    newFrame.origin.y=frame.size.height/2.0;
    newFrame.size.height=frame.size.height/2.0;
    newFrame.origin.x=0;
    UILabel * label=[[UILabel alloc]initWithFrame:newFrame];
    label.text=title;
    [button addSubview:label];
    label.font=[UIFont systemFontOfSize:12];
    label.backgroundColor=[UIColor blueColor];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height
{
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect rect=[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width;
}

+(CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width
{
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds=[string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size.height;
}

#pragma mark 设置圆角
+(void)setRoundview:(UIView*)view borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius
{
    view.layer.cornerRadius = cornerRadius;
    view.clipsToBounds = YES;
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
}
#pragma  mark - 获取当天的日期：年月日
+ (NSDictionary *)getTodayDate
{
    
    //获取今天的日期
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay;
    
    NSDateComponents *components = [calendar components:unit fromDate:today];
    NSString *year = [NSString stringWithFormat:@"%ld", (long)[components year]];
    NSString *month = [NSString stringWithFormat:@"%02ld", (long)[components month]];
    NSString *day = [NSString stringWithFormat:@"%02ld", (long)[components day]];
    
    NSMutableDictionary *todayDic = [[NSMutableDictionary alloc] init];
    [todayDic setObject:year forKey:@"year"];
    [todayDic setObject:month forKey:@"month"];
    [todayDic setObject:day forKey:@"day"];
    
    return todayDic;
    
}
//邮箱
+ (BOOL) justEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) justMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString * phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


//车牌号验证
+ (BOOL) justCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL) justCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL) justUserName:(NSString *)name
{
       
    NSString *userNameRegex = @"^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$";//@"^[A-Za-z0-9]{6,20}+$";
    
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
  
}

//密码
+ (BOOL) justPassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL) justNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL) justIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


//创建button
+(UIButton*)creatButton:(CGRect)frame title:(NSString*)title target:(id)target selector:(SEL)selector onview:(UIView*)view
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [view addSubview:button];
    return button;
}

//创建提醒视图
+(UIAlertView*)alertviewWith:(NSString*)title
{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"提示" message:title delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [alertview show];
    
    //1S后自动消失
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(hideAlert:) userInfo:alertview repeats:NO];
 
    return alertview;
}


+(void)hideAlert:(NSTimer*)timer
{
    
    [timer.userInfo dismissWithClickedButtonIndex:0 animated:YES];
}

//显示加载提示
+ (void)showMBProgessHUD:(UIView *)superView animated:(BOOL)animated
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:animated];
    hud.labelText = @"加载中...";
   
    
}


+ (void)hideMBProgessHUD:(UIView *)superView animated:(BOOL)animated
{
    [MBProgressHUD hideAllHUDsForView:superView animated:animated];
}


//设置文本框
+(void)setTextField:(UITextField*)textField text:(NSString*)text
{
    UILabel *leftView1 = [Helper creatLabelWithframe:CGRectMake(0, 0, 80, textField.height) title:text font:14 onView:nil];
    textField.leftView = leftView1;
    textField.leftViewMode =  UITextFieldViewModeAlways;
    leftView1.textAlignment = NSTextAlignmentCenter;
    textField.leftView = leftView1;
    
}

//添加手势点击事件
+(void)addGestureRecognizer:(UIView*)View Target:(id)target action:(SEL)action
{
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [View addGestureRecognizer:tap];
    tap.delegate=(id)View;
    View.userInteractionEnabled = YES;
}

//创建UIImageView
+(UIImageView *)creatUIImageViewWithframe:(CGRect)frame onView:(UIView*)view
{
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:frame];
    [view addSubview:imageview];
    return imageview;
}
//创建Label
+(UILabel *)creatLabelWithframe:(CGRect)frame title:(NSString*)title font:(CGFloat)font onView:(UIView*)view
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.font = [UIFont systemFontOfSize:font];
    [view addSubview:label];
    return label;
}
//创建UITextField
+(UITextView *)creatUITextViewWithframe:(CGRect)frame text:(NSString*)text font:(CGFloat)font onView:(UIView*)view
{
    UITextView *textview = [[UITextView alloc]initWithFrame:frame];
    textview.text = text;
    textview.layer.borderColor = [UIColor grayColor].CGColor;
    textview.layer.borderWidth = 1;
    textview.layer.cornerRadius = 6;
    textview.layer.masksToBounds = YES;
    textview.font = [UIFont systemFontOfSize:font];
    [view addSubview:textview];
    return textview;
}
//修改webView的字体大小
+(void)setWebView:(UIWebView*)webView TextSize:(CGFloat)TextSize
{
    //修改webview字体
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%lf%%'",TextSize]];
   
}

//修改webview字体颜色
+(void)setWebView:(UIWebView *)webView TextColor:(NSString*)TextColor
{
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '%@'",TextColor]];
}


//webview图片等比缩放
+(void)setWebViewScale:(UIWebView *)webView ImageSize:(CGFloat)ImageSize
{
    //缩放图片例
    
    NSString *javaStr = [NSString stringWithFormat:@"var script = document.createElement('script');"
                         "script.type = 'text/javascript';"
                         "script.text = \"function ResizeImages() { "
                         "var myimg,oldwidth;"
                         "var maxwidth=%lf;"
                         "var maxheight=100;"//缩放系数
                         "for(i=0;i <document.images.length;i++){"
                         "myimg = document.images[i];"
                         "if(myimg.width > maxwidth){"
                         "oldwidth = myimg.width;"
                         "myimg.width = maxwidth;"
                         "myimg.height = myimg.height* (maxwidth/oldwidth);"//  myimg.height* (maxwidth/oldwidth)
                         "}"
                         "}"
                         "}\";"
                         "document.getElementsByTagName('head')[0].appendChild(script);",ImageSize-20];
    
    [webView stringByEvaluatingJavaScriptFromString:
     javaStr];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}

//动态计算webview高度
+(void)setWebViewHeight:(UIWebView*)webView defaultHeight :(CGFloat)defaultHeight
{

    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGRect frame = webView.frame;
    webView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
    
}

//根据时间错求时间yyyy-MM-dd HH:mm
+(NSString*)getDate:(NSString*)timersp
{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:[timersp doubleValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *date = [formatter stringFromDate:d];
    
    return date;
}

//根据时间错求时间yyyy-MM-dd
+(NSString*)getDateNYR:(NSString*)timersp
{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:[timersp doubleValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:d];
    
    return date;
}
#pragma mark - 行间距
+(void)setLabel:(UILabel *)label string:(NSString *)str withLineSpacing:(CGFloat)space{
    
    NSMutableAttributedString * mas=[[NSMutableAttributedString alloc]init];
    
    NSMutableParagraphStyle * style=[NSMutableParagraphStyle new];
    
    style.alignment=NSTextAlignmentLeft;
    
    style.lineSpacing=space;
    
    style.lineBreakMode =NSLineBreakByTruncatingTail;
    
    style.paragraphSpacing=space;
    
    NSDictionary * attributesDict=@{
                                    NSFontAttributeName:[UIFont systemFontOfSize:12],		//label.text字体大小
                                    NSForegroundColorAttributeName:[UIColor blackColor],	//label.textColor 字体颜色
                                    NSParagraphStyleAttributeName:style
                                    };
    
    NSAttributedString *as=[[NSAttributedString alloc]initWithString:str attributes:attributesDict];
    
    [mas appendAttributedString:as];
    
    [label setAttributedText:mas];
}

/*
 通过正则表达式匹配字符串
 */
+(NSMutableArray*)getStringRangeByRegstring:(NSString *)Regstring searchString:(NSString*)searchString
{
    //定义一个正则表达式
    NSRegularExpression *Regular = [[NSRegularExpression alloc]initWithPattern:Regstring options:NSRegularExpressionCaseInsensitive error:nil];
    //匹配字符串
    if (searchString==nil||[searchString isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    NSArray *matchStr = [Regular matchesInString:searchString options:0 range:NSMakeRange(0, [searchString length])];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSTextCheckingResult *result in matchStr)
    {
        [arr addObject: result];
    }
    
    //返回一个nsrang 数组
    return arr;
    
}

//给金额每3位插入一个逗号
+(NSString *)countNumAndChangeformat:(NSString *)AmountStr
{
    
    NSArray *Separatedstr = [AmountStr componentsSeparatedByString:@"."];
    NSString *num = Separatedstr[0];

    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3)
    {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    
    newstring = [NSMutableString stringWithFormat:@"%@.%@",newstring,Separatedstr[1]];
    
    return newstring;
}

//限制textfield只能输入数字
+(BOOL)textFieldInputNum :(NSString*)string
{
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9'))//数据格式正确
        {
            return YES;
        }else
        {
            return NO;
        }
    }
    else
    {
        return YES;
    }
}

//判断银行卡号是否有效
+(BOOL)isValidCreditNumber:(NSString *)cardNo
{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    if (cardNoLength==0) {
        
        return NO;
    }
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

//用颜色值创建UIimage
+(UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


#pragma mark 求字符串长度
+(int)charNumber:(NSString*)strtemp {
    
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

#pragma mark 判段是否有中文字符串
+(BOOL)IsChinese:(NSString *)str
{
    
   for(int i=0; i< [str length];i++)
   {
    int a = [str characterAtIndex:i];
    if( a > 0x4e00 && a < 0x9fff)
    {

        return YES;
       
    }
    }
    return NO;
}

#pragma mark 设置文本属性
+(void)setTextAttribute:(NSDictionary*)Attribute regtag:(NSString *)regtag label:(UILabel*)label
{
    
    if (label.text!=nil)
    {
     
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:label.text];
        
        //返回匹配到的字符串
        NSArray *reguar = [Helper getStringRangeByRegstring:regtag searchString:label.text];
        
        for (NSTextCheckingResult *CheckingResult in reguar)
        {
            [str addAttributes:Attribute range:CheckingResult.range];
            label.attributedText =  str;
            
        }
        
    }
    
}

#pragma mark 删除导航器下面的线
+(void)removeLine:(UINavigationBar*)navigationBar
{
    
    if ([navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}
@end
