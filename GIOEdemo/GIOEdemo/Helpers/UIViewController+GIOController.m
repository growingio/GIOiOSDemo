//
//  UIViewController+GIOController.m
//  GIOdemo
//
//  Created by GrowingIO on 2019/1/14.
//  Copyright © 2019年 GIO. All rights reserved.
//

#import "UIViewController+GIOController.h"
#import <objc/runtime.h>
@implementation UIViewController (GIOController)
+ (void)load{
    [super load];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gio_swizzleMethod([self class], @selector(viewDidLoad), @selector(GIOViewDidLoad));
    });
}

void gio_swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector){
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)GIOViewDidLoad{
    [self GIOViewDidLoad];  //由于方法已经被交换,这里调用的实际上是viewDidLoad方法
    
    NSInteger index = (NSInteger)[[self.navigationController viewControllers] indexOfObject:self];
    if (index > 0) {
        // 自定义导航栏左侧按钮
        UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        leftBtn.frame = CGRectMake(0, 0 , 30, 20);
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(leftOnTap) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.alpha = 0.7 ;
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

-(void)leftOnTap{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
