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
    return [NSBundle bundleWithIdentifier:@"com.ossey.AirbnbDemo"] ?: [NSBundle mainBundle];
}

+ (nonnull NSMutableDictionary *)xy_languageBundles {
    static dispatch_once_t onceToken;
    static NSMutableDictionary *xy_languageBundles;
    dispatch_once(&onceToken, ^{
        xy_languageBundles = [NSMutableDictionary new];
    });
    return xy_languageBundles;
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

@end

NSString *XYLocalizedString(NSString *key) {
    return XYLocalizedStringWithComment(key, nil);
}

NSString *XYLocalizedStringWithComment(NSString *key, NSString *_Nullable comment) {
    return XYLocalizedStringWithDefaultValue(key, nil, nil, @"", comment);
}

NSString *XYLocalizedStringWithDefaultValue(NSString *key, NSString *_Nullable appLanguage, NSBundle *_Nullable bundle, NSString *value, NSString *_Nullable comment) {
    if (bundle == nil) {
        bundle = NSBundle.xy_localizationBundle;
    }
    
    NSString *translation = nil;
    if (appLanguage == nil) {
        translation = [bundle localizedStringForKey:key value:nil table:@"Localizable"];
    } else {
        NSBundle *languageBundle = [bundle xy_languageBundleForLanguage:appLanguage];
        translation = [languageBundle localizedStringForKey:key value:nil table:@"Localizable"];
    }
    
    if (!translation || [translation isEqualToString:key] || (translation.length == 0)) {
        translation = [XYDefaultLocaleBundle() localizedStringForKey:key value:value table:@"Localizable"];
    }
    
    return translation ? translation : @"";
}


NSBundle *XYBundle() {
    static NSBundle *__bundle;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __bundle = [NSBundle xy_localizationBundle];
    });
    
    return __bundle;
}

NSBundle *XYDefaultLocaleBundle() {
    static NSBundle *_defaultLocaleBundle;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [XYBundle() pathForResource:[XYBundle() objectForInfoDictionaryKey:@"CFBundleDevelopmentRegion"] ofType:@"lproj"];
        _defaultLocaleBundle = [NSBundle bundleWithPath:path];
    });
    
    return _defaultLocaleBundle;
}
