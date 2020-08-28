//
// Created by xiangyang on 2018/12/11.
// Copyright (c) 2018 growingio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GrowingTouchBannerView.h"

@class GrowingTouchBannerData, GrowingTouchBannerItem, GrowingPopupWindowEvent;

@protocol GrowingTouchEventPopupDelegate;


@interface GrowingTouch : NSObject

#pragma mark -GrowingTouchKit SDK
/**
 * 启动GrowingTouch
 */
+ (void)start;

/**
 * 设置触达SDK开关
 *
 * @param enable 开关触达SDK，YES开启，NO关闭
 */
+ (void)setEventPopupEnable:(BOOL)enable;

/**
 * 打开触达SDK并触发AppOpen事件。
 * 例如您担心触达SDK在APP启动的Logo页或者闪屏页显示弹窗，您可以选择在初始化时选择关闭弹窗，然后在您APP的内容页打开时再打开触达开关。但是单纯调用`[GrowingTouch setEventPopupEnable:YES];`只会打开触达SDK开关，并不会触发AppOpen事件。如果调用该API则会打开触达开关，同时触发一个AppOpen事件。
 */
+ (void)enableEventPopupAndGenerateAppOpenEvent;

/**
 * 触达SDK是否打开
 *
 * @return YES开启，NO关闭
 */
+ (BOOL)isEventPopupEnabled;

/**
 * 埋点事件的产生到触达弹窗完全显示的超时时间，如网络情况可能会影响到触达弹窗的加载时间，或者两个弹窗埋点事件先后触发，前面一个弹窗的显示时间过长导致后面的弹窗事件超时等等。
 *
 * @param millis 0<=有效值<=100000, 单位ms。
 */
+ (void)setEventPopupShowTimeout:(long long)millis;

/**
 * 获取埋点事件的产生到触达弹窗完全显示的超时时间
 *
 * @return 超时时间，单位ms。
 */
+ (long long)getEventPopupShowTimeoutMillis;

/**
 * 通过监听获取事件和参数，您可以根据事件和参数以及您的业务场景执行相关的交互。
 *
 * @param delegate 事件代理
 */
+ (void)setEventPopupDelegate:(id <GrowingTouchEventPopupDelegate>)delegate;

/**
 * 触达弹窗是否正在显示
 *
 * @return YES显示，NO不显示
 */
+ (BOOL)isEventPopupShowing;

/**
 * 获取SDK版本号
 *
 * @return 版本号，如1.0.0
 */
+ (NSString *)sdkVersion;

/**
 * 查看GTouch日志，能够查看GrowingTouch打印的日志
 *
 * @param enable YES显示日志，NO不显示日志
 */
+ (void)setDebugEnable:(BOOL)enable;

/**
 * 查看GTouch日志打印状态
 *
 * @return YES显示日志，NO不显示日志
 */
+ (BOOL)isDebugEnabled;

+ (void)setServerHost:(NSString *)host;

/**
 * 拉取所有的弹窗数据
 *
 * @param completion 完成回调，包含弹窗数组和错误信息
 */
+ (void)loadPopupWindowEventsCompletion:(void (^)(NSArray <GrowingPopupWindowEvent *> * popups, NSError *error))completion;

#pragma mark - GrowingBanner
/**
 自渲染的初始化方法

 @param bannerKey banner的唯一标识
 @param bannerData 请求成功回调数据
 @param failure 请求失败消息
 */
+ (void)growingTouchBannerDataTaskBannerKey:(NSString*) bannerKey success:(void(^)(GrowingTouchBannerData *)) bannerData failure:(void(^)(NSError*))failure;

/**
 请用 “bindItemDataToClickView:selectCompleted:” 方法替换视图与item的绑定
 
 @param bannerKey banner的唯一标识
 @param bannerView item对应的视图
 @param item banner的单个数据item
 @param completedBlock 点击的回调，返回跳转参数
 */
+ (void)growingTouchBannerDataTaskBannerKey:(NSString*) bannerKey bannerView:(UIView *)bannerView bannerItem:(GrowingTouchBannerItem *)item selectCompleted:(void(^)(NSString *openUrl, NSError *error)) completedBlock NS_DEPRECATED_IOS(2_0, 2_0, "Use bindItemDataToClickView:selectCompleted: instead.");


#pragma mark - GrowingPushKit SDK
/**
 设置推送设备的deviceToken

 @param deviceToken 设备的deviceToken
 */
+ (void)registerDeviceToken:(NSData *)deviceToken;

/**
 关闭推送
 */
+ (void)unregisterForRemoteNotifications;

/**
 推送消息点击跳转自定义处理

 @param completionHandler 推送消息点击回调
 */
+ (void)clickMessageWithCompletionHandler:(void (^)(NSDictionary *params))completionHandler;

/**
 即将弃用！请用 GrowingCoreKit.h 中的 “setUploadExceptionEnable:” 方法代替
 
 @param uploadExceptionEnable 是否开启触达sdk的crash监控上报，请在 startWithAccountId: 或 startWithAccountId: withSampling: 接口之前设置。
 */
+ (void)setUploadExceptionEnable:(BOOL)uploadExceptionEnable NS_DEPRECATED_IOS(2_0, 2_0, "Use  setUploadExceptionEnable: in GrowingCoreKit.h instead.");

@end
