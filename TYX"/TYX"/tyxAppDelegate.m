//
//  tyxAppDelegate.m
//  TYX"
//
//  Created by LISComputer on 12.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tyxAppDelegate.h"

@implementation tyxAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    /*
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers objectAtIndex:1];
    splitViewController.delegate = (id)navigationController.topViewController;
     */
    //splitViewController.delegate = [splitViewController.viewControllers lastObject];
    
    // Use the following code when a navigation controller is connected to a low level splitview controller(the navigation controller is put between the low level splitview controller and the higher level view which links it) in order to modal a splitview controller from a higher level view. Moreover the navigation controller should be the initial view.
    
    UIViewController *tyxloginViewController= (UINavigationController *) self.window.rootViewController;    
    UINavigationController *navigationController= tyxloginViewController.navigationController;
    UISplitViewController *splitviewController = (UISplitViewController *) [navigationController.viewControllers objectAtIndex:0];
    splitviewController.delegate =(id)[splitviewController.viewControllers objectAtIndex:1];
     
    //UINavigationController *secnavigationController = [splitviewController.viewControllers objectAtIndex:1];
    //splitviewController.delegate = (id)secnavigationController.topViewController;
    
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
