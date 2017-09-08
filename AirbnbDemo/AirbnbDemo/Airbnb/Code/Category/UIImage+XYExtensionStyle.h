//
//  UIImage+XYExtensionStyle.h
//  AirbnbDemo
//
//  Created by Swae on 08/09/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XYExtensionStyle)

+ (instancetype)xy_imageFromColor:(UIColor *)color;
- (UIImage *)xy_changeImageColorWithColor:(UIColor *)color;
+ (UIImage *)xy_imageFlippedForRTLLayoutDirectionNamed:(NSString *)name;

@end
