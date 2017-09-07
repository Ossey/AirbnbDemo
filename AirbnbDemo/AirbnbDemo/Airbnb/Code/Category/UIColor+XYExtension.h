//
//  UIColor+XYExtension.h
//  AirbnbDemo
//
//  Created by Swae on 07/09/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XYExtension)

+ (instancetype)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;
+ (instancetype)colorWithHex:(NSInteger)hex;

+ (UIColor *)base10;
+ (UIColor *)base20;
+ (UIColor *)base30;
+ (UIColor *)base50;
+ (UIColor *)base70;
+ (UIColor *)base80;
+ (UIColor *)base90;
+ (UIColor *)base100;
+ (UIColor *)red30;
+ (UIColor *)red50;
+ (UIColor *)yellow50;
+ (UIColor *)green50;
+ (UIColor *)blue10;
+ (UIColor *)blue50;
+ (UIColor *)mesophere;
+ (UIColor *)thermosphere;
+ (UIColor *)stratosphere;
+ (UIColor *)exosphere;
+ (UIColor *)accent;
+ (UIColor *)sunsetRed;
+ (UIColor *)accent10;
+ (UIColor *)amate;
+ (UIColor *)parchment;
+ (UIColor *)papyrus;
+ (UIColor *)masi;
+ (UIColor *)kraft;
+ (UIColor *)osage;
+ (UIColor *)masi60PercentAlpha;
+ (UIColor *)black50PercentAlpha;
+ (UIColor *)black75PercentAlpha;
+ (UIColor *)xy_darkGray;
+ (UIColor *)xy_lightGray;
+ (UIColor *)xy_gray;
+ (UIColor *)xy_lighterGray;
+ (UIColor *)xy_lightestGray;
+ (UIColor *)xy_darkBlue;
+ (UIColor *)xy_blue;
+ (UIColor *)xy_lightBlue;
+ (UIColor *)xy_green;
+ (UIColor *)xy_lightGreen;
+ (UIColor *)xy_red;
+ (UIColor *)xy_lightRed;
+ (UIColor *)xy_yellow;
+ (UIColor *)xy_lightYellow ;
+ (UIColor *)xy_orange;
+ (UIColor *)xy_purple;
+ (UIColor *)xy_lightPurple;
- (NSString *)xy_hexStringIncludingAlpha:(BOOL)includeAlpha;
- (NSString *)xy_hexString;
@end
