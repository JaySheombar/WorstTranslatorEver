//
//  LanguageFactory.h
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageFactory : NSObject

@property (nonatomic) NSString *languageUserFriendlyName;
@property (nonatomic) NSString *languageRegionCode;
@property (nonatomic) SupportedLanguage language;

+ (LanguageFactory	*)languageWithLanguage:(SupportedLanguage)chosenLanguage;

@end