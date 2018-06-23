//
//  GTBaseThirdPlatformManager.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "GTBaseThirdPlatformManager.h"
#import <SDWebImage/SDWebImageManager.h>
#import "GTThirdPlatformObject.h"


@implementation GTBaseThirdPlatformManager

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 子类实现
    NSAssert(YES, @"哥么，这里你忘记实现了");
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // 子类实现
    NSAssert(YES, @"哥么，这里你忘记实现了");
    return NO;
}

/**
 第三方分享
 */
- (void)shareWithModel:(ThirdPlatformShareModel*)model {
    __block UIImage* sharedImage = nil;
    if (model.image) {
        [self doShareWithModel:model];
    } else if (model.imageUrlString != nil) {
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:model.imageUrlString] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (image) {
                sharedImage = image;
            } else {
                sharedImage = [UIImage imageNamed:@"app_icon"];
            }
            model.image = sharedImage;
            [self doShareWithModel:model];
        }];
    } else {
        sharedImage = [UIImage imageNamed:@"app_icon"];
        model.image = sharedImage;
        [self doShareWithModel:model];
    }
}

- (void)doShareWithModel:(ThirdPlatformShareModel*)model {
    // 空实现，子类实现该方法
}

/**
 第三方登录
 
 @param thirdPlatformType 第三方平台
 @param viewController 从哪个页面调用的分享
 @param callback 登录回调
 */
- (void)signInWithType:(GTThirdPlatformType)thirdPlatformType fromViewController:(UIViewController *)viewController callback:(void (^)(ThirdPlatformUserInfo* userInfo, NSError* err))callback {
    // 空实现，子类实现该方法
}

/**
 第三方支付
 
 @param payMethodType 支付平台
 @param order 支付订单模型
 @param paymentBlock 支付结果回调
 */
- (void)payWithPlateform:(GTThirdPlatformType)payMethodType order:(OrderModel*)order paymentBlock:(void (^)(GTPayResult result))paymentBlock {
    // 空实现，子类实现该方法
}

#pragma mark - ......::::::: GTAbsThirdPlatformRespManagerDelegate :::::::......

- (void)respManagerDidRecvAuthResponse:(ThirdPlatformUserInfo *)response platform:(GTThirdPlatformType)platform {
    GTThirdPlatformOnMainThreadAsync(^{
        !_callback ?: _callback(response, nil);
    });
}

- (void)respManagerDidRecvMessageResponse:(BOOL)result platform:(GTShareType)platform {
    GTThirdPlatformOnMainThreadAsync(^{
        if (result) {
            !self.shareResultBlock ?: self.shareResultBlock(platform, GTShareResultSuccess, nil);
        } else {
            !self.shareResultBlock ?: self.shareResultBlock(platform, GTShareResultFailed, nil);
        }
    });
}

- (void)respManagerDidRecvPayResponse:(BOOL)result platform:(GTThirdPlatformType)platform {
    GTThirdPlatformOnMainThreadAsync(^{
        !self.paymentBlock ?: self.paymentBlock(result);
    });
}


@end
