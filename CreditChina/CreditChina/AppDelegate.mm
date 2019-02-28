//
//  AppDelegate.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/28.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "AppDelegate.h"
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
    UITabBarItem *homeItem = [[UITabBarItem alloc]init];
    homeItem.title = @"首页";
    homeItem.image = [[UIImage imageNamed:@"home_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeItem.selectedImage = [[UIImage imageNamed:@"home.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav1.tabBarItem = homeItem;
    
    WLUserFocusViewController *userFocusVC = [[WLUserFocusViewController alloc]init];
    userFocusVC.title = @"用户关注";
    WLBaseNavigationViewController *nav2 = [[WLBaseNavigationViewController alloc]initWithRootViewController:userFocusVC];
    UITabBarItem *focusItem = [[UITabBarItem alloc]init];
    focusItem.title = @"用户关注";
    focusItem.image = [[UIImage imageNamed:@"focus_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    focusItem.selectedImage = [[UIImage imageNamed:@"focus.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav2.tabBarItem = focusItem;
    
    WLProfileCreditViewController *profileVC = [[WLProfileCreditViewController alloc]init];
    profileVC.title = @"个人信用";
    WLBaseNavigationViewController *nav3 = [[WLBaseNavigationViewController alloc]initWithRootViewController:profileVC];
    UITabBarItem *creditItem = [[UITabBarItem alloc]init];
    creditItem.title = @"个人信用";
    creditItem.image = [[UIImage imageNamed:@"user_credit_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    creditItem.selectedImage = [[UIImage imageNamed:@"user_credit.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav3.tabBarItem = creditItem;
    
    WLProfileViewController *profileCreditVC = [[WLProfileViewController alloc]init];
    profileCreditVC.title = @"个人中心";
    WLBaseNavigationViewController *nav4 = [[WLBaseNavigationViewController alloc]initWithRootViewController:profileCreditVC];
    UITabBarItem *profileItem = [[UITabBarItem alloc]init];
    profileItem.title = @"个人中心";
    profileItem.image = [[UIImage imageNamed:@"profile_normal.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    profileItem.selectedImage = [[UIImage imageNamed:@"profile.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav4.tabBarItem = profileItem;
    
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
