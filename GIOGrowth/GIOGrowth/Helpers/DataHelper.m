//
// Created by xiangyang on 2019/1/10.
// Copyright (c) 2019 com.growingio. All rights reserved.
//

#import "DataHelper.h"

static NSString *const GTOUCH_STATE = @"GIO_TOUCH_GROWTH_gtouch_state";

@implementation DataHelper

+ (void)saveGTouchEnableState:(BOOL)enable {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:enable forKey:GTOUCH_STATE];
    [userDefaults synchronize];
}

+ (BOOL)getGTouchEnableState {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL enable = [[userDefaults objectForKey:GTOUCH_STATE] boolValue];
    return enable;
}

@end
