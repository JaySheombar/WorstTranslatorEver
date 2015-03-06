//
//  TRCoreDataObject.h
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRCoreDataObject : NSObject

@property (nonatomic) NSManagedObjectContext *context;

- (NSArray *)getCoreDataWithEntityName:(NSString *)entityName;
- (void)deleteObjectFromCore:(NSManagedObject *)object;
- (void)save;

@end