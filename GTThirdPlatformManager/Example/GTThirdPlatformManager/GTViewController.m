//
//  GTViewController.m
//  GTThirdPlatformManager
//
//  Created by liuxc123 on 06/23/2018.
//  Copyright (c) 2018 liuxc123. All rights reserved.
//

#import "GTViewController.h"
#import <GTThirdPlatformKit.h>

@interface GTViewController ()

@end

@implementation GTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    typeof(self) __weak weakSelf = self;
    [self addActionWithName:@"QQ登录Demo" callback:^{
        [[GTThirdPlatformManager sharedInstance] signInWithType:GTThirdPlatformTypeTencentQQ fromViewController:weakSelf callback:^(ThirdPlatformUserInfo *userInfo, NSError *err) {
            
        }];
    }];
    
    [self addActionWithName:@"微信登录Demo" callback:^{
        [[GTThirdPlatformManager sharedInstance] signInWithType:GTThirdPlatformTypeWechat fromViewController:weakSelf callback:^(ThirdPlatformUserInfo *userInfo, NSError *err) {
            
        }];
    }];
    
    [self addActionWithName:@"微博登录Demo" callback:^{
        [[GTThirdPlatformManager sharedInstance] signInWithType:GTThirdPlatformTypeWeibo fromViewController:weakSelf callback:^(ThirdPlatformUserInfo *userInfo, NSError *err) {
            
        }];
    }];
    
    [self addActionWithName:@"支付宝登录Demo" callback:^{
        [[GTThirdPlatformManager sharedInstance] signInWithType:GTThirdPlatformTypeAlipay fromViewController:weakSelf callback:^(ThirdPlatformUserInfo *userInfo, NSError *err) {
            
        }];
    }];
    // 分享模型
    ThirdPlatformShareModel* shareModel = [[ThirdPlatformShareModel alloc] init];
    shareModel.image = nil;
    shareModel.imageUrlString = @"";
    shareModel.title = @"title";
    shareModel.text = @"text";
    shareModel.weiboText = @"weibo text";
    shareModel.urlString = @"http://www.baidu.com";
    shareModel.fromViewController = self;
    shareModel.shareResultBlock = ^(GTShareType pplatform, GTShareResult result, NSError * error) {
        
    };
    
    
    [self addActionWithName:@"微信分享Demo" callback:^{
        shareModel.platform = GTShareTypeWechat;
        [[GTThirdPlatformManager sharedInstance] shareWithModel:shareModel];
    }];
    
    [self addActionWithName:@"微信朋友圈分享Demo" callback:^{
        shareModel.platform = GTShareTypeWechat;
        [[GTThirdPlatformManager sharedInstance] shareWithModel:shareModel];
    }];
    
    [self addActionWithName:@"QQ分享Demo" callback:^{
        shareModel.platform = GTShareTypeQQ;
        [[GTThirdPlatformManager sharedInstance] shareWithModel:shareModel];
    }];
    
    
    
    // 支付信息模型
    OrderModel* order = [[OrderModel alloc] init];
    [self addActionWithName:@"支付宝支付" callback:^{
        [[GTThirdPlatformManager sharedInstance] payWithPlateform:GTThirdPlatformTypeAlipay order:order paymentBlock:^(GTPayResult result) {
            
        }];
    }];
    
    [self addActionWithName:@"微信支付" callback:^{
        [[GTThirdPlatformManager sharedInstance] payWithPlateform:GTThirdPlatformTypeWechat order:order paymentBlock:^(GTPayResult result) {
            
        }];
    }];
    
    [self addActionWithName:@"QQ支付" callback:^{
        [[GTThirdPlatformManager sharedInstance] payWithPlateform:GTThirdPlatformTypeTencentQQ order:order paymentBlock:^(GTPayResult result) {
            
        }];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
