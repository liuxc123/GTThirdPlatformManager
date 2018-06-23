//
//  GTAlipayManager.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "GTAlipayManager.h"
#import "GTAlipayRespManager.h"
#import "GTAlipayRequestHandler.h"
#import <AlipaySDK/AlipaySDK.h>

@interface GTAlipayManager () <GTAbsThirdPlatformRespManagerDelegate>
@end

@implementation GTAlipayManager

DEF_SINGLETON

- (void)thirdPlatConfigWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 子类实现
}

/**
 第三方平台处理URL
 */
- (BOOL)thirdPlatCanOpenUrlWithApplication:(UIApplication *)application
                                   openURL:(NSURL *)url
                         sourceApplication:(NSString *)sourceApplication
                                annotation:(id)annotation {
    // 支付宝
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            [[GTAlipayRespManager sharedInstance] setResponse:resultDic];
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            [[GTAlipayRespManager sharedInstance] setResponse:resultDic];
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
        return YES;
    }
    return NO;
}

/**
 第三方支付
 */
- (void)payWithPlateform:(GTThirdPlatformType)payMethodType order:(OrderModel*)order paymentBlock:(void (^)(GTPayResult result))paymentBlock {
    self.paymentBlock = paymentBlock;
    // 使用支付宝支付
    [GTAlipayRespManager sharedInstance].delegate = self;
    [GTAlipayRequestHandler payWithOrder:order];
}

@end
