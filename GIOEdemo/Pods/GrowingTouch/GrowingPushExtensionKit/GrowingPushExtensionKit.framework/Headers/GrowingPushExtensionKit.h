//
//  GrowingPushExtensionKit.h
//  GrowingPushExtensionKit
//
//  Created by GrowingIO on 2019/5/30.
//  Copyright © 2019 GrowingIO. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UNNotificationRequest;

@interface GrowingPushExtensionKit : NSObject

//  pushExtensionKit 的版本号
+ (NSString*)pushExtensionKitVersion;
//  事件上报接口
+ (void)sendNotificationRequest:(UNNotificationRequest *)request withCompletionHandler:(void (^)(id response))completionHandler;

@end

