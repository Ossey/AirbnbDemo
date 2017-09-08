//
//  XYTheme.h
//  AirbnbDemo
//
//  Created by Swae on 07/09/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYTheme;

@protocol XYThemeable <NSObject>

- (void)applyTheme:(XYTheme *)theme;

@end


@interface XYColors : NSObject

@property (nonatomic, strong) UIColor *baseBackground;
@property (nonatomic, strong) UIColor *midBackground;
@property (nonatomic, strong) UIColor *subCellBackground;
@property (nonatomic, strong) UIColor *paperBackground;

@property (nonatomic, strong) UIColor *popoverBackground;
@property (nonatomic, strong) UIColor *chromeBackground;
@property (nonatomic, strong) UIColor *overlayBackground;

@property (nonatomic, strong) UIColor *primaryText;
@property (nonatomic, strong) UIColor *secondaryText;

@property (nonatomic, strong) UIColor *tertiaryText;
@property (nonatomic, strong) UIColor *disabledText;
@property (nonatomic, strong) UIColor *link;
@property (nonatomic, strong) UIColor *chromeText;
@property (nonatomic, strong) UIColor *accent;
@property (nonatomic, strong) UIColor *secondaryAction;
@property (nonatomic, strong) UIColor *destructive;

@property (nonatomic, strong) UIColor *warning;

@property (nonatomic, strong) UIColor *error;
@property (nonatomic, strong) UIColor *unselected;
@property (nonatomic, strong) UIColor *border;
@property (nonatomic, strong) UIColor *shadow;

@property (nonatomic, strong) UIColor *icon;
@property (nonatomic, strong) UIColor *iconBackground;
@property (nonatomic, strong) UIColor *keyboardBarSearchFieldBackground;

@property (nonatomic, strong) UIColor *linkToAccent;

@property (nonatomic, class, strong, readonly) XYColors *light;
@property (nonatomic, class, strong, readonly) XYColors *sepia;
@property (nonatomic, class, strong, readonly) XYColors *dark;
@property (nonatomic, class, strong, readonly) XYColors *widgetiOS9;
@property (nonatomic, class, strong, readonly) XYColors *widget;


@end

@interface XYTheme : NSObject

@property (nonatomic, strong) XYColors * colors;
@property (nonatomic, assign) UIStatusBarStyle preferredStatusBarStyle;
@property (nonatomic, assign) UIBlurEffectStyle blurEffectStyle;
@property (nonatomic, assign) UIKeyboardAppearance keyboardAppearance;
@property (nonatomic, assign) UIImage *searchBarBackgroundImage;
@property (nonatomic, assign) CGFloat imageOpacity;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *displayName;

@property (nonatomic, class, strong) XYTheme *standard;

@end
