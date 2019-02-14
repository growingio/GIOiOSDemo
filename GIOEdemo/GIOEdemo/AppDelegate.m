//
//  AppDelegate.m
//  GrowingIOTest
//
//  Created by GIO-baitianyu on 14/03/2018.
//  Copyright © 2018 GrowingIO. All rights reserved.
//

#import "AppDelegate.h"
#import "Growing.h"
//#import <GrowingTouchKit/GrowingTouch.h>

@interface AppDelegate ()
//<GrowingTouchEventPopupDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Growing startWithAccountId:@"0a1b4118dd954ec3bcc69da5138bdb96"];
    [Growing setEnableLog:YES];
//    [Growing setDataHost:@"http://master-www.growingio.com"];
//    [Growing setGtaHost:@"http://master-gta.growingio.com"];
 
//    [Growing setUserId:@"GIOXiaoYing"];
//    [GrowingTouch setEventPopupDelegate:self];
//    [GrowingTouch setDebugEnable:YES];
//    [GrowingTouch setEventPopupEnable:YES];
//    [GrowingTouch setServerHost:@"http://k8s-marketing-automation-messages.growingio.com"];
//    [GrowingTouch start];
    return YES;
}

- (void)onEventPopupLoadSuccess:(NSString *)trackEventId eventType:(NSString *)eventType {
    NSLog(@"%s trackEventId = %@, eventType = %@", __func__, trackEventId, eventType);
}

- (void)onEventPopupLoadFailed:(NSString *)trackEventId eventType:(NSString *)eventType withError:(NSError *)error {
    NSLog(@"%s trackEventId = %@, eventType = %@", __func__, trackEventId, eventType);
}

- (BOOL)onClickedEventPopup:(NSString *)trackEventId eventType:(NSString *)eventType openUrl:(NSString *)openUrl {
    NSLog(@"%s trackEventId = %@, eventType = %@", __func__, trackEventId, eventType);
    return NO;
}

- (void)onCancelEventPopup:(NSString *)trackEventId eventType:(NSString *)eventType {
    NSLog(@"%s trackEventId = %@, eventType = %@", __func__, trackEventId, eventType);
}

- (void)onTrackEventTimeout:(NSString *)trackEventId eventType:(NSString *)eventType {
    NSLog(@"%s trackEventId = %@, eventType = %@", __func__, trackEventId, eventType);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSLog(@"App Will Resign Actvie");
    
    if (application.applicationState == UIApplicationStateInactive) {
        NSLog(@"App is not Actvie now");
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"App did enter Background");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@"App will enter Background");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"App did become Active");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"App will Terminate");
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([Growing handleUrl:url])
    {
        return YES;
    }
    return NO;
}

@end
