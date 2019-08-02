# GrowingSDK-iOS-GrowingPushExtensionKit

针对iOS10系统及以上的NSNotificationServiceExtension扩展提供的SDK，统计后台通知的到达统计，最低兼容iOS 10系统版本

## 集成方式

### Cocoapods 自动集成

pod 'GrowingPushExtensionKit' 到 Podfile 文件中，特别需要注意的是要添加到不同的 TARGET 中，如下所示，PushDemo 是主工程的 TARGET，而 extension 是扩展的 TARGET。

```
target 'PushDemo' do
   // 在主工程集成其他SDK
end
target 'extension' do
  pod 'GrowingPushExtensionKit'
end

```
项目工程的 TARGETS如下：

![vkbAZrG0KHgz5dgg.png](https://uploader.shimo.im/f/vkbAZrG0KHgz5dgg.png!thumbnail)

执行pod update，不要用--no-repo-update选项

### 手动集成
点击链接下载 https://github.com/growingio/GrowingSDK-iOS-GrowingPushExtensionKit/archive/master.zip 解压后将其中的 GrowingPushExtensionKit.framework 添加到 iOS 扩展工程中，选项如下图所示：
![ztg0S5VwVDInMVi4.png](https://uploader.shimo.im/f/ztg0S5VwVDInMVi4.png!thumbnail)

## 调用方式
在扩展的通知接收方法中调用通知消息回执接口，代码示例如下：

```
- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];

    [GrowingPushExtensionKit sendNotificationRequest:request withCompletionHandler:^(NSError* error) {
        //  修改通知消息
        self.contentHandler(self.bestAttemptContent);
    }];
}
```
