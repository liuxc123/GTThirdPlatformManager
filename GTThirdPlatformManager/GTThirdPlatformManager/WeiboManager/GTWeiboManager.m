//
//  GTWeiboManager.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "GTWeiboManager.h"
#import "GTWeiboRespManager.h"
#import "GTWeiboRequestHandler.h"
#import "GTThirdPlatformManager.h"
#import "GTThirdPlatformObject.h"

@interface GTWeiboManager () <GTAbsThirdPlatformRespManagerDelegate>
@end

@implementation GTWeiboManager

DEF_SINGLETON

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 初始化微博模块
#if DEBUG
    [WeiboSDK enableDebugMode:YES];
    NSLog(@"WeiboSDK getSDKVersion = %@", [WeiboSDK getSDKVersion]);
#endif
    NSString* appKey = [[GTThirdPlatformManager sharedInstance] appKeyWithPlaform:GTThirdPlatformTypeWeibo];
    [WeiboSDK registerApp:appKey];
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // Weibo
    if ([WeiboSDK handleOpenURL:url delegate:[GTWeiboRespManager sharedInstance]]) {
        return YES;
    }
    
    return NO;
}

/**
 第三方登录
 */
- (void)signInWithType:(GTThirdPlatformType)thirdPlatformType fromViewController:(UIViewController *)viewController callback:(void (^)(ThirdPlatformUserInfo* userInfo, NSError* err))callback {
    self.callback = callback;
    [GTWeiboRespManager sharedInstance].delegate = self;
    [GTWeiboRequestHandler sendAuthInViewController:viewController];
}

// 分享
- (void)doShareWithModel:(ThirdPlatformShareModel *)model {
    self.shareResultBlock = model.shareResultBlock;
    [GTWeiboRespManager sharedInstance].delegate = self;
    BOOL shareResult = [GTWeiboRequestHandler sendMessageWithModel:model];
    if (shareResult == NO) {
        !self.shareResultBlock ?: self.shareResultBlock(model.platform, GTShareResultFailed, nil);
    }
}

- (BOOL)isThirdPlatformInstalled:(GTShareType)thirdPlatform {
    return [WeiboSDK isWeiboAppInstalled];
}


@end
