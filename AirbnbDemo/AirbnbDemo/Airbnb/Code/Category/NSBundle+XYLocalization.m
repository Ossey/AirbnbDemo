//
//  NSBundle+XYLocalization.m
//  AirbnbDemo
//
//  Created by Swae on 07/09/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import "NSBundle+XYLocalization.h"

@implementation NSBundle (XYLocalization)
+ (NSBundle *)xy_localizationBundle {
    return [NSBundle bundleWithIdentifier:@"com.ossey.AirbnbDemo"];
}

+ (nonnull NSMutableDictionary *)xy_languageBundles {
    static dispatch_once_t onceToken;
    static NSMutableDictionary *xy_languageBundles;
    dispatch_once(&onceToken, ^{
        xy_languageBundles = [NSMutableDictionary new];
    });
    return xy_languageBundles;
}

+ (NSString *)twnLocalizationsDirectory {
    return [SOURCE_ROOT_DIR stringByAppendingPathComponent:@"AirbnbDemo/AirbnbDemo/Airbnb"];
}

- (nullable NSBundle *)xy_languageBundleForLanguage:(nonnull NSString *)language {
    NSMutableDictionary *bundles = [NSBundle xy_languageBundles];
    NSString *path = [self pathForResource:language ofType:@"lproj"];
    NSBundle *bundle = bundles[path];
    if (!bundle) {
        bundle = [NSBundle bundleWithPath:path];
        if (bundle) {
            bundles[path] = bundle;
        }
    }
    return bundle;
}

- (nullable NSBundle *)xy_fallbackLanguageBundle {
    static dispatch_once_t onceToken;
    static NSBundle *xy_fallbackLanguageBundle;
    dispatch_once(&onceToken, ^{
        NSString *path = [self pathForResource:@"en" ofType:@"lproj"];
        xy_fallbackLanguageBundle = [NSBundle bundleWithPath:path];
    });
    return xy_fallbackLanguageBundle;
}

@end

NSString *XYLocalizedStringWithDefaultValue(NSString *key, NSString *_Nullable appLanguage, NSBundle *_Nullable bundle, NSString *value, NSString *_Nullable comment) {
    if (bundle == nil) {
        bundle = NSBundle.xy_localizationBundle;
    }
    
    NSString *translation = nil;
    if (appLanguage == nil) {
        translation = [bundle localizedStringForKey:key value:nil table:nil];
    } else {
        NSBundle *languageBundle = [bundle xy_languageBundleForLanguage:appLanguage];
        translation = [languageBundle localizedStringForKey:key value:nil table:nil];
    }
    
    if (!translation || [translation isEqualToString:key] || (translation.length == 0)) {
        translation = [[bundle xy_fallbackLanguageBundle] localizedStringForKey:key value:value table:nil];
    }
    
    return translation ? translation : @"";
}

NSString * getPreferredLanguage() {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    // iOS系统 本地语言是存在NSUserDefaults中的一个Key-Value；其中Value是一个数组；数组的第一个元素就是当前语言
    NSString * preferredLang = [allLanguages objectAtIndex:0];
    
    return preferredLang;
    
}
