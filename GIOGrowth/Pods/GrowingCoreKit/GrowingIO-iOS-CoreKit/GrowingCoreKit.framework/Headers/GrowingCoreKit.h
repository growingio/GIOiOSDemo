//
//  GrowingCoreKit.h
//  GrowingCoreKit
//
//  Created by GrowingIO on 2018/5/14.
//  Copyright © 2018年 GrowingIO. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef __cplusplus
@import Foundation;
@import CoreTelephony;
@import SystemConfiguration;
@import Security;
@import CFNetwork;
@import CoreLocation;
@import WebKit;
#endif

typedef NS_ENUM(NSInteger, GrowingAspectMode)
{
    // 默认 类似KVO的机制进行数据采集
    // 目前已知对Aspects以及部分不确定的手写swizzling有冲突
    // 依据不同调用顺序 可能出现函数不被调用或者崩溃的问题
    // 另外如果使用 object_getClass或者swfit的dynamicType属性会得到一个KVO的子类
    // 如果用于取得XIB或者其他资源 可能会失效
    GrowingAspectModeSubClass           ,
    
    //高兼容性 性能比GrowingAspectTypeSubClass略低 但是比RAC和Aspects快8-10倍左右
    GrowingAspectModeDynamicSwizzling   ,
};

@interface Growing : NSObject

// SDK版本号
+ (NSString*)sdkVersion;

// 如果您的AppDelegate中 实现了其中一个或者多个方法 请以在已实现的函数中 调用handleUrl
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
// 如果以上所有函数都未实现 则请实现 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation 方法并调用handleUrl
+ (BOOL)handleUrl:(NSURL*)url;

// 请在applicationDidFinishLaunching中调用此函数初始化,并且在主线程中

// TODO: 要不要把 accountId 改成 projectId？
// TODO: 这里的任何改动，都需要改 help 文档和集成文档

// 如果需要采样 设置一个采样值   0.01即1% 0.001即1‰  最多支持小数点后5位
+ (void)startWithAccountId:(NSString *)accountId withSampling:(CGFloat)sampling;

// 默认采样100%
+ (void)startWithAccountId:(NSString *)accountId;

// 命令行输出调试日志
+ (void)setEnableLog:(BOOL)enableLog;
+ (BOOL)getEnableLog;

// 若使用加密功能,请在UI元素初始化之前设置此函数
+ (void)setEncryptStringBlock:(NSString *(^)(NSString *string))block;

// 禁止采集push点击
+ (void)disablePushTrack:(BOOL)disable;
+ (BOOL)getDisablePushTrack;

// 默认为YES
// 设置为NO可以不采集地理位置的统计信息
+ (void)setEnableLocationTrack:(BOOL)enable;
+ (BOOL)getEnableLocationTrack;

// 以下函数设置后会覆盖原有设置
// 此函数如果被定义,则为获取deviceID的第一优先级
// 请在方法 startWithAccountId 之前调用
// 使用自定义的ID 自定义ID长度不可大于64 否则会被抛弃 NSUUID的UUIDString长度为36
// Example:
//  1. setDeviceIDModeToCustomBlock:^NSString*{ return [[[UIDevice currentDevice] identifierForVendor] UUIDString]; }
+ (void)setDeviceIDModeToCustomBlock:(NSString*(^)(void))customBlock;

/**
 deeplink广告落地页参数回调设置
 调用时机在startWithAccountId函数之前

 @param handler deeplink广告落地页参数回调, params 为解析正确时回调的参数, processTime为从app被deeplink唤起到handler回调的时间(单位秒), error 为解析错误时返回的参数.
                 handler 默认为空, 客户需要手动设置.
 */
+ (void)registerDeeplinkHandler:(void(^)(NSDictionary *params, NSTimeInterval processTime, NSError *error))handler;


/**
 判断链接是否为deeplink链接

 @param url 传入的网址
 @return YES:是deeplink链接 NO:不是deeplink链接
*/
+ (BOOL)isDeeplinkUrl:(NSURL *)url;

/**
 手动处理deeplink链接

 @param url 传入的网址
 @param callback deeplink广告落地页参数回调, params 为解析正确时回调的参数, processTime为从app被deeplink唤起到handler回调的时间(单位秒), error 为解析错误时返回的参数.
 callback若传nil:回调结果将从method <registerDeeplinkHandler:>中设置的handler返回
 callback若不为nil:回调结果只从当前的callback中返回
 @return YES:是deeplink链接 NO:不是deeplink链接
*/
+ (BOOL)doDeeplinkByUrl:(NSURL *)url callback:(void(^)(NSDictionary *params, NSTimeInterval processTime, NSError *error))callback;

/**
  + 注册实时发送数据的回调
  +
  + @param handler 实时发送数据的回调, eventObject以字典的形式返回采集的事件
  + */
+ (void)registerRealtimeReportHandler:(void(^)(NSDictionary *eventObject))handler;

// 该函数请在main函数第一行调用 APP启动后 将不允许修改采集模式
+ (void)setAspectMode:(GrowingAspectMode)aspectMode;
+ (GrowingAspectMode)getAspectMode;

// 该函数请在main函数第一行调用
+ (void)setBundleId:(NSString *)bundleId;
+ (NSString *)getBundleId; // 此方法只返回您的赋值

// 该函数请在main函数第一行调用
+ (void)setUrlScheme:(NSString *)urlScheme;
+ (NSString *)getUrlScheme; // 此方法只返回您的赋值

// 是否允许发送基本性能诊断信息，默认为开
+ (void)setEnableDiagnose:(BOOL)enable;

