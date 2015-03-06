//
//  TRViewController.m
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import "TRViewController.h"


@interface TRViewController ()

@end

@implementation TRViewController {
	TRTranslationModel *translator;
	Languages *fromLanguage;
	Languages *toLanguage;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	// Init the translator
	translator = [[TRTranslationModel alloc] init];
	translator.delegate = self;

	// Ik gebruik een TextView ipv een TextField om multiline te hebben..
	_inputTextView.delegate = self;
	[_inputTextView.layer setBorderColor: [[UIColor grayColor] CGColor]];
	[_inputTextView.layer setBorderWidth: 1.0];
	[_inputTextView.layer setCornerRadius:8.0f];

	// Tableview set delegate & data source
	[_outputTableView setDataSource:self];
	[_outputTableView setDelegate:self];

	// Set standaard talen
	for(Languages *language in [translator getCoreDataWithEntityName:CORE_DATA_ENTITY_LANGUAGE]) {
		if([language.language intValue] == languageDutch) {
			fromLanguage = language;
		}
		if([language.language intValue] == languageGerman) {
			toLanguage = language;
		}
	}
	[self updateButtons];
}

// Als View weer actief word, wil ik de geselecteerde tableview selection laten uitanimeren
-(void)viewDidAppear:(BOOL)animated {
	[_outputTableView deselectRowAtIndexPath:[_outputTableView indexPathForSelectedRow] animated:YES];
}

#pragma mark Action

// Set nieuwe waardes op de buttons
- (void)updateButtons {
	[_fromLanguageButton setTitle:fromLanguage.languageName forState:UIControlStateNormal];
	[_toLanguageButton setTitle:toLanguage.languageName forState:UIControlStateNormal];
}

// Methode om knoppen om te wisselen ( van de talen )
- (IBAction)switchLanguages:(UIButton *)sender {
	Languages *oldFrom = fromLanguage;
	Languages *oldTo = toLanguage;

	fromLanguage = oldTo;
	toLanguage = oldFrom;

	oldFrom = nil;
	oldTo = nil;

	// Update de knoppen
	[self updateButtons];
}

#pragma mark TextViewDelegate

// Ik wil een leeg textveld als ik hem ga editten
-(void)textViewDidBeginEditing:(UITextView *)textView {
	_inputTextView.text = @"";
}

// Omdat een textview niet hetzelfde werkt als een textField moet ik een beetje hacken V
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

	// De GO knop is onderwater een new line.. Dus we hacken het een beetje aangezien textview geen ondersteuning bied voor RETURN
	if([text isEqualToString:@"\n"]) {
		[_inputTextView resignFirstResponder];

		// Als de from en to knop dezelfde taal bevatten - laat SUPERERROR ZIEN! >:-) (en return)
		if([fromLanguage.language intValue] == [toLanguage.language intValue]) {
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please choose two different languages" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alertView show];
			return NO;
		}

		// Kijken of de gebruiker wat text heeft ingevuld
		if(![_inputTextView.text isEqualToString:@""]) {
			[_spinner startAnimating];

			// TRANSLATE! :-D
			[translator	translate:_inputTextView.text fromLanguage:fromLanguage toLanguage:toLanguage];
		}
		return NO;
	}
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [translator getTranslationsOrderedByDate].count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"History";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	
	// Maak mijn eigen tableviewcell aan.
	TRTranslationTableViewCell *cell = [[TRTranslationTableViewCell alloc] init];
	cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	
	// Configure the cell...
	Translation *translationItem = [[translator getTranslationsOrderedByDate] objectAtIndex:indexPath.row];
	cell.fromLabelLanguage.text = translationItem.fromLanguage;
	cell.fromLabelText.text = translationItem.fromText;
	cell.toLabelLanguage.text = translationItem.toLanguage;
	cell.toLabelText.text = translationItem.toText;
	return cell;
}

// Wil ook items kunnen verwijderen
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// Delete uit core data
		[translator deleteObjectFromCore:[[translator getTranslationsOrderedByDate] objectAtIndex:indexPath.row]];
		
		// Delete cell uit tableview
		[_outputTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

#pragma mark - Table view delegate

// Als ik een cell selecteer wil ik naar mijn detailView gaan
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	TRDetailTranslationViewController *detailViewController = [[TRDetailTranslationViewController alloc] init];
	detailViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[detailViewController setTranslation:[[translator getTranslationsOrderedByDate] objectAtIndex:indexPath.row]];
	[self presentViewController:detailViewController animated:YES completion:nil];
}

#pragma mark TranslationDelegate

// Als de translation compleet is wil ik dat spinner stopt met draaien en dat hij opnieuw de tableview inlaad
-(void)TRTranslationDelegateTranslationComplete:(TRTranslationModel *)translationModel {
	[_spinner stopAnimating];
	[_outputTableView reloadData];
}

#pragma mark LanguageSelectionViewControllerDelegate

// Method die de nieuwe taal zet afhankelijk van welke knop er gedrukt is
-(void)TRLanguageSelectionDelegateUpdate:(TRLanguageSelectionTableViewController *)selectionViewController forButton:(ButtonOption)button withLanguage:(Languages *)language {
	switch (button) {
		case ButtonOptionFrom:
			fromLanguage = language;
			break;

		case ButtonOptionTo:
			toLanguage = language;
			break;

		default:
			break;
	}
	[self updateButtons];
}

#pragma mark Segue

// Segue dingen
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	TRLanguageSelectionTableViewController *selectionTableViewController = [[TRLanguageSelectionTableViewController alloc] init];
	selectionTableViewController = [segue destinationViewController];

	if([segue.identifier isEqualToString:@"to"]) {
		[[segue destinationViewController] setChosenButton:ButtonOptionTo];
	}

	if([segue.identifier isEqualToString:@"from"]) {
		[[segue destinationViewController] setChosenButton:ButtonOptionFrom];
	}

	// Costum delegates moeten met segues op deze manier geset worden, anders is ie null
	[[segue destinationViewController] setDelegate:self];
}

@end