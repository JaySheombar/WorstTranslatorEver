//
//  Languages.h
//  Translator
//
//  Created by Sanjay Sheombar on 4/6/13.
//  Copyright (c) 2013 Sanjay Sheombar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Languages : NSManagedObject

@property (nonatomic, retain) NSNumber * language;
@property (nonatomic, retain) NSString * languageName;
@property (nonatomic, retain) NSString * languageRegionCode;

@end
