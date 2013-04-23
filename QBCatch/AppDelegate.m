//
//  AppDelegate.m
//  QBCatch
//
//  Created by ello on 13-4-16.
//  Copyright (c) 2013年 ello. All rights reserved.
//

#import "AppDelegate.h"
#import "ListViewController.h"
#import "common.h"
@implementation AppDelegate

- (void)dealloc
{
    [_window release];
//    [_homeViewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
//    [[NSBundle mainBundle] loadNibNamed:@"TabBarController" owner:self options:nil];
    
    ListViewController *homeViewController = [[[ListViewController alloc] initWithServiceID:GET_8H_HOT] autorelease];
    homeViewController.title = @"糗事百科-精华";
    UINavigationController *homeNavigationController = [[[UINavigationController alloc] initWithRootViewController:homeViewController] autorelease];
    
    ListViewController *truthViewController = [[[ListViewController alloc] initWithServiceID:GET_TRUTH] autorelease];
    truthViewController.title = @"有图有真相";
    UINavigationController *truthNavigationController = [[[UINavigationController alloc] initWithRootViewController:truthViewController] autorelease];
    
    ListViewController *traveltimeViewController = [[[ListViewController alloc] initWithServiceID:GET_TRAVELTIME] autorelease];
    traveltimeViewController.title = @"穿越";
    UINavigationController *traveltimeNavigationController = [[[UINavigationController alloc] initWithRootViewController:traveltimeViewController] autorelease];
    
    NSArray *array = [NSArray arrayWithObjects:homeNavigationController, truthNavigationController, traveltimeNavigationController, nil];
    UITabBarController *rootController = [[[UITabBarController alloc] init] autorelease];
    [rootController setViewControllers:array];
    self.window.rootViewController = rootController;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
