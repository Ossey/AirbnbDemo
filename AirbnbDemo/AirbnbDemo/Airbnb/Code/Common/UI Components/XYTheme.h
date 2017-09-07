//
//  XYTheme.h
//  AirbnbDemo
//
//  Created by Swae on 07/09/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XYColors : NSObject

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

@end
