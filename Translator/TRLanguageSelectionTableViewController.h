//
//  TRLanguageSelectionTableViewController.h
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRCoreDataObject.h"
#import "Languages.h"

@protocol TRLanguageSelectionTableViewControllerDelegate;

@interface TRLanguageSelectionTableViewController : UITableViewController

@property (nonatomic) id <TRLanguageSelectionTableViewControllerDelegate> delegate;
@property (nonatomic) ButtonOption chosenButton;

@end

@protocol TRLanguageSelectionTableViewControllerDelegate <NSObject>
- (void)TRLanguageSelectionDelegateUpdate:(TRLanguageSelectionTableViewController *)selectionViewController forButton:(ButtonOption)button withLanguage:(Languages *)language;
@end