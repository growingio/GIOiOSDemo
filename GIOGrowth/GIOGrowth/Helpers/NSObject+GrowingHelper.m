//
//  NSObject+GrowingHelpers.m
//  GIOGrowth
//
//  Created by GrowingIO on 2019/10/16.
//  Copyright © 2019 M. All rights reserved.
//

#import "NSObject+GrowingHelper.h"
#import <objc/runtime.h>

@implementation NSObject (GrowingHelper)

- (NSArray *)growingPushHelper_getAllProperties {
    
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++) {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray.copy;

}


@end
