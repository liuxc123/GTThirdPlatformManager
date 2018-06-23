//
//  UIImage+GTUtil.m
//  GTThirdPlatformKit
//
//  Created by liuxc on 2018/6/2.
//

#import "UIImage+GTUtil.h"

@implementation UIImage (GTUtil)

- (UIImage *)scaletoScale:(float)scaleSize {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width*scaleSize, self.size.height*scaleSize), NO, [UIScreen mainScreen].bounds.size.width);
    [self drawInRect:CGRectMake(0, 0, self.size.width*scaleSize, self.size.height*scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
