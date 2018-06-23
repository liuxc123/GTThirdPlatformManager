//
//  GTThirdPlatformDefine.h
//  Pods
//
//  Created by liuxc on 2018/6/2.
//

#ifndef GTThirdPlatformDefine_h
#define GTThirdPlatformDefine_h

// 单例工具宏
#undef    AS_SINGLETON
#define AS_SINGLETON \
+ (instancetype)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON \
+ (instancetype)sharedInstance{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
} \

// 字符串工具宏
#define ValueOrEmpty(value)     ((value)?(value):@"")

// 线程处理相关
static inline void GTThirdPlatformOnMainThreadAsync(void (^block)(void)) {
    if ([NSThread isMainThread]) block();
    else dispatch_async(dispatch_get_main_queue(), block);
}

// 第三方平台类型
typedef NS_ENUM(NSInteger, GTThirdPlatformType) {
    GTThirdPlatformTypeWechat = 100,//微信
    GTThirdPlatformTypeTencentQQ,//QQ
    GTThirdPlatformTypeWeibo,//微博
    GTThirdPlatformTypeAlipay,//支付宝
    GTThirdPlatformTypeDingTalk,//钉钉
};

// 第三方平台类型对应的子类型
typedef NS_ENUM(NSInteger, GTThirdPlatformSubType) {
    GTThirdPlatformSubTypeTotal = 1,//所有的子类型，不区分
    GTThirdPlatformSubTypeAuthShare,//分享授权子类型
    GTThirdPlatformSubTypePay,//支付子类型
};

// 分享类型
typedef NS_ENUM(NSInteger, GTShareType) {
    GTShareTypeUnknow = 200,
    GTShareTypeWechat,
    GTShareTypeWechatLine,
    GTShareTypeQQ,
    GTShareTypeQQZone,
    GTShareTypeWeibo,
    GTShareTypeDingTalk,
};

// 分享内容类型
typedef NS_ENUM(NSInteger, GTShareContentType) {
    GTShareContentTypeWebPage,
    GTShareContentTypeVideo,
};

// 分享结果
typedef NS_ENUM(NSInteger, GTShareResult) {
    GTShareResultSuccess,
    GTShareResultFailed,
    GTShareResultCancel,
};

// 支付结果结果
typedef NS_ENUM(NSInteger, GTPayResult) {
    GTPayResultSuccess,
    GTPayResultFailed,
    GTPayResultCancel,
};


#endif /* GTThirdPlatformDefine_h */
