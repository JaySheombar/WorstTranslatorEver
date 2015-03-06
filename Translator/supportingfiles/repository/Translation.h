//
//  Translation.h
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Translation : NSManagedObject

@property (nonatomic, retain) NSString * fromLanguage;
@property (nonatomic, retain) NSString * fromText;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * toLanguage;
@property (nonatomic, retain) NSString * toText;

@end
