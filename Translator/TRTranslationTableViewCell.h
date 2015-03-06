//
//  TRTranslationTableViewCell.h
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRTranslationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fromLabelLanguage;
@property (weak, nonatomic) IBOutlet UILabel *fromLabelText;
@property (weak, nonatomic) IBOutlet UILabel *toLabelLanguage;
@property (weak, nonatomic) IBOutlet UILabel *toLabelText;

@end