//
//  MusicalTablesSection.m
//  MusicalTables
//
//  Created by Tim Cinel on 2011-11-17.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MusicalTablesSection.h"
#import "MusicalTables.h"

@implementation MusicalTablesSection

@synthesize identifier = _identifier;
@synthesize rows = _rows;

#pragma mark - NSObject

- (id)init {
    return [self initWithIdentifier:nil rows:nil];
}

- (id)initWithIdentifier:(NSString *)identifierOrNil rows:(NSMutableArray *)rowsOrNil {
    if (nil != (self = [super init])) {
        _identifier = identifierOrNil;
        _rows = (nil != rowsOrNil ? [rowsOrNil retain] : [[NSMutableArray alloc] init]);
    }
    return self;    
}

+ (id)musicalTablesSectionWithIdentifier:(NSString *)identifierOrNil rows:(NSMutableArray *)rowsOrNil {
    return [[[MusicalTablesSection alloc] initWithIdentifier:identifierOrNil rows:rowsOrNil] autorelease];
}

- (void)dealloc {
    self.identifier = nil;
    self.rows = nil;
    [super dealloc];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[MusicalTablesSection class]])
        return [self.identifier isEqualToString:[(MusicalTablesSection *)object identifier]];
    return NO;
}

#pragma mark - NSMutableArray Mimic

- (NSUInteger)count {
    NSLog(@"About to count: %@", self.rows);
    return self.rows.count;
}

- (id)objectAtIndex:(NSUInteger)index {
    return [self.rows objectAtIndex:index];
}

- (void)addObject:(id)anObject {
    [self.rows addObject:anObject];
}
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    [self.rows insertObject:anObject atIndex:index];
}

- (void)removeLastObject {
    [self.rows removeLastObject];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self.rows removeObjectAtIndex:index];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    [self.rows replaceObjectAtIndex:index withObject:anObject];
}



#pragma NSCopying

- (id)copyWithZone:(NSZone *)zone {
    //create new MusicalTablesSection
    MusicalTablesSection *newSection = [[MusicalTablesSection allocWithZone:zone] initWithIdentifier:self.identifier rows:nil];
    //create new rows (with same contents)
    newSection.rows = [[[NSMutableArray allocWithZone:nil] initWithArray:self.rows] autorelease];
    
    return newSection;
}

@end
