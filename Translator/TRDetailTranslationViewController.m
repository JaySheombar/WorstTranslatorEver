//
//  TRDetailTranslationViewController.m
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import "TRDetailTranslationViewController.h"

@interface TRDetailTranslationViewController ()

@end

@implementation TRDetailTranslationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {

	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Check if translation object wel geset is..
	if(_translation != nil) {
		// Format de date naar iets wat we begrijpen
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"dd-MM-yyyy"];
		_navigationBar.topItem.title = [NSString stringWithFormat:@"Translated on: %@", [NSString stringWithFormat:@"%@",[formatter stringFromDate:[_translation timestamp]]]];
		
		_fromLanguageLabel.text = [_translation fromLanguage];
		_fromLanguageText.text = [_translation fromText];
		
		_toLanguageLabel.text = [_translation toLanguage];
		_toLanguageText.text = [_translation toText];
		
		_FromImageView.hidden = YES;
		_toImageView.hidden = YES;
		
		// Voeg border toe
		[self addBorderOnImageView:_FromImageView];
		[self addBorderOnImageView:_toImageView];
		
		// Laad de vlag
		[self loadFlagWithImageView:_FromImageView andLanguage:_translation.fromLanguage];
		[self loadFlagWithImageView:_toImageView andLanguage:_translation.toLanguage];
	}
}

// Het multithreading gedeelte
- (void)loadFlagWithImageView:(UIImageView *)imageView andLanguage:(NSString *)language {
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
	dispatch_async(queue, ^{
		UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self getFlagURLWithLanguageName:language]]]];
		dispatch_sync(dispatch_get_main_queue(), ^{
			imageView.image = image;
			imageView.hidden = NO;
		});
	});
}

// Wat bad practise om de juiste vlag url te krijgen
- (NSString *)getFlagURLWithLanguageName:(NSString *)languageName {
	if([languageName isEqualToString:@"Dutch"]) {
		return DUTCHFLAGURL;
	}
	if([languageName isEqualToString:@"German"]) {
		return GERMANFLAGURL;
	}
	if([languageName isEqualToString:@"English"]) {
		return ENGLISHFLAGURL;
	}
	if([languageName isEqualToString:@"Italian"]) {
		return ITALIANFLAGURL;
	}
	if([languageName isEqualToString:@"French"]) {
		return FRENCHFLAGURL;
	}
	if([languageName isEqualToString:@"Spanish"]) {
		return SPANISHFLAGURL;
	}
	return nil;
}

// Method die een randje om de vlag heen tekend
-(void)addBorderOnImageView:(UIImageView *)imageView {
	CALayer *borderLayer = [CALayer layer];
	CGRect borderFrame = CGRectMake(0, 0, (imageView.frame.size.width), (imageView.frame.size.height));
	[borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
	[borderLayer setFrame:borderFrame];
	[borderLayer setBorderWidth:kBoarderWidth];
	[borderLayer setBorderColor:[[UIColor blackColor] CGColor]];
	[imageView.layer addSublayer:borderLayer];
}

// Als je op het kruisje drukt dan ga je weer terug naar de vorige view
- (IBAction)barButtonPressed:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end