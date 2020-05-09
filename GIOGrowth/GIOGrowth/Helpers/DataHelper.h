//
// Created by xiangyang on 2019/1/10.
// Copyright (c) 2019 com.growingio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataHelper : NSObject
+ (void)saveGTouchEnableState:(BOOL)enable;

+ (BOOL)getGTouchEnableState;
@end