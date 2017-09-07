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

@end

@implementation XYColors

@end
