//
//  GTAppDelegate.m
//  GTThirdPlatformManager
//
//  Created by liuxc123 on 06/23/2018.
//  Copyright (c) 2018 liuxc123. All rights reserved.
//

#import "GTAppDelegate.h"
#import <GTThirdPlatformKit.h>
#import "GTConstants.h"

@implementation GTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 自定义的第三方平台以插件的方式添加
    GTThirdPlatformManager* configInstance = [GTThirdPlatformManager sharedInstance];
    [configInstance setPlaform:GTThirdPlatformTypeDingTalk
                         appID:kDingTalkAppID
                        appKey:nil
                     appSecret:nil
                   redirectURL:nil
                    URLSchemes:nil];
    
    /**** 第三方平台注册 *****/
    // 微信
    [configInstance setPlaform:GTThirdPlatformTypeWechat
                         appID:kWXAppID
                        appKey:nil
                     appSecret:kWXAppSecret
                   redirectURL:nil
                    URLSchemes:nil];
    // QQ授权分享
    [configInstance setPlaform:GTThirdPlatformTypeTencentQQ
                       subType:GTThirdPlatformSubTypeAuthShare
                         appID:kTencentAppID
                        appKey:kTencentAppKey
                     appSecret:kTencentAppSecret
                   redirectURL:nil
                    URLSchemes:nil];
    // QQ支付
    [configInstance setPlaform:GTThirdPlatformTypeTencentQQ
                       subType:GTThirdPlatformSubTypePay
                         appID:kQQPayAppID
                        appKey:kQQPayAppKey
                     appSecret:nil
                   redirectURL:nil
                    URLSchemes:kQQPayURLScheme];
    // 微博
    [configInstance setPlaform:GTThirdPlatformTypeWeibo
                         appID:kWeiboAppID
                        appKey:kWeiboAppKey
                     appSecret:kWeiboAppSecret
                   redirectURL:kWeiboRedirectURI
                    URLSchemes:nil];
    // 支付宝
    [configInstance setPlaform:GTThirdPlatformTypeAlipay
                         appID:nil
                        appKey:nil
                     appSecret:nil
                   redirectURL:nil
                    URLSchemes:kAlipayURLScheme];
    // 执行配置
    [configInstance thirdPlatConfigWithApplication:application
                     didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[GTThirdPlatformManager sharedInstance] thirdPlatCanOpenUrlWithApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
//    return [[GTThirdPlatformManager sharedInstance] thirdPlatCanOpenUrlWithApplication:app openURL:url sourceApplication:nil annotation:nil];
//}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[GTThirdPlatformManager sharedInstance] thirdPlatCanOpenUrlWithApplication:application openURL:url sourceApplication:nil annotation:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
