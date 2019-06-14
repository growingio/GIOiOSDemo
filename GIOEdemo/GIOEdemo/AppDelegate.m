//
//  AppDelegate.m
//  GrowingIOTest
//
//  Created by GIO-baitianyu on 14/03/2018.
//  Copyright © 2018 GrowingIO. All rights reserved.
//

#import "AppDelegate.h"
#import "Growing.h"
#import <GrowingTouchKit/GrowingTouchKit.h>
//#import <GrowingTouchKit/GrowingTouch.h>

@interface AppDelegate () <GrowingTouchEventPopupDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Growing startWithAccountId:@"97fd6815651f25fb"];
    [Growing setEnableLog:YES];
    [Growing setDataHost:@"https://demo1gta.growingio.com"];
    [Growing setReportHost:@"https://demo1gta.growingio.com"];
    [Growing setTrackerHost:@"https://apifwd.growingio.com"];
    [Growing setGtaHost:@"https://demo1gta.growingio.com"];
    [Growing setWsHost:@"wss://demo1gta.growingio.com"];
    
    [Growing setEnableLog:NO];
    [Growing registerDeeplinkHandler:^(NSDictionary *params, NSError *error) {
        NSLog(@"params %@",params);
    }];
    [Growing registerRealtimeReportHandler:^(NSDictionary *eventObject) {
        NSLog(@"=registerRealtimeReportHandler> %@", eventObject);
    }];
    [GrowingTouch setEventPopupDelegate:self];
    [GrowingTouch setDebugEnable:YES];
    [GrowingTouch setEventPopupEnable:YES];
    [GrowingTouch start];

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
//
//- (void)applicationWillResignActive:(UIApplication *)application {
//    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//    NSLog(@"App Will Resign Actvie");
//
//    if (application.applicationState == UIApplicationStateInactive) {
//        NSLog(@"App is not Actvie now");
//    }
//}
//
//
//- (void)applicationDidEnterBackground:(UIApplication *)application {
//    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    NSLog(@"App did enter Background");
//}
//
//
//- (void)applicationWillEnterForeground:(UIApplication *)application {
//    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    NSLog(@"App will enter Background");
//}
//
//
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    NSLog(@"App did become Active");
//}
//
//
//- (void)applicationWillTerminate:(UIApplication *)application {
//    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    NSLog(@"App will Terminate");
//}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([Growing handleUrl:url])
    {
        return YES;
    }
    return NO;
}


@end
