//
//  XYTheme.m
//  AirbnbDemo
//
//  Created by Swae on 07/09/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import "XYTheme.h"

@interface XYTheme ()

@end

@implementation XYTheme

@dynamic standard;

- (instancetype)initWithColors:(XYColors *)colors preferredStatusBarStyle:(UIStatusBarStyle)preferredStatusBarStyle blurEffectStyle:(UIBlurEffectStyle)blurEffectStyle keyboardAppearance:(UIKeyboardAppearance)keyboardAppearance imageOpacity:(CGFloat)imageOpacity searchBarBackgroundImage:(UIImage *)searchBarBackgroundImage name:(NSString *)name displayName:(NSString *)displayName {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.colors = colors;
    self.preferredStatusBarStyle = preferredStatusBarStyle;
    self.blurEffectStyle = blurEffectStyle;
    self.keyboardAppearance = keyboardAppearance;
    self.imageOpacity = imageOpacity;
    self.name = name;
    self.displayName = displayName;
    self.searchBarBackgroundImage = searchBarBackgroundImage;
    
    return self;
}

+ (XYTheme *)light {
    static XYTheme *theme = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theme = [[self alloc] initWithColors:[XYColors light] preferredStatusBarStyle:UIStatusBarStyleDefault blurEffectStyle:UIBlurEffectStyleLight keyboardAppearance:UIKeyboardAppearanceLight imageOpacity:1.0 searchBarBackgroundImage:nil name:@"standard" displayName:XYLocalizedString(@"", @"")];
    });
    return theme;
}

+ (XYTheme *)standard {
    return [self light];
}

@end

@implementation XYColors

@dynamic light, sepia, dark, widgetiOS9;

+ (XYColors *)light {
    static XYColors *colors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colors = [self new];
        colors.baseBackground = [UIColor base80];
        colors.midBackground = [UIColor base90];
        colors.paperBackground = [UIColor base100];
        colors.chromeBackground = [UIColor base100];
        colors.popoverBackground = [UIColor base100];
        colors.subCellBackground = [UIColor base100];
        colors.primaryText = [UIColor base10];
        colors.secondaryText = [UIColor base30];
        colors.tertiaryText = [UIColor base70];
        colors.disabledText = [UIColor base30];
        colors.chromeText = [UIColor base20];
        colors.link = [UIColor blue50];
        colors.accent = [UIColor green50];
        colors.border = [UIColor base70];
        colors.shadow = [UIColor base80];
        colors.secondaryAction = [UIColor blue10];
        colors.icon = nil;
        colors.iconBackground = nil;
        colors.destructive = [UIColor red50];
        colors.error = [UIColor red50];
        colors.warning = [UIColor yellow50];
        colors.unselected = [UIColor base50];
    });
    
    return colors;
}

+ (XYColors *)sepia {
    static XYColors *colors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colors = [self new];
        colors.baseBackground = [UIColor amate];
        colors.midBackground = [UIColor papyrus];
        colors.paperBackground = [UIColor parchment];
        colors.chromeBackground = [UIColor parchment];
        colors.popoverBackground = [UIColor base100];
        colors.subCellBackground = [UIColor papyrus];
        colors.primaryText = [UIColor base10];
        colors.secondaryText = [UIColor masi];
        colors.tertiaryText = [UIColor masi];
        colors.disabledText = [UIColor base30];
        colors.chromeText = [UIColor base20];
        colors.link = [UIColor blue50];
        colors.accent = [UIColor green50];
        colors.border = [UIColor kraft];
        colors.shadow = [UIColor kraft];
        colors.secondaryAction = [UIColor accent10];
        colors.icon = [UIColor masi];
        colors.iconBackground = [UIColor amate];
        colors.destructive = [UIColor red30];
        colors.error = [UIColor red30];
        colors.warning = [UIColor osage];
        colors.unselected = [UIColor masi];
    });
    
    return colors;
}

