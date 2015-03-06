//
//  TRCoreDataObject.m
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import "TRCoreDataObject.h"

@implementation TRCoreDataObject

- (id)init {
	if(self = [super init]) {

		// ObjectContext ophalen uit Appdelegate
		id appDelegate = [UIApplication sharedApplication].delegate;
		_context = [appDelegate managedObjectContext];
	}
	return self;
}

// Returned een Array op basis van entitynaam
- (NSArray *)getCoreDataWithEntityName:(NSString *)entityName {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:_context];

	[fetchRequest setEntity:entity];

	NSError *error = nil;
	NSArray *fetchedObjects = [_context executeFetchRequest:fetchRequest error:&error];
	return fetchedObjects;
}

// Verwijderd een NSManagedObject uit Core Data
- (void)deleteObjectFromCore:(NSManagedObject *)object {
	[_context deleteObject:object];
	[self save];
}

// Opslaan in core data of error vertonen
- (void)save {
	NSError *error = nil;
	if([_context save:&error]) {
		NSLog(@"The save was succesful");
	} else {
		NSLog(@"The save wasnt succesful: %@", [error userInfo]);
	}
}

@end