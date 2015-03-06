//
//  TRTranslationModel.h
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import "TRCoreDataObject.h"
#import "Translation.h"
#import "Languages.h"

@protocol TRTranslationDelegate;

@interface TRTranslationModel : TRCoreDataObject <NSURLConnectionDelegate>

@property (nonatomic) id <TRTranslationDelegate> delegate;
- (void)translate:(NSString *)text fromLanguage:(Languages *)fromLanguage toLanguage:(Languages *)toLanguage;
- (NSArray *)getTranslationsOrderedByDate;
- (void)readTranslations;
@end

@protocol TRTranslationDelegate <NSObject>

- (void)TRTranslationDelegateTranslationComplete:(TRTranslationModel *)translationModel;

@end