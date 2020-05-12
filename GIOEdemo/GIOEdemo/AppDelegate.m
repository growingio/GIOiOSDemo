//
//  AppDelegate.m
//  GrowingIOTest
//
//  Created by GIO-baitianyu on 14/03/2018.
//  Copyright © 2018 GrowingIO. All rights reserved.
//

#import "AppDelegate.h"
#import "Growing.h"
#import <GrowingTouchCoreKit/GrowingTouchCoreKit.h>
#import <UserNotifications/UserNotifications.h>
#import "NSObject+GrowingHelper.h"
#import "ConfigurationModel.h"

@interface AppDelegate () <GrowingTouchEventPopupDelegate,UNUserNotificationCenterDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *location;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Growing setUploadExceptionEnable:NO];
    [Growing startWithAccountId:@"97fd6815651f25fb"];
 //   [Growing setEnableLog:YES];
    
    self.location = [[CLLocationManager alloc] init];
    self.location.delegate = self;
    [self.location requestWhenInUseAuthorization];
    
    //  GPush
    [self registerRemoteNotification];
//    [Growing setDataHost:@"https://demo1gta.growingio.com"];
//    [Growing setReportHost:@"https://demo1gta.growingio.com"];
//    [Growing setTrackerHost:@"https://apifwd.growingio.com"];
//    [Growing setGtaHost:@"https://demo1gta.growingio.com"];
//    [Growing setWsHost:@"wss://demo1gta.growingio.com"];
    
    [Growing registerDeeplinkHandler:^(NSDictionary *params, NSTimeInterval processTime, NSError *error) {
        
        //  处理 deeplink 的页面回调
        if (!error) {
            
            NSString *deeplink = params[@"+deeplink_mechanism"];
            NSString *jumpTo = params[@"jumpTo"];
            if ([deeplink isEqualToString:@"universal_link"] && jumpTo.length) {
                //  跳转到指定的页面
                Class classJump = NSClassFromString(jumpTo);
                if (classJump) {
                    UIViewController *vc = (UIViewController *)[classJump new];
                    if ([vc isKindOfClass:UIViewController.class]) {
                        NSArray *inAppPagePropertyArray = [vc growingPushHelper_getAllProperties];
                        for (NSString *key in params) {
                            if ([inAppPagePropertyArray containsObject:key]) {
                                [vc setValue:params[key] forKey:key];
                            }
                        }
                        vc.hidesBottomBarWhenPushed = YES ;
                        UINavigationController *nav =  [self findNavigationController];
                        [nav pushViewController:vc animated:YES];
                    }
                }
            }
        }
        
   //     NSLog(@"回调链接params %@",params);
    }];
    [Growing registerRealtimeReportHandler:^(NSDictionary *eventObject) {
  //      NSLog(@"=registerRealtimeReportHandler> %@", eventObject);
    }];
    //GTouch
    [GrowingTouch setEventPopupDelegate:self];
//    [GrowingTouch setDebugEnable:YES];
    [GrowingTouch setEventPopupEnable:YES];
    [GrowingTouch start];

    //  推送的自定义协议的跳转逻辑
    [GrowingTouch clickMessageWithCompletionHandler:^(NSDictionary *params) {
        NSLog(@"欢迎使用GIO自定义协议的跳转逻辑，不需要可以不用此方法");
        
    }];
    
    ConfigurationModel *configModol = [ConfigurationModel readConfigration];
    NSString *user = configModol.userID ?: @"zhangsaniOS";
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    NSString *name = [user stringByAppendingString:systemVersion];
    NSLog(@"设置的登陆用户ID是 %@", name);

    [Growing setUserId:name];
    [Growing setFlushInterval:configModol.flushInterval ?: 15];
    [Growing setSessionInterval:configModol.sessionInterval ?: 30];
    [Growing setPeopleVariable:@{@"CreateAt":@"20191219"}];
    
    return YES;
}


- (UINavigationController *)findNavigationController {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    if ([window.rootViewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *) window.rootViewController;
    } else if ([window.rootViewController isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectVc = [((UITabBarController *) window.rootViewController) selectedViewController];
        if ([selectVc isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *) selectVc;
        }
    }
    return nil;
}

/** 注册 APNs */
- (void)registerRemoteNotification {
    if (@available(iOS 10,*)) {
        //  10以后的注册方式
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        //监听回调事件
        //iOS 10 使用以下方法注册，才能得到授权，注册通知以后，会自动注册 deviceToken，如果获取不到 deviceToken，Xcode8下要注意开启 Capability->Push Notification。
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound )
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (granted) {
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          [[UIApplication sharedApplication] registerForRemoteNotifications];
                                      });
                                  }
                              }];
        
    } else if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
}

#pragma mark -GrowingTouchEventPopupDelegate
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

/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [GrowingTouch registerDeviceToken:deviceToken];
    NSMutableString *deviceTokenString = [NSMutableString string];
    const char *bytes = deviceToken.bytes;
    NSInteger count = deviceToken.length;
    for (NSInteger i = 0; i < count; i++) {
        [deviceTokenString appendFormat:@"%02x", bytes[i] & 0xff];
    }

    NSLog(@"推送Token 字符串：%@", deviceTokenString);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"远程通知" message:@"点击一下呗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}


#pragma mark - UNUserNotificationCenterDelegate
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler NS_AVAILABLE_IOS(7_0);{
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    NSDictionary *aps = notification.request.content.userInfo;
    NSLog(@"aps = %@", aps);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"远程通知1"
                                                                   message:@"点击一下呗"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([Growing handleUrl:url])
    {
        return YES;
    }
    return NO;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    [Growing handleUrl:userActivity.webpageURL];
       return YES;
}

@end