+ (XYColors *)dark {
    static XYColors *colors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colors = [self new];
        colors.baseBackground = [UIColor base10];
        colors.midBackground = [UIColor exosphere];
        colors.paperBackground = [UIColor thermosphere];
        colors.chromeBackground = [UIColor mesophere];
        colors.popoverBackground = [UIColor base10];
        colors.subCellBackground = [UIColor exosphere];
        colors.overlayBackground = [UIColor black50PercentAlpha];
        colors.keyboardBarSearchFieldBackground = [UIColor thermosphere];
        colors.primaryText = [UIColor base90];
        colors.secondaryText = [UIColor base70];
        colors.tertiaryText = [UIColor base70];
        colors.disabledText = [UIColor base70];
        colors.chromeText = [UIColor base90];
        colors.link = [UIColor stratosphere];
        colors.accent = [UIColor green50];
        colors.border = [UIColor mesophere];
        colors.shadow = [UIColor base10];
        colors.secondaryAction = [UIColor accent10];
        colors.icon = [UIColor base70];
        colors.iconBackground = [UIColor exosphere];
        colors.destructive = [UIColor sunsetRed];
        colors.error = [UIColor sunsetRed];
        colors.warning = [UIColor yellow50];
        colors.unselected = [UIColor base70];
    });
    
    return colors;
}

+ (XYColors *)widgetiOS9 {
    static XYColors *colors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colors = [self new];
        colors.baseBackground = [UIColor clearColor];
        colors.midBackground = [UIColor clearColor];
        colors.paperBackground = [UIColor clearColor];
        colors.chromeBackground = [UIColor clearColor];
        colors.popoverBackground = [UIColor clearColor];
        colors.subCellBackground = [UIColor clearColor];
        colors.overlayBackground = [UIColor colorWithWhite:0.3 alpha:0.3];
        colors.keyboardBarSearchFieldBackground = [UIColor thermosphere];
        colors.primaryText = [UIColor base90];
        colors.secondaryText = [UIColor base70];
        colors.tertiaryText = [UIColor base70];
        colors.disabledText = [UIColor base70];
        colors.chromeText = [UIColor base90];
        colors.link = [UIColor stratosphere];
        colors.accent = [UIColor green50];
        colors.border = [UIColor mesophere];
        colors.shadow = [UIColor base10];
        colors.secondaryAction = [UIColor accent10];
        colors.icon = [UIColor base70];
        colors.iconBackground = [UIColor exosphere];
        colors.destructive = [UIColor sunsetRed];
        colors.error = [UIColor sunsetRed];
        colors.warning = [UIColor yellow50];
        colors.unselected = [UIColor base70];
    });
    
    return colors;
}

+ (XYColors *)widget {
    static XYColors *colors = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colors = [self new];
        colors.baseBackground = [UIColor clearColor];
        colors.midBackground = [UIColor clearColor];
        colors.paperBackground = [UIColor clearColor];
        colors.chromeBackground = [UIColor clearColor];
        colors.popoverBackground = [UIColor clearColor];
        colors.subCellBackground = [UIColor clearColor];
        colors.overlayBackground = [UIColor colorWithWhite:1.0 alpha:0.4];
        colors.keyboardBarSearchFieldBackground = [UIColor base80];
        colors.primaryText = [UIColor base10];
        colors.secondaryText = [UIColor base20];
        colors.tertiaryText = [UIColor base20];
        colors.disabledText = [UIColor base30];
        colors.chromeText = [UIColor base20];
        colors.link = [UIColor blue50];
        colors.accent = [UIColor green50];
        colors.border = [UIColor colorWithWhite:0.0 alpha:0.10];
        colors.shadow = [UIColor base80];
        colors.secondaryAction = [UIColor blue10];
        colors.icon = nil;
        colors.iconBackground = nil;
        colors.destructive = [UIColor red50];
        colors.error = [UIColor red50];
        colors.warning = [UIColor yellow50];
        colors.unselected = [UIColor base70];
    });
    
    return colors;
}

@end
