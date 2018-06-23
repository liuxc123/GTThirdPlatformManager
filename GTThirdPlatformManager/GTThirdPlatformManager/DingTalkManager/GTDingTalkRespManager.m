//
//  GTDingTalkRespManager.m
//  GTThirdPlatformKit_Example
//
//  Created by liuxc on 2018/6/2.
//  Copyright © 2018年 liuxc123. All rights reserved.
//

#import "GTDingTalkRespManager.h"

@implementation GTDingTalkRespManager

DEF_SINGLETON

/**
 第三方APP使用 +[DTOpenAPI sendReq:] 向钉钉发送消息后, 钉钉会处理完请求后会回调该接口.
 
 @param resp 来自钉钉具体的响应.
 */
- (void)onResp:(DTBaseResp *)resp {
    if (DTOpenAPISuccess == resp.errorCode) {
        [self.delegate respManagerDidRecvMessageResponse:YES platform:GTShareTypeDingTalk];
    } else {
        [self.delegate respManagerDidRecvMessageResponse:NO platform:GTShareTypeDingTalk];
    }
}

@end
