# GTThirdPlatformManager

### 怎么使用

#### 安装依赖库
定位到Demo所在的Example目录

![Demo所在的Example目录](https://gitee.com/uploads/images/2017/1114/084922_0f68d62d_300384.png "1.0.1-1运行podinstall.png")

运行 `pod install` 命令安装依赖库

```ruby
➜  Example git:(master) ✗ pod install
Analyzing dependencies
Fetching podspec for `GTThirdPlatformManager` from `../`
Downloading dependencies
Using GTThirdPlatformManager (0.0.1)
Using SDWebImage (4.0.0)
Using WechatOpenSDK (1.7.7)
Using WeiboSDK (3.1.3)
Generating Pods project
Integrating client project
Sending stats
Pod installation complete! There are 6 dependencies from the Podfile and 5 total pods installed.
```
安装完成打开 `GTThirdPlatformManager.xcworkspace` 文件即可.
默认安装所有的平台，可以修改podfile配置一个或者多个平台，具体可以查看 [选择需要的第三方平台](#Mark) 的介绍


#### 第三方平台配置

1、在AppDelegate的`didFinishLaunchingWithOptions`方法中进行平台的配置
```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
// 自定义的第三方平台以插件的方式添加
GTThirdPlatformManager* configInstance = [GTThirdPlatformManager sharedInstance];
[configInstance addCustomSharePlatform:GTCustumShareTypeDingTalk
managerClass:GTDingTalkManager.class];
[configInstance setPlaform:GTCustumShareTypeDingTalk
appID:kDingTalkAppID
appKey:nil
appSecret:nil
redirectURL:nil
URLSchemes:nil];


// 第三方平台注册
[configInstance setPlaform:GTThirdPlatformTypeWechat
appID:kWXAppID
appKey:nil
appSecret:kWXAppSecret
redirectURL:nil
URLSchemes:nil];
[configInstance setPlaform:GTThirdPlatformTypeTencentQQ
appID:kTencentAppID
appKey:kTencentAppKey
appSecret:kTencentAppSecret
redirectURL:nil
URLSchemes:nil];
[configInstance setPlaform:GTThirdPlatformTypeWeibo
appID:kWeiboAppID
appKey:kWeiboAppKey
appSecret:kWeiboAppSecret
redirectURL:kWeiboRedirectURI
URLSchemes:nil];
[configInstance setPlaform:GTThirdPlatformTypeAlipay
appID:nil
appKey:nil
appSecret:nil
redirectURL:nil
URLSchemes:kAlipayURLScheme];
[configInstance thirdPlatConfigWithApplication:application
didFinishLaunchingWithOptions:launchOptions];

return YES;
}
```

2、在AppDelegate的`openURL`方法中配置URL回调

```objc
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
return [[GTThirdPlatformConfigManager sharedInstance] thirdPlatCanOpenUrlWithApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}
```

3、功能调用
下面是不同平台调用第三发SDK的登录、分享、支付的功能示例代码，具体的可以下载项目代码查看。
```objc
- (void)viewDidLoad {
[super viewDidLoad];

typeof(self) __weak weakSelf = self;
[self addActionWithName:@"QQ Login" callback:^{
[[GTThirdPlatformConfigManager sharedInstance] signInWithType:GTThirdPlatformTypeTencentQQ fromViewController:weakSelf callback:^(ThirdPlatformUserInfo *userInfo, NSError *err) {

}];
}];

[self addActionWithName:@"Wechat Login" callback:^{
[[GTThirdPlatformConfigManager sharedInstance] signInWithType:GTThirdPlatformTypeWechat fromViewController:weakSelf callback:^(ThirdPlatformUserInfo *userInfo, NSError *err) {

}];
}];

[self addActionWithName:@"Weibo Login" callback:^{
[[GTThirdPlatformConfigManager sharedInstance] signInWithType:GTThirdPlatformTypeWeibo fromViewController:weakSelf callback:^(ThirdPlatformUserInfo *userInfo, NSError *err) {

}];
}];

// 分享模型
ThirdPlatformShareModel* shareModel = [[ThirdPlatformShareModel alloc] init];
shareModel.image = nil;
shareModel.imageUrlString = @"";
shareModel.title = @"title";
shareModel.text = @"text";
shareModel.weiboText = @"weibo text";
shareModel.urlString = @"http://www.baidu.com";
shareModel.fromViewController = self;
shareModel.shareResultBlock = ^(GTShareType pplatform, GTShareResult result, NSError * error) {

};


[self addActionWithName:@"QQ Share" callback:^{
shareModel.platform = GTShareTypeQQ;
[[GTThirdPlatformConfigManager sharedInstance] shareWithModel:shareModel];
}];

[self addActionWithName:@"Wechat Share" callback:^{
shareModel.platform = GTShareTypeWechat;
[[GTThirdPlatformConfigManager sharedInstance] shareWithModel:shareModel];
}];

[self addActionWithName:@"Weibo Share" callback:^{
shareModel.platform = GTShareTypeWeibo;
[[GTThirdPlatformConfigManager sharedInstance] shareWithModel:shareModel];
}];

[self addActionWithName:@"Wechat Pay" callback:^{
GTOrderModel* order = [[GTOrderModel alloc] init];
[[GTThirdPlatformConfigManager sharedInstance] payWithPlateform:PaymentMethodTypeWechat order:order paymentBlock:^(BOOL result) {

}];
}];

[self addActionWithName:@"Alipay Pay" callback:^{
GTOrderModel* order = [[GTOrderModel alloc] init];
[[GTThirdPlatformConfigManager sharedInstance] payWithPlateform:PaymentMethodTypeAlipay order:order paymentBlock:^(BOOL result) {

}];
}];
```

#### SDK配置
项目已经添加了微信、微博、QQ的第三方SDK了，支付宝和QQ是使用framework包的方式导入，微信和微博使用Pod的方式导入，运行 `pod install` 即可导入微信和微博的SDK。这些平台的依赖库已经配置好了，所以不需要再次配置即可使用。

#### URL Types 配置

这些配置使用到的key或者APPID部分需要自行完善，其中，**调用支付宝支付的 URL Schemes 代码调用和URL Types中的配置要保持一致**。
![URL Types 配置](https://gitee.com/uploads/images/2017/1101/123222_94d68dd5_300384.png "URL Types.png")

可以复制以下配置文件的内容，配置文件中只包含了微信、微博、QQ、支付宝的配置，修改对应平台的配置，粘贴到info.plist文件中，更多平台的配置需要参考对应平台的文档说明
```ruby
<key>CFBundleURLTypes</key>
<array>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLName</key>
<string>weixin</string>
<key>CFBundleURLSchemes</key>
<array>
<string>你的微信APPID</string>
</array>
</dict>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLSchemes</key>
<array>
<string>alipayPlush</string>
</array>
</dict>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLName</key>
<string>tencent</string>
<key>CFBundleURLSchemes</key>
<array>
<string>你的QQAPPID</string>
</array>
</dict>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLName</key>
<string>weibo</string>
<key>CFBundleURLSchemes</key>
<array>
<string>你的微博APPKEY</string>
</array>
</dict>
</array>
```

#### QueriesSchemes配置
APP调用第三方APP需要用到的，下面的配置文件配置了微信、微博、QQ、支付宝这几个第三方APP的调用，其中微信的配置需要填写你的微信APPID，如需要更多的其他第三方APP调用，参考第三方平台的配置添加即可。
```ruby
<key>LSApplicationQueriesSchemes</key>
<array>
<string>wechat</string>
<string>weixin</string>
<string>你的微信APPID</string>
<string>mqqapi</string>
<string>mqq</string>
<string>mqqOpensdkSSoLogin</string>
<string>mqqconnect</string>
<string>mqqopensdkdataline</string>
<string>mqqopensdkgrouptribeshare</string>
<string>mqqopensdkfriend</string>
<string>mqqopensdkapi</string>
<string>mqqopensdkapiV2</string>
<string>mqqopensdkapiV3</string>
<string>mqzoneopensdk</string>
<string>mqqopensdkapiV3</string>
<string>mqqopensdkapiV3</string>
<string>mqzone</string>
<string>mqzonev2</string>
<string>mqzoneshare</string>
<string>wtloginqzone</string>
<string>mqzonewx</string>
<string>mqzoneopensdkapiV2</string>
<string>mqzoneopensdkapi19</string>
<string>mqzoneopensdkapi</string>
<string>mqzoneopensdk</string>
<string>tim</string>
<string>sinaweibohd</string>
<string>sinaweibo</string>
<string>sinaweibosso</string>
<string>weibosdk</string>
<string>weibosdk2.5</string>
<string>dingtalk</string>
<string>dingtalk-open</string>
</array>
```

<div id="Mark"></div>
#### 选择需要的第三方平台
可以通过podfile配置不同的第三方平台，下面的配置是配置内置的所有的第三方平台：支付宝、QQ、微博、微信。可以选择其中的一个或多个配置，修改podfile之后需要运行`pod install`让配置生效。

```ruby
#use_frameworks!
platform :ios, '8.0'

target 'GTThirdPlatformManager_Example' do

pod 'GTThirdPlatformManager', :path => '../'
pod 'GTThirdPlatformManager/AlipayManager', :path => '../'
pod 'GTThirdPlatformManager/TencentManager', :path => '../'
pod 'GTThirdPlatformManager/WeiboManager', :path => '../'
pod 'GTThirdPlatformManager/WXManager', :path => '../'
pod 'GTThirdPlatformManager/DingTalkManager', :path => '../'

target 'GTThirdPlatformManager_Tests' do
inherit! :search_paths


end
end
```

#### 扩展第三方SDK

可以以插件的方式添加了自定义的第三方SDK，在SDK配置这个步骤好了之后，需要一下步骤
- 继承`GTBaseThirdPlatformManager`类生成一个第三方SDK的管理器
- 实现`GTAbsThirdPlatformRequestHandler`接口生成一个第三发SDK的底层调用
- 继承`GTBaseThirdPlatformRespManager`类生成一个第三方SDK的响应回调

以钉钉平台为例，生成三个平台相关的类文件：
![钉钉平台文件图](https://gitee.com/uploads/images/2017/1120/210013_bc2c1a9b_300384.png "钉钉平台文件图.png")

调用  `GTThirdPlatformManager`类的两个接口  `addCustomPlatform`、 `addCustomSharePlatform` 添加自定义的第三方平台。

```objc
// 自定义的第三方平台以插件的方式添加
[[GTThirdPlatformManager sharedInstance] addCustomSharePlatform:GTCustumShareTypeDingTalk managerClass:GTDingTalkManager.class];
[[GTThirdPlatformManager sharedInstance] setPlaform:GTCustumShareTypeDingTalk appID:kDingTalkAppID appKey:nil appSecret:nil redirectURL:nil];
```

完了之后可以回到`怎么使用`步骤查看怎么使用了。



## Author

liuxc123, lxc_work@126.com

## License

GTThirdPlatformManager is available under the MIT license. See the LICENSE file for more info.





