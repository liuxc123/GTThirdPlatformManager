//
//  GTDingTalkRequestHandler.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "GTDingTalkRequestHandler.h"
#import <DTShareKit/DTOpenKit.h>
#import "GTThirdPlatformKit.h"

@implementation GTDingTalkRequestHandler


// 分享
+ (BOOL)sendMessageWithModel:(ThirdPlatformShareModel *)model {
    
    DTMediaWebObject* obj;
    obj = [[DTMediaWebObject alloc] init];
    obj.pageURL = ValueOrEmpty(model.urlString);
    
    DTMediaMessage* msg = [[DTMediaMessage alloc] init];
    msg.mediaObject = obj;
    msg.title = model.title;
    msg.thumbURL = model.imageUrlString;
    msg.messageDescription = model.text;
    
    DTSendMessageToDingTalkReq *req = [[DTSendMessageToDingTalkReq alloc] init];
    req.scene = DTSceneSession;
    req.message = msg;
    
    BOOL result = [DTOpenAPI sendReq:req];
    
    return result;
}

@end
