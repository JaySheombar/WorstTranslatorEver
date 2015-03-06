//
//  TRTranslationModel.m
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import "TRTranslationModel.h"

@implementation TRTranslationModel {
	NSMutableData *_responseData;
	
	NSString *_text;
	Languages *_fromLanguage;
	Languages *_toLanguage;
}

// Bouw de request op
- (void)translate:(NSString *)text fromLanguage:(Languages *)fromLanguage toLanguage:(Languages *)toLanguage {
	_text = text;
	_fromLanguage = fromLanguage;
	_toLanguage	= toLanguage;
	
	NSString *query = [NSString stringWithFormat:@"q=%@", [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSString *langPair = [NSString stringWithFormat:@"langpair=%@|%@", fromLanguage.languageRegionCode, toLanguage.languageRegionCode];
	langPair = [langPair stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

	NSString *url = [NSString stringWithFormat:@"%@?%@&%@", API_URL, query, langPair];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"GET"];
	
	// Execute request
	(void)[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

// Check of alle informatie geset is die nodig is later om het op te slaan..
- (BOOL)gotAllValues {
	if(![_text isEqualToString:@""] && _fromLanguage != nil && _toLanguage != nil) {
		return YES;
	} else {
		return NO;
	}
}

#pragma mark NSURLConnectionDelegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	// Ik krijg een response dus alloc init mijn responsedata object
	_responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	// Voeg de data die uit de response komt toe aan de variabele
	[_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse*)cachedResponse {
	// Ik wil niks cachen
	return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// Parse de data
	NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:_responseData options:0 error:nil];
	NSString *translatedText = [[responseDictionary objectForKey:@"responseData"] objectForKey:@"translatedText"];

	// Voeg toe aan database indien word voldaan aan de eisen
	if([self gotAllValues] && ![translatedText isEqualToString:@""]) {
		[self addTranslationToCoreDataWithOriginText:_text andOriginalLanguage:_fromLanguage translatedToLanguage:_toLanguage withTranslatedText:translatedText];
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	// The request heeft gefaald... NSLog waarom:
	NSLog(@"Something went wrong: %@", error);
}

#pragma mark Core Data stuff

// Eigenlijk een INSERT INTO DB
- (void)addTranslationToCoreDataWithOriginText:(NSString *)originalText andOriginalLanguage:(Languages *)fromLanguage translatedToLanguage:(Languages *)toLanguage withTranslatedText:(NSString *)translatedText {
	Translation *translation = [NSEntityDescription insertNewObjectForEntityForName:@"Translation" inManagedObjectContext:self.context];
	[translation setTimestamp:[NSDate date]];
	[translation setFromLanguage:fromLanguage.languageName];
	[translation setFromText:originalText];
	[translation setToLanguage:toLanguage.languageName];
	[translation setToText:translatedText];
	
	[self save];
	[_delegate TRTranslationDelegateTranslationComplete:self];
}

// NSlogged alle Vertalingen
- (void)readTranslations {
	for(Translation *translation in [self getCoreDataWithEntityName:CORE_DATA_ENTITY_TRANSLATION]) {
		NSLog(@"Translation:");
		NSLog(@"fromLanguage: %@ - %@", translation.fromLanguage, translation.fromText);
		NSLog(@"toLanguage: %@ - %@", translation.toLanguage, translation.toText);
		NSLog(@"at: %@", translation.timestamp);
	}
}

// Returned een array met alle data gesorteerd op datum
- (NSArray *)getTranslationsOrderedByDate {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:CORE_DATA_ENTITY_TRANSLATION inManagedObjectContext:self.context];

	[fetchRequest setEntity:entity];

	NSError *error = nil;
	NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];

	// Sort by date, newest on top!
	NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
 	fetchedObjects = [fetchedObjects sortedArrayUsingDescriptors:[[NSArray alloc] initWithObjects:sort, nil]];

	return fetchedObjects;
}

@end