// 全局不发送统计信息
+ (void)disable;

// 设置发送数据的时间间隔（单位为秒）
+ (void)setFlushInterval:(NSTimeInterval)interval;
+ (NSTimeInterval)getFlushInterval;

// 设置从后台进入前台重置sessionID的时间间隔 (单位为秒)
+ (void)setSessionInterval:(NSTimeInterval)interval;
+ (NSTimeInterval)getSessionInterval;

// 设置每天使用数据网络（2G、3G、4G）上传的数据量的上限（单位是 KB）
+ (void)setDailyDataLimit:(NSUInteger)numberOfKiloByte;
+ (NSUInteger)getDailyDataLimit;

// 设置数据收集平台服务器地址
+ (void)setTrackerHost:(NSString *)host;

// 设置设备报活服务器地址
+ (void)setReportHost:(NSString *)host;

// 设置数据查看平台服务器地址
+ (void)setDataHost:(NSString*)host;

// 一般放静态资源的服务（目前存放用户的圈选结果页）
+ (void)setAssetsHost:(NSString*)host;

// 设置数据后台服务器地址
+ (void)setGtaHost:(NSString*)host;

// 设置数据后台服务器地址
+ (void)setWsHost:(NSString*)host;

// 设置zone信息
+ (void)setZone:(NSString *)zone;

// 设置 GDPR 生效
+ (void)disableDataCollect;
// 设置 GDPR 失效
+ (void)enableDataCollect;
// 获取当前设备id
+ (NSString *)getDeviceId;
// 获取当前uid
+ (NSString *)getVisitUserId;
// 获取当前访问id
+ (NSString *)getSessionId;


/// !!!: V2.0埋点相关API，请在主线程里调用.
/**
 设置登录用户ID
 
 @param userId 登陆用户ID, ID为正常英文数字组合的字符串, 长度<=1000, 请不要含有 "'|\*&$@/', 等特殊字符
 ！！！不允许传空或者nil, 如有此操作请调用clearUserId函数
 */
+ (void)setUserId:(NSString *)userId;
/**
 清除登录用户ID
 */
+ (void)clearUserId;
/**
 转化变量
 
 @param variable : 转化变量, 变量不能为nil
 */
+ (void)setEvar:(NSDictionary<NSString *, NSObject *> *)variable;
/**
 转化变量 API
 
 @param key : 变量名称, 变量名称不能为nil或者""
 @param stringValue : 字符串变量, 变量不为nil或者""
 */
+ (void)setEvarWithKey:(NSString *)key andStringValue:(NSString *)stringValue;
/**
 转化变量
 
 @param key : 变量名称, 变量名称不能为nil或者""
 @param numberValue : 数值类型变量, 变量不能为nil
 */
+ (void)setEvarWithKey:(NSString *)key andNumberValue:(NSNumber *)numberValue;

/**
 用户变量
 
 @param variable : 用户变量, 变量不能为nil
 */
+ (void)setPeopleVariable:(NSDictionary<NSString *, NSObject *> *)variable;
/**
 用户变量
 
 @param key : 变量名称, 变量名称不能为nil或者""
 @param stringValue : 字符串变量, 变量不能为nil或者""
 */
+ (void)setPeopleVariableWithKey:(NSString *)key andStringValue:(NSString *)stringValue;
/**
 用户变量
 
 @param key : 变量名称, 变量名称不能为nil或者""
 @param numberValue : 数值类型变量, 变量不能为nil
 */
+ (void)setPeopleVariableWithKey:(NSString *)key andNumberValue:(NSNumber *)numberValue;

/**
 发送事件 API, number默认为1
 
 @param eventId : 事件Id, Id为正常英文数字组合的字符串, 长度<=1000, 请不要含有 "'|\*&$@/', 等特殊字符
 */
+ (void)track:(NSString *)eventId;

/**
 发送事件 API
 
 @param eventId : 事件Id, Id为正常英文数字组合的字符串, 长度<=1000, 请不要含有 "'|\*&$@/', 等特殊字符
 @param number : 数值类型变量, number为正的整数或者浮点数
 */
+ (void)track:(NSString *)eventId withNumber:(NSNumber *)number;

/**
 发送事件 API
 
 @param eventId : 事件Id, Id为正常英文数字组合的字符串, 长度<=1000, 请不要含有 "'|\*&$@/', 等特殊字符
 @param number : 数值类型变量, number为正的整数或者浮点数
 @param variable : 事件变量, 变量不能为nil
 */
+ (void)track:(NSString *)eventId withNumber:(NSNumber *)number andVariable:(NSDictionary<NSString *, id> *)variable;

/**
 发送事件 API
 
 @param eventId 事件Id, Id为正常英文数字组合的字符串, 长度<=1000, 请不要含有 "'|\*&$@/', 等特殊字符
 @param variable : 事件变量, 变量不能为nil
 */
+ (void)track:(NSString *)eventId withVariable:(NSDictionary<NSString *, id> *)variable;

/**
 访问用户变量
 
 @param variable : 访问用户变量, 不能为nil
 */
+ (void)setVisitor:(NSDictionary<NSString *, NSObject *> *)variable;

/**
 是否开启SDK的crash监控，默认是开启的，请在 startWithAccountId: 或 startWithAccountId: withSampling: 接口之前设置。
 
 @param uploadExceptionEnable 是否开启SDK的crash监控上报
 */
+ (void)setUploadExceptionEnable:(BOOL)uploadExceptionEnable;

@end
