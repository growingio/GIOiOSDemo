//
//  MainViewController.m
//  TouchDemo
//
//  Created by xiangyang on 2018/12/21.
//  Copyright © 2018 com.growingio. All rights reserved.
//

#import "MainViewController.h"
#import "DataHelper.h"
#import "TestPageViewController.h"
#import <GrowingCoreKit/GrowingCoreKit.h>
#import <GrowingTouchCoreKit/GrowingTouch.h>
#import "BannerTestViewController.h"
#import <WebKit/WebKit.h>

@interface MainViewController ()<GrowingTouchEventPopupDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //  触达启动配置
//    [GrowingTouch setEventPopupDelegate:self];
//    [GrowingTouch setDebugEnable:YES];
  //  [GrowingTouch setEventPopupEnable:[DataHelper getGTouchEnableState]];
    //    [GrowingTouch setServerHost:@"http://k8s-marketing-automation-messages.growingio.com"];
//    [GrowingTouch start];
}

- (IBAction)clearDataButtonOnClick:(UIButton *)sender {
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *gtouchCache = [cachePath stringByAppendingPathComponent:@"com.growingio.GTouch.Cache"];
    [fileManage removeItemAtPath:gtouchCache error:nil];

    NSString *dbPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    dbPath = [[NSString alloc] initWithString:[dbPath stringByAppendingPathComponent:@"GrowingioTouch.db"]];
    [fileManage removeItemAtPath:dbPath error:nil];
    exit(0);
}

- (IBAction)setUserZhangsanButtonOnClick:(UIButton *)sender {
    [Growing setUserId:@"zhangsan"];
}

- (IBAction)setUserLisiButtonOnClick:(UIButton *)sender {
    [Growing setUserId:@"lisi"];
}

- (IBAction)clearUserButtonOnClick:(UIButton *)sender {
    [Growing clearUserId];
}

- (IBAction)trackEventButtonOnClick:(UIButton *)sender {
    [Growing track:@"touch1"];
}

- (IBAction)disableGTouchButtonOnClick:(UIButton *)sender {
    [DataHelper saveGTouchEnableState:NO];
    [GrowingTouch setEventPopupEnable:NO];
    NSLog(@"GTouchEnableState = %d", [DataHelper getGTouchEnableState]);
}

- (IBAction)enableGTouchButtonOnClick:(UIButton *)sender {
    [DataHelper saveGTouchEnableState:YES];
    [GrowingTouch enableEventPopupAndGenerateAppOpenEvent];
}

- (IBAction)openPageButtonOnClick:(UIButton *)sender {
    [self.navigationController pushViewController:[BannerTestViewController new] animated:YES];
}


#pragma mark - GrowingTouchEventPopupDelegate
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

@end
