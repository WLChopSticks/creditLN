//
//  AppDelegate.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/28.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "AppDelegate.h"
#import "WLLogInViewController.h"
#import "WLNewFeatureViewController.h"
#import "WLProfileViewController.h"
#import "WLProfileCreditViewController.h"
#import "WLUserFocusViewController.h"
#import "WLExhibitonViewController.h"
#import "WLBaseNavigationViewController.h"
#import "WLBaseTabBarViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]init];
    WLExhibitonViewController *exhibitionVC = [[WLExhibitonViewController alloc]init];
//    exhibitionVC.title = @"信用辽宁(公众版)";
    WLBaseNavigationViewController *nav1 = [[WLBaseNavigationViewController alloc]initWithRootViewController:exhibitionVC];
    nav1.tabBarItem  = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"home"] tag:0];
    
    WLUserFocusViewController *userFocusVC = [[WLUserFocusViewController alloc]init];
    userFocusVC.title = @"用户关注";
    WLBaseNavigationViewController *nav2 = [[WLBaseNavigationViewController alloc]initWithRootViewController:userFocusVC];
    nav2.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"用户关注" image:[UIImage imageNamed:@"focus"] tag:1];
    
    WLProfileCreditViewController *profileVC = [[WLProfileCreditViewController alloc]init];
    profileVC.title = @"个人信用";
    WLBaseNavigationViewController *nav3 = [[WLBaseNavigationViewController alloc]initWithRootViewController:profileVC];
    nav3.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"个人信用" image:[UIImage imageNamed:@"user_creidt"] tag:2];
    
    WLProfileViewController *profileCreditVC = [[WLProfileViewController alloc]init];
    profileCreditVC.title = @"个人中心";
    WLBaseNavigationViewController *nav4 = [[WLBaseNavigationViewController alloc]initWithRootViewController:profileCreditVC];
    nav4.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"个人中心" image:[UIImage imageNamed:@"profile"] tag:3];
    
    WLBaseTabBarViewController *tabVC = [[WLBaseTabBarViewController alloc]init];
    tabVC.viewControllers = @[nav1, nav2, nav3, nav4];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"old_enter"]boolValue] == YES)
    {
        self.window.rootViewController = tabVC;
        [self.window makeKeyAndVisible];
    }else
    {
        WLNewFeatureViewController *newFeatureVC = [[WLNewFeatureViewController alloc]init];
        newFeatureVC.rootVC = tabVC;
        self.window.rootViewController = newFeatureVC;
        [self.window makeKeyWindow];
    }
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
