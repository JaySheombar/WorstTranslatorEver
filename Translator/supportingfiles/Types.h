//
//  Types.h
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#define GERMANFLAGURL @"http://www.saultcareercentre.ca/wp-content/gallery/german-and-polish-flags/germany-flag.jpg"
#define DUTCHFLAGURL @"http://www.umu.se/digitalAssets/60/60448_holland-flag.jpg"
#define ENGLISHFLAGURL @"http://www.flags.net/images/largeflags/UNKG0100.GIF"
#define SPANISHFLAGURL @"http://0.tqn.com/d/gospain/1/0/r/H/-/-/Spain_flag.gif"
#define ITALIANFLAGURL @"http://upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/225px-Flag_of_Italy.svg.png"
#define FRENCHFLAGURL @"http://3.bp.blogspot.com/-RyhgKkN0rJ8/T-NrbCepQDI/AAAAAAAAAvs/JFPWe5F5pLo/s1600/french_flag.jpeg"
#define API_URL @"http://api.mymemory.translated.net/get"

#define CORE_DATA_ENTITY_LANGUAGE @"Languages"
#define CORE_DATA_ENTITY_TRANSLATION @"Translation"

#define kBoarderWidth 2.0

#ifndef Translator_Types_h
#define Translator_Types_h

typedef enum {
	languageDutch = 0,
	languageEnglish,
	languageGerman,
	languageItalian,
	languageSpanish,
	languageFrench,
	languageCount
}SupportedLanguage;

typedef enum{
	ButtonOptionTo,
	ButtonOptionFrom
}ButtonOption;

#endif