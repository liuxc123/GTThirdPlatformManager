//
//  GTTencentManager.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "GTTencentManager.h"
#import "GTTencentRespManager.h"
#import "GTTencentRequestHandler.h"
#import "GTThirdPlatformObject.h"
#import "QQWalletSDK.h"


@interface GTTencentManager () <GTAbsThirdPlatformRespManagerDelegate>
@end


@implementation GTTencentManager

DEF_SINGLETON

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 子类实现
    // 初始化QQ模块
    [GTTencentRespManager sharedInstance];
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // QQ 授权
    if ([TencentOAuth CanHandleOpenURL:url] && [TencentOAuth HandleOpenURL:url]) {
        return YES;
    }
    
    // QQ 业务
    if ([QQApiInterface handleOpenURL:url delegate:[GTTencentRespManager sharedInstance]]) {
        return YES;
    }
    
    // QQ钱包，在此函数中注册回调监听
    if ([[QQWalletSDK sharedInstance] hanldeOpenURL:url]) {
        return YES;
    }
    
    return NO;
}


/**
 第三方登录
 */
- (void)signInWithType:(GTThirdPlatformType)thirdPlatformType fromViewController:(UIViewController *)viewController callback:(void (^)(ThirdPlatformUserInfo* userInfo, NSError* err))callback {
    self.callback = callback;
    [GTTencentRespManager sharedInstance].delegate = self;
    [GTTencentRequestHandler sendAuthInViewController:viewController];
}

// 分享
- (void)doShareWithModel:(ThirdPlatformShareModel *)model {
    self.shareResultBlock = model.shareResultBlock;
    [GTTencentRespManager sharedInstance].delegate = self;
    BOOL shareResult = [GTTencentRequestHandler sendMessageWithModel:model];
    if (shareResult == NO) {
        !self.shareResultBlock ?: self.shareResultBlock(GTShareTypeQQ, GTShareResultFailed, nil);
    }
}

/**
 第三方支付
 */
- (void)payWithPlateform:(GTThirdPlatformType)payMethodType order:(OrderModel*)order paymentBlock:(void (^)(GTPayResult result))paymentBlock {
    self.paymentBlock = paymentBlock;
    // 使用QQ支付
    [GTTencentRespManager sharedInstance].delegate = self;
    [GTTencentRequestHandler payWithOrder:order];
}

- (BOOL)isThirdPlatformInstalled:(GTShareType)thirdPlatform {
    return [TencentOAuth iphoneQQInstalled] || [TencentOAuth iphoneTIMInstalled];
}

@end
