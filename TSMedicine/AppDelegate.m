//
//  AppDelegate.m
//  TSMedicine
//
//  Created by EWT on 15/6/8.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<UIAlertViewDelegate>

@property (nonatomic,copy) NSString *trackViewURL;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [YYTabBarViewController initIalizeTab];
    
    [self loadVersionData];
    
    return YES;
}

-(void)loadVersionData
{
    YYHttpRequest *rq = [[YYHttpRequest alloc] init];
    NSDictionary *parameters = @{@"appid":@"2",@"type":@"1"};
    
    [rq GETURLString:@"http://app.aixinland.cn/api/version/Get" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObj) {
//         NSLog(@"responseObj === %@",responseObj);
        
        if ([responseObj[@"status"] isEqualToString:@"Success"]) {
            
            NSDictionary *dataDic = responseObj[@"data"];
            
            _trackViewURL = [[NSString alloc] initWithString:[dataDic objectForKey:@"fileUrl"]];
            
            NSArray *arr = [_trackViewURL componentsSeparatedByString:@"id"];
//            NSLog(@"arr == %@",arr);
            
            NSString *appleId = [NSString stringWithFormat:@"%@",[arr lastObject]];
            [self checkVersionWithAppleId:appleId];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error == %@",error);
    }];
    
}
-(void)checkVersionWithAppleId:(NSString *)appleId
{
    NSString *URL = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appleId];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *receveData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *results = [[NSString alloc] initWithBytes:[receveData bytes] length:[receveData length] encoding:NSUTF8StringEncoding];
    NSDictionary *dataDic = [results objectFromJSONString];
    
    NSArray *infoArr = [dataDic objectForKey:@"results"];
    
    if ([infoArr count]) {
        
        NSDictionary *releaseInfo = [infoArr objectAtIndex:0];
        
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        NSLog(@"lastVersion == %@",lastVersion);
        
//        _trackViewURL = [[NSString alloc] initWithString:[releaseInfo objectForKey:@"trackViewUrl"]];
//        NSLog(@"trackViewURL == %@",_trackViewURL);
        
        if (![lastVersion isEqualToString:current_version]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新提示" message:@"检测到有新的版本可以更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
            [alert show];
            
        }
    }

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex == 1) {
        
        if (_trackViewURL) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_trackViewURL]];
        }
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
