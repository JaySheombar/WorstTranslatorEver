//
//  TRDetailTranslationViewController.h
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Translation.h"

@interface TRDetailTranslationViewController : UIViewController

@property (nonatomic) Translation *translation;

// UI elements
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UILabel *fromLanguageLabel;
@property (weak, nonatomic) IBOutlet UITextView *fromLanguageText;
@property (weak, nonatomic) IBOutlet UILabel *toLanguageLabel;
@property (weak, nonatomic) IBOutlet UITextView *toLanguageText;

@property (weak, nonatomic) IBOutlet UIImageView *FromImageView;
@property (weak, nonatomic) IBOutlet UIImageView *toImageView;

@end