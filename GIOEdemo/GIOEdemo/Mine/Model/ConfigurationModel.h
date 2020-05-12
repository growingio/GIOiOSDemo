//
//  ConfigurationModel.h
//  GIOEdemo
//
//  Created by BeyondChao on 2020/5/12.
//  Copyright © 2020 M. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConfigurationModel : NSObject

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, assign) NSTimeInterval flushInterval;
@property (nonatomic, assign) NSTimeInterval sessionInterval;

+ (ConfigurationModel *)readConfigration;
+ (void)saveConfiguration:(ConfigurationModel *)config;

@end

NS_ASSUME_NONNULL_END
