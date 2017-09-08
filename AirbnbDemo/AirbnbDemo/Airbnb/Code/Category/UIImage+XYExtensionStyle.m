//
//  UIImage+XYExtensionStyle.m
//  AirbnbDemo
//
//  Created by Swae on 08/09/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import "UIImage+XYExtensionStyle.h"

@implementation UIImage (XYExtensionStyle)

+ (instancetype)xy_imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)xy_imageFlippedForRTLLayoutDirectionNamed:(NSString *)name {
    return [[UIImage imageNamed:name] imageFlippedForRightToLeftLayoutDirection];
}

- (UIImage *)xy_changeImageColorWithColor:(UIColor *)color {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
