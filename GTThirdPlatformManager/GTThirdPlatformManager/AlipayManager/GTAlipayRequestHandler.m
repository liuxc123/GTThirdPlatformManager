//
//  GTAlipayRequestHandler.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "GTAlipayRequestHandler.h"
#import <AlipaySDK/AlipaySDK.h>
#import "GTAlipayRespManager.h"
#import "GTThirdPlatformObject.h"
#import "GTThirdPlatformManager.h"
@implementation GTAlipayRequestHandler

// 支付
+ (BOOL)payWithOrder:(OrderModel*)order {
    // 开始支付
    NSString* orderString = order.sign;
    NSString* appScheme = [[GTThirdPlatformManager sharedInstance] URLSchemesWithPlaform:GTThirdPlatformTypeAlipay];
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        [[GTAlipayRespManager sharedInstance] setResponse:resultDic];
    }];
    return YES;
}

@end
