//
//  GTWXRequestHandler.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "GTWXRequestHandler.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "GTWXRespManager.h"
#import "UIImage+GTUtil.h"
#import "GTThirdPlatformObject.h"

static NSString *kAuthScope = @"snsapi_userinfo";
static NSString *kAuthOpenID = @"0c806938e2413ce73eef92cc3";

@implementation GTWXRequestHandler

+ (BOOL)sendAuthInViewController:(UIViewController *)viewController {
    
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = kAuthScope;
    req.state = kAuthOpenID;
    
    return [WXApi sendAuthReq:req
               viewController:viewController
                     delegate:[GTWXRespManager sharedInstance]];
    
}

+ (BOOL)payWithOrder:(OrderModel *)order {
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = order.partnerid;
    req.prepayId            = order.prepayid;
    req.nonceStr            = order.noncestr;
    req.timeStamp           = order.timestamp;
    req.package             = order.package;
    req.sign                = order.sign;
    BOOL result = [WXApi sendReq:req];
    
    return result;
}

// 分享
+ (BOOL)sendMessageWithModel:(ThirdPlatformShareModel*)model {
    enum WXScene wxScene = 0;
    if (GTShareTypeWechat == model.platform) {
        wxScene = WXSceneSession;
    } else if (GTShareTypeWechatLine == model.platform) {
        wxScene = WXSceneTimeline;
    }
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.scene = wxScene;
    req.bText = NO;
    WXMediaMessage* msg = [[WXMediaMessage alloc] init];
    msg.title = model.title;
    msg.description = model.text;
    [msg setThumbImage:[self scaledImageWithOriImage:model.image]];
    
    if (GTShareContentTypeVideo == model.mediaObject.contentType) {
        WXVideoObject* videoObj = [WXVideoObject object];
        videoObj.videoUrl = model.urlString;
        msg.mediaObject = videoObj;
    } else {
        if (model.urlString && model.urlString.length>0) {
            WXWebpageObject* webPageObj = [WXWebpageObject object];
            webPageObj.webpageUrl = model.urlString;
            msg.mediaObject = webPageObj;
        }
    }
    
    req.message = msg;
    BOOL result = [WXApi sendReq:req];
    return result;
}

+ (UIImage*)scaledImageWithOriImage:(UIImage*)oriImage {
    NSInteger maxSharedImageBytes = 32*1000;//32K
    NSInteger oriImageBytes = UIImageJPEGRepresentation(oriImage, 1.0).length;
    if (oriImageBytes > maxSharedImageBytes) {
        CGFloat scaleFactor = maxSharedImageBytes * 1.0f / oriImageBytes * 1.0f;
        UIImage* scaledImage = [oriImage scaletoScale:scaleFactor];
        if (scaledImage) {
            return scaledImage;
        }
    }
    return oriImage;
}


@end
