//
//  TRLanguagesModel.m
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import "TRLanguagesModel.h"

@implementation TRLanguagesModel

- (void)firstStartup {
	if([self getCoreDataWithEntityName:@"Languages"].count == 0) {
		[self setDefaultLanguages];
		[self save];
	}
}

- (void)setDefaultLanguages {
	for(NSUInteger i = 0; i < languageCount; i++) {
		LanguageFactory *myLanguagesFactory = [LanguageFactory languageWithLanguage:((SupportedLanguage)i)];
		Languages *language = [NSEntityDescription insertNewObjectForEntityForName:@"Languages" inManagedObjectContext:self.context];
		[language setLanguageName:myLanguagesFactory.languageUserFriendlyName];
		[language setLanguageRegionCode:myLanguagesFactory.languageRegionCode];
		[language setLanguage:[NSNumber numberWithInt:myLanguagesFactory.language]];
	}
}

@end