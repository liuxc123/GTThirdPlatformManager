//
//  GTThirdPlatformConfigurable.h
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import <Foundation/Foundation.h>
#import "GTThirdPlatformDefine.h"

@protocol GTThirdPlatformConfigurable <NSObject>

/**
 *  按需设置平台的appkey/appID/appSecret/redirectURL/URLSchemes
 *
 *  @param platformType 平台类型 @see GTThirdPlatformType
 *  @param appKey       第三方平台的appKey
 *  @param appID        第三方平台的appID
 *  @param appSecret    第三方平台的appSecret
 *  @param redirectURL  redirectURL
 *  @param URLSchemes   URLSchemes，目前支付宝使用到，调用支付宝的时候需要传递一个URLSchemes参数
 */
- (BOOL)setPlaform:(GTThirdPlatformType)platformType
             appID:(NSString *)appID
            appKey:(NSString *)appKey
         appSecret:(NSString *)appSecret
       redirectURL:(NSString *)redirectURL
        URLSchemes:(NSString*)URLSchemes;

/**
 *  按需设置平台的appkey/appID/appSecret/redirectURL/URLSchemes
 *  一个平台不同的功能对应不用的配置使用该方法配置
 *
 *  @param platformType 平台类型 @see GTThirdPlatformType
 *  @param appKey       第三方平台的appKey
 *  @param appID        第三方平台的appID
 *  @param appSecret    第三方平台的appSecret
 *  @param redirectURL  redirectURL
 *  @param URLSchemes   URLSchemes，目前支付宝使用到，调用支付宝的时候需要传递一个URLSchemes参数
 */
- (BOOL)setPlaform:(GTThirdPlatformType)platformType
           subType:(GTThirdPlatformSubType)subType
             appID:(NSString *)appID
            appKey:(NSString *)appKey
         appSecret:(NSString *)appSecret
       redirectURL:(NSString *)redirectURL
        URLSchemes:(NSString*)URLSchemes;

- (NSString*)appIDWithPlaform:(GTThirdPlatformType)platformType;
- (NSString*)appKeyWithPlaform:(GTThirdPlatformType)platformType;
- (NSString*)appSecretWithPlaform:(GTThirdPlatformType)platformType;
- (NSString*)appRedirectURLWithPlaform:(GTThirdPlatformType)platformType;
- (NSString*)URLSchemesWithPlaform:(GTThirdPlatformType)platformType;

- (NSString*)appIDWithPlaform:(GTThirdPlatformType)platformType subType:(GTThirdPlatformSubType)subType;
- (NSString*)appKeyWithPlaform:(GTThirdPlatformType)platformType subType:(GTThirdPlatformSubType)subType;
- (NSString*)appSecretWithPlaform:(GTThirdPlatformType)platformType subType:(GTThirdPlatformSubType)subType;
- (NSString*)appRedirectURLWithPlaform:(GTThirdPlatformType)platformType subType:(GTThirdPlatformSubType)subType;
- (NSString*)URLSchemesWithPlaform:(GTThirdPlatformType)platformType subType:(GTThirdPlatformSubType)subType;

/**
 插件接入点-添加登录或者是支付的管理类
 
 @param platformType 自定义的第三方平台类型，大于999
 @param managerClass 实现了GTAbsThirdPlatformManager接口的自定义第三方平台管理类
 */
- (void)addCustomPlatform:(NSInteger)platformType managerClass:(Class)managerClass;

/**
 插件接入点-添加分享的管理类
 
 @param sharePlatformType 自定义的第三方平台分享类型，大于999
 @param managerClass 实现了GTAbsThirdPlatformManager接口的自定义第三方平台管理类
 */
- (void)addCustomSharePlatform:(NSInteger)sharePlatformType managerClass:(Class)managerClass;

@end
