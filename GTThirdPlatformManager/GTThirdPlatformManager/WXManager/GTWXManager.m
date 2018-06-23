//
//  GTWXManager.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "GTWXManager.h"
#import "GTWXRespManager.h"
#import "GTWXRequestHandler.h"
#import <WXApi.h>
#import "GTThirdPlatformManager.h"
#import "GTThirdPlatformObject.h"

@interface GTWXManager () <GTAbsThirdPlatformRespManagerDelegate>
@end

@implementation GTWXManager

DEF_SINGLETON

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //向微信注册
    NSString* appID = [[GTThirdPlatformManager sharedInstance] appIDWithPlaform:GTThirdPlatformTypeWechat];
    [WXApi registerApp:appID];
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // 微信
    if ([WXApi handleOpenURL:url delegate:[GTWXRespManager sharedInstance]]) {
        return YES;
    }
    return NO;
}

/**
 第三方登录
 */
- (void)signInWithType:(GTThirdPlatformType)thirdPlatformType fromViewController:(UIViewController *)viewController callback:(void (^)(ThirdPlatformUserInfo* userInfo, NSError* err))callback {
    self.callback = callback;
    [GTWXRespManager sharedInstance].delegate = self;
    [GTWXRequestHandler sendAuthInViewController:viewController];
}

// 分享
- (void)doShareWithModel:(ThirdPlatformShareModel *)model {
    self.shareResultBlock = model.shareResultBlock;
    [GTWXRespManager sharedInstance].delegate = self;
    BOOL shareResult = [GTWXRequestHandler sendMessageWithModel:model];
    if (shareResult == NO) {
        !self.shareResultBlock ?: self.shareResultBlock(GTShareTypeWechat, GTShareResultFailed, nil);
    }
}

/**
 第三方支付
 */
- (void)payWithPlateform:(GTThirdPlatformType)payMethodType order:(OrderModel*)order paymentBlock:(void (^)(GTPayResult result))paymentBlock {
    self.paymentBlock = paymentBlock;
    // 使用微信支付
    [GTWXRespManager sharedInstance].delegate = self;
    [GTWXRequestHandler payWithOrder:order];
}

- (BOOL)isThirdPlatformInstalled:(GTShareType)thirdPlatform {
    return [WXApi isWXAppInstalled];
}

@end
