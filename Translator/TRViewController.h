//
//  TRViewController.h
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRLanguageSelectionTableViewController.h"
#import "TRDetailTranslationViewController.h"
#import "TRTranslationModel.h"
#import "TRTranslationTableViewCell.h"
#import "Languages.h"

@interface TRViewController : UIViewController <TRLanguageSelectionTableViewControllerDelegate, TRTranslationDelegate, UITextViewDelegate , UITableViewDelegate, UITableViewDataSource>

// Buttons
@property (weak, nonatomic) IBOutlet UIButton *fromLanguageButton;
@property (weak, nonatomic) IBOutlet UIButton *toLanguageButton;
@property (weak, nonatomic) IBOutlet UIButton *switchLanguagesButton;

// Input
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

// Output
@property (weak, nonatomic) IBOutlet UITableView *outputTableView;

// Spinner when loading
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end