//
//  GTBaseThirdPlatformRespManager.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "GTBaseThirdPlatformRespManager.h"

@interface GTBaseThirdPlatformRespManager () {
    __weak id<GTAbsThirdPlatformRespManagerDelegate> _delegate;
}
@end

@implementation GTBaseThirdPlatformRespManager

- (void)setDelegate:(id<GTAbsThirdPlatformRespManagerDelegate>)delegate {
    _delegate = delegate;
}

- (id<GTAbsThirdPlatformRespManagerDelegate>)delegate {
    return _delegate;
}

@end
