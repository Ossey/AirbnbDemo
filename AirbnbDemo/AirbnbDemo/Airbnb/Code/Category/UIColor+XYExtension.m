//
//  UIColor+XYExtension.m
//  AirbnbDemo
//
//  Created by Swae on 07/09/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import "UIColor+XYExtension.h"

@implementation UIColor (XYExtension)

+ (instancetype)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha {
    CGFloat r = (CGFloat)((hex & 0xFF0000 ) >> 16) / 255.0;
    CGFloat g = (CGFloat)((hex & 0xFF00) >> 8) / 255.0;
    CGFloat b = (CGFloat)((hex & 0xFF) / 255.0);
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

+ (instancetype)colorWithHex:(NSInteger)hex {
    return [self colorWithHex:hex alpha:1.0];
}



+ (UIColor *)base10 {
    return [UIColor colorWithHex:0x222222];
}

+ (UIColor *)base20 {
    return [UIColor colorWithHex:0x54595D];
}

+ (UIColor *)base30 {
    return [UIColor colorWithHex:0x72777D];
}

+ (UIColor *)base50 {
    return [UIColor colorWithHex:0xA2A9B1];
}

+ (UIColor *)base70 {
    return [UIColor colorWithHex:0xC8CCD1];
}

+ (UIColor *)base80 {
    return [UIColor colorWithHex:0xEAECF0];
}

+ (UIColor *)base90 {
    return [UIColor colorWithHex:0xF8F9FA];
}

+ (UIColor *)base100 {
    return [UIColor colorWithHex:0xFFFFFF];
}

+ (UIColor *)red30 {
    return [UIColor colorWithHex:0xB32424];
}


+ (UIColor *)red50 {
    return [UIColor colorWithHex:0xCC3333];
}


+ (UIColor *)yellow50 {
    return [UIColor colorWithHex:0xFFCC33];
}


+ (UIColor *)green50 {
    return [UIColor colorWithHex:0x00AF89];
}


+ (UIColor *)blue10 {
    return [UIColor colorWithHex:0x2A4B8D];
}

+ (UIColor *)blue50 {
    return [UIColor colorWithHex:0x3366CC];
}
+ (UIColor *)mesophere {
    return [UIColor colorWithHex:0x2E3136];
}
+ (UIColor *)thermosphere {
    return [UIColor colorWithHex:0x2A4B8D];
}
+ (UIColor *)stratosphere {
    return [UIColor colorWithHex:0x6699FF];
}

+ (UIColor *)exosphere {
    return [UIColor colorWithHex:0x27292D];
}

+ (UIColor *)accent {
    return [UIColor colorWithHex:0x00AF89];
}

+ (UIColor *)sunsetRed {
    return [UIColor colorWithHex:0xFF6E6E];
}

+ (UIColor *)accent10 {
    return [UIColor colorWithHex:0x2A4B8D];
}
+ (UIColor *)amate {
    return [UIColor colorWithHex:0xE1DAD1];
}

+ (UIColor *)parchment {
    return [UIColor colorWithHex:0xF8F1E3];
}

+ (UIColor *)papyrus {
    return [UIColor colorWithHex:0xF0E6D6];
}

+ (UIColor *)masi {
    return [UIColor colorWithHex:0x646059];
}


+ (UIColor *)kraft {
    return [UIColor colorWithHex:0xCBC8C1];
}


+ (UIColor *)osage {
    return [UIColor colorWithHex:0xFF9500];
}

+ (UIColor *)masi60PercentAlpha {
    return [UIColor colorWithHex:0x646059 alpha:0.6];
}


+ (UIColor *)black50PercentAlpha {
    return [UIColor colorWithHex:0x000000 alpha:0.5];
}

+ (UIColor *)black75PercentAlpha {
    return [UIColor colorWithHex:0x000000 alpha:0.75];
}

+ (UIColor *)xy_darkGray {
    return [UIColor colorWithHex:0x4D4D4B];
}

+ (UIColor *)xy_lightGray {
    return [UIColor colorWithHex:0x9AA0A7];
}

+ (UIColor *)xy_gray {
    return [UIColor base70];
}

+ (UIColor *)xy_lighterGray {
    return [UIColor base80];
}

+ (UIColor *)xy_lightestGray {
    return [UIColor colorWithHex:0xF5F5F5];
}

+ (UIColor *)xy_darkBlue {
    return [UIColor blue10];
}


+ (UIColor *)xy_blue {
    return [UIColor blue50];
}

+ (UIColor *)xy_lightBlue {
    return [UIColor colorWithHex:0xEAF3FF];
}


+ (UIColor *)xy_green {
    return [UIColor green50];
}

+ (UIColor *)xy_lightGreen {
    return [UIColor colorWithHex:0xD5FDF4];
}


+ (UIColor *)xy_red {
    return [UIColor red50];
}


+ (UIColor *)xy_lightRed {
    return [UIColor colorWithHex:0xFFE7E6];
}


+ (UIColor *)xy_yellow {
    return [UIColor yellow50];
}

+ (UIColor *)xy_lightYellow {
    return [UIColor colorWithHex:0xFEF6E7];
}

+ (UIColor *)xy_orange {
    return [UIColor colorWithHex:0xFF5B00];
}

+ (UIColor *)xy_purple {
    return [UIColor colorWithHex:0x7F4AB3];
}

+ (UIColor *)xy_lightPurple {
    return [UIColor colorWithHex:0xF3E6FF];
}

- (NSString *)xy_hexStringIncludingAlpha:(BOOL)includeAlpha {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    NSString *hexString = [NSString stringWithFormat:@"%02f%02f%02f", 255.0 * r, 255.0 * g, 255.0 * b];
    if (includeAlpha) {
        hexString = [hexString stringByAppendingFormat:@"%02f", 255.0 * a];
    }
    return hexString;
}

- (NSString *)xy_hexString {
    return [self xy_hexStringIncludingAlpha:NO];
}

@end
