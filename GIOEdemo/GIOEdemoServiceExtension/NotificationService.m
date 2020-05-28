//
//  NotificationService.m
//  GIOEdemoServiceExtension
//
//  Created by GrowingIO on 2019/6/17.
//  Copyright © 2019 M. All rights reserved.
//

#import "NotificationService.h"
#import <GrowingPushExtensionKit/GrowingPushExtensionKit.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    
    [GrowingPushExtensionKit handleNotificationRequest:request
                                        withCompletion:^(NSArray<UNNotificationAttachment *> * _Nullable attachments, NSArray<NSError *> * _Nullable errors) {
        NSLog(@"执行成功");
        NSLog(@"回调信息是 attachments = %@, error = %@", attachments, errors);
        
        // Modify the notification content here...
        self.bestAttemptContent.attachments = attachments;
        // self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [PushExtensionKit集成成功]", self.bestAttemptContent.title];
        
        self.contentHandler(self.bestAttemptContent);
    }];

}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
