//
//  AppDelegate.m
//  TSMedicine
//
//  Created by EWT on 15/6/8.
//  Copyright (c) 2015年 ewt. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<UIAlertViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [YYTabBarViewController initIalizeTab];
    
    
    [self checkVersion];
    
    
   
    return YES;
}

-(void)checkVersion
{
    
    NSString *URL = @"http://itunes.apple.com/lookup?id=825481902";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *receveData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *results = [[NSString alloc] initWithBytes:[receveData bytes] length:[receveData length] encoding:NSUTF8StringEncoding];
    NSDictionary *dataDic = [results objectFromJSONString];
    
//    NSLog(@"dataDic == %@",dataDic);
    
    NSArray *infoArr = [dataDic objectForKey:@"results"];
    
    if ([infoArr count]) {
        
        NSDictionary *releaseInfo = [infoArr objectAtIndex:0];
        
//        NSLog(@"releaseInfo == %@",releaseInfo);
        
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        NSLog(@"lastVersion == %@",lastVersion);
        
        if (![lastVersion isEqualToString:current_version]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新提示" message:@"检测到有新的版本可以更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
            [alert show];
            
        }
    }

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"buttonIndex == %d",buttonIndex);
    if (buttonIndex == 1) {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/app/id825481902"];
        [[UIApplication sharedApplication] openURL:url];
        
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
