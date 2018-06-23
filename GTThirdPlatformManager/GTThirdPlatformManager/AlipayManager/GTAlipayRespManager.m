//
//  GTAlipayRespManager.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "GTAlipayRespManager.h"

@implementation GTAlipayRespManager

DEF_SINGLETON

- (void)setResponse:(NSDictionary *)response {
    // 解析 resultStatus
    NSString* resultStatusStr = [response objectForKey:@"resultStatus"];
    NSInteger resultStatus = 0;
    if ([resultStatusStr respondsToSelector:@selector(integerValue)]) {
        resultStatus = [resultStatusStr integerValue];
    }
    GTPayResult payResult = (resultStatus == 9000) ? GTPayResultSuccess : (resultStatus == 6001) ? GTPayResultCancel : GTPayResultFailed ;
    if ([self.delegate respondsToSelector:@selector(respManagerDidRecvPayResponse:platform:)]) {
        [self.delegate respManagerDidRecvPayResponse:payResult platform:GTThirdPlatformTypeAlipay];
    }
}

@end
