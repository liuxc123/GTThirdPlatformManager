//
//  GTThirdPlatformManager.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "GTThirdPlatformManager.h"
#import "GTAbsThirdPlatformManager.h"
#import "GTThirdPlatformObject.h"

typedef NS_ENUM(NSUInteger, GTThirdPlatformConfigKey) {
    GTThirdPlatformAppID,
    GTThirdPlatformAppKey,
    GTThirdPlatformAppSecret,
    GTThirdPlatformRedirectURI,
    GTThirdPlatformURLSchemes,
};

@interface GTThirdPlatformManager ()
@property (nonatomic, strong) NSMutableDictionary* thirdPlatformKeysConfig;
@property (nonatomic, strong) NSMutableSet* thirdPlatformManagerClasses;
@property (nonatomic, strong) NSMutableDictionary* thirdPlatformManagerConfig;
@property (nonatomic, strong) NSMutableDictionary* thirdPlatformShareManagerConfig;
@end

@implementation GTThirdPlatformManager

DEF_SINGLETON

#pragma mark - ......::::::: GTAbsThirdPlatformManager Override :::::::......

/**
 第三方平台配置
 */
- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    for (NSString* classString in [self thirdPlatformManagerClasses]) {
        id<GTAbsThirdPlatformManager> manager = [self managerFromClassString:classString];
        if (manager && [manager conformsToProtocol:@protocol(GTAbsThirdPlatformManager)]) {
            [manager thirdPlatConfigWithApplication:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    for (NSString* classString in [self thirdPlatformManagerClasses]) {
        id<GTAbsThirdPlatformManager> manager = [self managerFromClassString:classString];
        if (manager && [manager conformsToProtocol:@protocol(GTAbsThirdPlatformManager)]) {
            BOOL result = [manager thirdPlatCanOpenUrlWithApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
            if (result) {
                return YES;
            }
        }
    }
    return NO;
}

/**
 第三方登录
 
 @param thirdPlatformType 第三方平台
 @param viewController 从哪个页面调用的分享
 @param callback 登录回调
 */
- (void)signInWithType:(GTThirdPlatformType)thirdPlatformType
    fromViewController:(UIViewController *)viewController
              callback:(void (^)(ThirdPlatformUserInfo* userInfo, NSError* err))callback {
    NSString* classString = [[self thirdPlatformManagerConfig] objectForKey:@(thirdPlatformType)];
    id<GTAbsThirdPlatformManager> manager = [self managerFromClassString:classString];
    [manager signInWithType:thirdPlatformType
         fromViewController:viewController
                   callback:callback];
}

/**
 第三方分享
 
 @param model 分享数据
 */
- (void)shareWithModel:(ThirdPlatformShareModel *)model {
    NSString* classString = [[self thirdPlatformShareManagerConfig] objectForKey:@(model.platform)];
    id<GTAbsThirdPlatformManager> manager = [self managerFromClassString:classString];
    [manager shareWithModel:model];
}

/**
 第三方支付
 
 @param payMethodType 支付平台
 @param order 支付订单模型
 @param paymentBlock 支付结果回调
 */
- (void)payWithPlateform:(GTThirdPlatformType)payMethodType order:(OrderModel*)order paymentBlock:(void (^)(GTPayResult result))paymentBlock {
    NSString* classString = [[self thirdPlatformManagerConfig] objectForKey:@(payMethodType)];
    id<GTAbsThirdPlatformManager> manager = [self managerFromClassString:classString];
    [manager payWithPlateform:payMethodType
                        order:order
                 paymentBlock:paymentBlock];
}


/**
 判断是否安装该程序

 @param platform 平台类型
 */
- (BOOL)isThirdPlatformInstalled:(GTShareType)platform {
    NSString* classString = [[self thirdPlatformShareManagerConfig] objectForKey:@(platform)];
    id<GTAbsThirdPlatformManager> manager = [self managerFromClassString:classString];
    return [manager isThirdPlatformInstalled:platform];
}

#pragma mark - ......::::::: GTThirdPlatformConfigurable Override :::::::......
- (BOOL)setPlaform:(GTThirdPlatformType)platformType
             appID:(NSString *)appID
            appKey:(NSString *)appKey
         appSecret:(NSString *)appSecret
       redirectURL:(NSString *)redirectURL
        URLSchemes:(NSString*)URLSchemes {
    [self setPlaform:platformType subType:GTThirdPlatformSubTypeTotal appID:appID appKey:appKey appSecret:appSecret redirectURL:redirectURL URLSchemes:URLSchemes];
    return YES;
}

- (BOOL)setPlaform:(GTThirdPlatformType)platformType
           subType:(GTThirdPlatformSubType)subType
             appID:(NSString *)appID
            appKey:(NSString *)appKey
         appSecret:(NSString *)appSecret
       redirectURL:(NSString *)redirectURL
        URLSchemes:(NSString*)URLSchemes {
    NSDictionary* subTypeConfig = @{@(GTThirdPlatformAppID): ValueOrEmpty(appID),
                                    @(GTThirdPlatformAppKey): ValueOrEmpty(appKey),
                                    @(GTThirdPlatformAppSecret): ValueOrEmpty(appSecret),
                                    @(GTThirdPlatformRedirectURI): ValueOrEmpty(redirectURL),
                                    @(GTThirdPlatformURLSchemes): ValueOrEmpty(URLSchemes),
                                    };
    
    if (![self.thirdPlatformKeysConfig objectForKey:@(platformType)]) {
        [self.thirdPlatformKeysConfig setObject:[@{} mutableCopy] forKey:@(platformType)];
    }
    
    [[self.thirdPlatformKeysConfig objectForKey:@(platformType)] setObject:subTypeConfig forKey:@(subType)];
    return YES;
}

- (NSString*)appIDWithPlaform:(GTThirdPlatformType)platformType {
    return [self appIDWithPlaform:platformType subType:GTThirdPlatformSubTypeTotal];
}

- (NSString*)appKeyWithPlaform:(GTThirdPlatformType)platformType {
    return [self appKeyWithPlaform:platformType subType:GTThirdPlatformSubTypeTotal];
}

- (NSString*)appSecretWithPlaform:(GTThirdPlatformType)platformType {
    return [self appSecretWithPlaform:platformType subType:GTThirdPlatformSubTypeTotal];
}

- (NSString*)appRedirectURLWithPlaform:(GTThirdPlatformType)platformType {
    return [self appRedirectURLWithPlaform:platformType subType:GTThirdPlatformSubTypeTotal];
}

- (NSString*)URLSchemesWithPlaform:(GTThirdPlatformType)platformType {
    return [self URLSchemesWithPlaform:platformType subType:GTThirdPlatformSubTypeTotal];
}

- (NSString*)appIDWithPlaform:(GTThirdPlatformType)platformType subType:(GTThirdPlatformSubType)subType {
    return [[[self.thirdPlatformKeysConfig objectForKey:@(platformType)] objectForKey:@(subType)] objectForKey:@(GTThirdPlatformAppID)];
}

- (NSString*)appKeyWithPlaform:(GTThirdPlatformType)platformType subType:(GTThirdPlatformSubType)subType {
    return [[[self.thirdPlatformKeysConfig objectForKey:@(platformType)] objectForKey:@(subType)] objectForKey:@(GTThirdPlatformAppKey)];
}

- (NSString*)appSecretWithPlaform:(GTThirdPlatformType)platformType subType:(GTThirdPlatformSubType)subType {
    return [[[self.thirdPlatformKeysConfig objectForKey:@(platformType)] objectForKey:@(subType)] objectForKey:@(GTThirdPlatformAppSecret)];
}

- (NSString*)appRedirectURLWithPlaform:(GTThirdPlatformType)platformType subType:(GTThirdPlatformSubType)subType {
    return [[[self.thirdPlatformKeysConfig objectForKey:@(platformType)] objectForKey:@(subType)] objectForKey:@(GTThirdPlatformRedirectURI)];
}

- (NSString*)URLSchemesWithPlaform:(GTThirdPlatformType)platformType subType:(GTThirdPlatformSubType)subType {
    return [[[self.thirdPlatformKeysConfig objectForKey:@(platformType)] objectForKey:@(subType)] objectForKey:@(GTThirdPlatformURLSchemes)];
}

#pragma mark 插件接入点

/**
 插件接入点-添加登录或者是支付的管理类
 
 @param platformType 自定义的第三方平台类型，大于999
 @param managerClass 实现了PTAbsThirdPlatformManager接口的自定义第三方平台管理类
 */
- (void)addCustomPlatform:(NSInteger)platformType managerClass:(Class)managerClass {
    NSString* classString = NSStringFromClass(managerClass);
    if (classString) {
        [self.thirdPlatformManagerConfig setObject:NSStringFromClass(managerClass) forKey:@(platformType)];
        [self.thirdPlatformManagerClasses addObject:classString];
    }
}

/**
 插件接入点-添加分享的管理类
 
 @param sharePlatformType 自定义的第三方平台分享类型，大于999
 @param managerClass 实现了PTAbsThirdPlatformManager接口的自定义第三方平台管理类
 */
- (void)addCustomSharePlatform:(NSInteger)sharePlatformType managerClass:(Class)managerClass {
    NSString* classString = NSStringFromClass(managerClass);
    if (classString) {
        [self.thirdPlatformShareManagerConfig setObject:classString forKey:@(sharePlatformType)];
        [self.thirdPlatformManagerClasses addObject:classString];
    }
}

#pragma mark - ......::::::: Config :::::::......

- (id)managerFromClassString:(NSString*)classString {
    if (classString == nil || classString.length == 0) {
        return nil;
    }
    Class clz = NSClassFromString(classString);
    SEL sharedInstanceSelector = @selector(sharedInstance);
    id<GTAbsThirdPlatformManager> manager = nil;
    if(clz && [clz respondsToSelector:sharedInstanceSelector]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        // 这里的警告可以直接忽略，返回的是一个单例对象，不会有泄漏问题
        manager = [clz performSelector:sharedInstanceSelector];
#pragma clang diagnostic pop
    }
    return manager;
}

// 配置管理类的类名
- (NSMutableSet*)thirdPlatformManagerClasses {
    if (nil == _thirdPlatformManagerClasses) {
        _thirdPlatformManagerClasses = [[NSMutableSet alloc] init];
        [_thirdPlatformManagerClasses
         addObjectsFromArray:@[@"GTAlipayManager",
                               @"GTTencentManager",
                               @"GTWeiboManager",
                               @"GTWXManager",
                               @"GTDingTalkManager",
                               ]];
    }
    return _thirdPlatformManagerClasses;
}

// 配置第三方登录支付对应的管理类
- (NSMutableDictionary*)thirdPlatformManagerConfig {
    if (nil == _thirdPlatformManagerConfig) {
        _thirdPlatformManagerConfig = [[NSMutableDictionary alloc] init];
        [_thirdPlatformManagerConfig addEntriesFromDictionary:
         @{
           @(GTThirdPlatformTypeWechat): @"GTWXManager",
           @(GTThirdPlatformTypeTencentQQ): @"GTTencentManager",
           @(GTThirdPlatformTypeWeibo): @"GTWeiboManager",
           @(GTThirdPlatformTypeAlipay): @"GTAlipayManager",
           }];
    }
    return _thirdPlatformManagerConfig;
}

// 配置第三方分享对应的管理类
- (NSMutableDictionary*)thirdPlatformShareManagerConfig {
    if (nil == _thirdPlatformShareManagerConfig) {
        _thirdPlatformShareManagerConfig = [[NSMutableDictionary alloc] init];
        [_thirdPlatformShareManagerConfig addEntriesFromDictionary:
         @{
           @(GTShareTypeWechat): @"GTWXManager",
           @(GTShareTypeWechatLine): @"GTWXManager",
           @(GTShareTypeQQ): @"GTTencentManager",
           @(GTShareTypeQQZone): @"GTTencentManager",
           @(GTShareTypeWeibo): @"GTWeiboManager",
           @(GTShareTypeDingTalk): @"GTDingTalkManager"
           }];
    }
    return _thirdPlatformShareManagerConfig;
}

// 第三方平台的APPID/APPKEY/APPSECRET等信息
- (NSMutableDictionary*)thirdPlatformKeysConfig {
    if (!_thirdPlatformKeysConfig) {
        _thirdPlatformKeysConfig = [[NSMutableDictionary alloc] init];
    }
    return _thirdPlatformKeysConfig;
}

@end
