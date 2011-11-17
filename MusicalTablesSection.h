//
//  MusicalTablesSection.h
//  MusicalTables
//
//  Created by Tim Cinel on 2011-11-17.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicalTablesSection : NSObject <NSCopying>

@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) NSMutableArray *rows;

- (id)initWithIdentifier:(NSString *)identifierOrNil rows:(NSMutableArray *)rowsOrNil;
+ (id)musicalTablesSectionWithIdentifier:(NSString *)identifierOrNil rows:(NSMutableArray *)rowsOrNil;

- (BOOL)isEqual:(id)object;

- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;
- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end
