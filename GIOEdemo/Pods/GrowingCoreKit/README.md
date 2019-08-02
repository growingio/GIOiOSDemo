# GrowingSDK-iOS-GrowingCoreKit

We are from [GrowingIO.com](http://growingio.com/). We provide professional data analytics service.

This Pod helps our customers to integrate our SDK easily. For more details, please read [help docs on GrowingIO.com](http://help.growingio.com/) (in Chinese).

To integrate this pod, please add `pod 'GrowingCoreKit'` into your Podfile target(s). Here's an example:

platform :ios, '7.0'
xcodeproj 'MyApp/MyApp.xcodeproj'
target 'MyApp' do
pod 'GrowingCoreKit'
end

For any questions, please go to www.growingio.com, login, then submit a ticket to us.

FAQ (written in Chinese):

Q: 安装或者更新时遇到 404 Not Found 错误，怎么办？

A: 因为历史版本会有问题，所以我们只会在服务器保留最新版本，我们也希望客户始终安装最新版本。   
在安装 pod 时，请确保不要使用 ```--no-repo-update``` 选项，或者先用 ```pod repo update``` 来更新一下本地的所有 repo 信息，然后再安装。   
安装前您可以执行命令 ```pod spec cat GrowingCoreKit``` 看一下，从这个命令的输出里可以看到我们当前的版本号，您可以对照着看一下。   
此外，当您集成时遇到任何问题（包括 pod 的问题）时，为了能更及时地帮到您，建议您在我们的网站 www.growingio.com 上登陆您的账号，然后点击右上角的“提交问题”来联系我们，我们会及时解决您的问题
