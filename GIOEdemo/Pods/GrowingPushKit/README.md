# GrowingSDK-iOS-GrowingPushKit

依赖于埋点SDK GrowingCoreKit.framework，集成在App中，进行推送SDK的初始化以及通知的前台到达与点击统计，最低兼容iOS 8系统版本

## 集成方式

### CocoaPods 自动集成

    添加pod 'GrowingPushKit'到 Podfile 中
    执行pod update，不要用 --no-repo-update选项

### 手动集成

1.  由于 GrowingPushKit.framework 依赖于埋点SDK GrowingCoreKit.framework ，因此先手动集成埋点SDK，详见iOS埋点SDK集成帮助文档 https://docs.growingio.com/docs/sdk-integration/ios-sdk/ios-mai-dian-sdk

2.  下载最新的 iOS SDK 包 GrowingPushKit.framework https://github.com/growingio/GrowingSDK-iOS-GrowingPushKit/archive/master.zip
 ,解压后将其中的GrowingPushKit.framework 添加到 iOS 工程中，选项如下图所示：

![AwvlV2k9RqEHQ6IZ.png](https://uploader.shimo.im/f/AwvlV2k9RqEHQ6IZ.png!thumbnail)

### 调用方法

1.  推送设备的 device Token 上传

用户自行实现通知注册请求授权后，在 AppDelegate 的 deviceToken 代理方法中调用API，传入获取到的 deviceToken，请确保能获取 deviceToken，否则无法接收通知消息。

```
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
[Growing registerDeviceToken:deviceToken];
}
```
2.  推送消息跳转处理

推送功能默认提供打开APP、打开网页、打开APP内部页面三种功能，如果该三种功能还是满足不了您的需求，您可以在SDK提供的以下方法回调中自定义自己的跳转逻辑。

```
//  点击消息跳转用户自定义
+ (void)clickMessageWithCompletionHandler:(void (^)(NSDictionary *params))completionHandler;
```

