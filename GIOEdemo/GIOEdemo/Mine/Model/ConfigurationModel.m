//
//  ConfigurationModel.m
//  GIOEdemo
//
//  Created by BeyondChao on 2020/5/12.
//  Copyright © 2020 M. All rights reserved.
//

#import "ConfigurationModel.h"

@interface ConfigurationModel () <NSCoding>

@end

@implementation ConfigurationModel

- (void)encodeWithCoder:(NSCoder *)coder {
    if (coder) {
        [coder encodeObject:self.userID forKey:@"userID"];
        [coder encodeDouble:self.flushInterval forKey:@"flushInterval"];
        [coder encodeDouble:self.sessionInterval forKey:@"sessionInterval"];
    }
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.userID = [coder decodeObjectForKey:@"userID"];
        self.flushInterval = [coder decodeDoubleForKey:@"flushInterval"];
        self.sessionInterval = [coder decodeDoubleForKey:@"sessionInterval"];
    }
    return self;
}

+ (void)saveConfiguration:(ConfigurationModel *)config {
    
    if (!config) {
        return;
    }
    
    [NSKeyedArchiver archiveRootObject:config toFile:[self persistFile]];
}

+ (ConfigurationModel *)readConfigration {
    ConfigurationModel *config = [NSKeyedUnarchiver unarchiveObjectWithFile:[self persistFile]];
    return config;
}

+ (NSString *)persistFile {
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [document stringByAppendingPathComponent:@"config.data"];
    return filePath;
}

@end
