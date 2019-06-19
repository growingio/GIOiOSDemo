//
//  Growing+PushKit.h
//  GrowingPushKit
//
//  Created by GrowingIO on 2019/5/21.
//  Copyright © 2019 GrowingIO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GrowingCoreKit/GrowingCoreKit.h>

#ifndef __cplusplus
@import Foundation;
#endif

@interface Growing (PushKit)

//  pushKit 的版本
+ (NSString*)pushKitVersion;

//  外部传入deviceToken
+ (void)registerDeviceToken:(NSData *)deviceToken;

//  开启关闭推送
+ (void)unregisterForRemoteNotifications;

//  点击消息跳转用户自定义
+ (void)clickMessageWithCompletionHandler:(void (^)(NSDictionary *params))completionHandler;

@end

