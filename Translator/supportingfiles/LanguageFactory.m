//
//  LanguageFactory.m
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import "LanguageFactory.h"

@implementation LanguageFactory

+ (LanguageFactory	*)languageWithLanguage:(SupportedLanguage)chosenLanguage {
	return [[LanguageFactory alloc] initWithLanguage:chosenLanguage];
}

-(id)initWithLanguage:(SupportedLanguage)chosenLanguage {
	if(self = [super init]) {
		switch (chosenLanguage) {

			case languageDutch:
				_languageUserFriendlyName = @"Dutch";
				_languageRegionCode = @"nl";
				_language = languageDutch;
				break;

			case languageEnglish:
				_languageUserFriendlyName = @"English";
				_languageRegionCode = @"en";
				_language = languageEnglish;
				break;

			case languageGerman:
				_languageUserFriendlyName = @"German";
				_languageRegionCode = @"de";
				_language = languageGerman;
				break;

			case languageItalian:
				_languageUserFriendlyName = @"Italian";
				_languageRegionCode = @"it";
				_language = languageItalian;
				break;

			case languageSpanish:
				_languageUserFriendlyName = @"Spanish";
				_languageRegionCode = @"es";
				_language = languageSpanish;
				break;

			case languageFrench:
				_languageUserFriendlyName = @"French";
				_languageRegionCode = @"fr";
				_language = languageFrench;
				break;

			default:
				break;
		}
	}
	return self;
}

@end