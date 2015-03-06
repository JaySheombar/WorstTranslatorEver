//
//  TRLanguageSelectionTableViewController.m
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import "TRLanguageSelectionTableViewController.h"

@implementation TRLanguageSelectionTableViewController {
	TRCoreDataObject *coreDataObject;
}

@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style {
	self = [super initWithStyle:style];
	if (self) {

	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Core data object om de talen uit op te halen
	coreDataObject = [[TRCoreDataObject alloc] init];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [coreDataObject getCoreDataWithEntityName:CORE_DATA_ENTITY_LANGUAGE].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

	// Configure the cell... op basis van core data 
	Languages *language = [[coreDataObject getCoreDataWithEntityName:CORE_DATA_ENTITY_LANGUAGE] objectAtIndex:indexPath.row];
	cell.textLabel.text = language.languageName;
	return cell;
}

#pragma mark - Table view delegate

// Als er een cell geklikt word.. delegate en ga terug naar vorige view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.delegate TRLanguageSelectionDelegateUpdate:self forButton:_chosenButton withLanguage:[[coreDataObject getCoreDataWithEntityName:CORE_DATA_ENTITY_LANGUAGE] objectAtIndex:indexPath.row]];
	[self.navigationController popViewControllerAnimated:YES];
}

@end