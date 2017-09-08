//
//  NSBundle+XYLocalization.h
//  AirbnbDemo
//
//  Created by Swae on 07/09/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSBundle *XYBundle(void);
FOUNDATION_EXPORT NSBundle *XYDefaultLocaleBundle(void);
#define XYDefaultLocalizedValue(key) \
[XYDefaultLocaleBundle() localizedStringForKey:key value:@"" table:@"Localizable"]

#define XYLocalizedString(key, comment) \
[XYBundle() localizedStringForKey:(key) value:XYDefaultLocalizedValue(key) table:@"Localizable"]

#define XYLocalizedStringFromNumber(number) \
[NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterNoStyle]

/**
 * 国际化语言
 *
 * @param   key  需要国际化的文本的key
 * @param   appLanguage  app语言
 * @param   bundle  文件所在的bundle
 * @return  comment 对该文本的描述(注释)
 */
FOUNDATION_EXPORT NSString *XYLocalizedStringWithDefaultValue(
                                            NSString *key,
                                            NSString *_Nullable appLanguage,
                                            NSBundle *_Nullable bundle,
                                            NSString *value,
                                            NSString *_Nullable comment);

FOUNDATION_EXPORT NSString *XYLocalizedStringWithValue(NSString *key,
                                                       NSString *_Nullable comment);

@interface NSBundle (XYLocalization)

@property (class, readonly, strong) NSBundle *xy_localizationBundle;

+ (NSString *)twnLocalizationsDirectory;

@end

NS_ASSUME_NONNULL_END
