//
//  MusicalTables.m
//  MusicalTables
//
//  Created by Tim Cinel on 2011-11-15.
//  Copyright (c) 2011 Tim Cinel. All rights reserved.
//
// 

#import "MusicalTables.h"
#import "MusicalTablesSection.h"

@implementation MusicalTables

+ (void)musicalTables:(UITableView *)table oldContent:(NSArray *)oldContent newContent:(NSArray *)newContent {
    NSMutableArray *insertions, *deletions, *common, *rowsToInsert, *rowsToDelete;
    NSMutableIndexSet *sectionsToInsert, *sectionsToDelete;
    NSArray *oldRows, *newRows;
    
    //initialisation
    sectionsToInsert = [NSMutableIndexSet indexSet];
    sectionsToDelete = [NSMutableIndexSet indexSet];
    
    rowsToInsert = [NSMutableArray array];
    rowsToDelete = [NSMutableArray array];
    
    //SECTIONS
    
    //play musical tables with sections (determine differences between sections)
    [MusicalTables differenceBetweenOldArray:oldContent andNewArray:newContent resultingInsertions:&insertions resultingDeletions:&deletions resultingCommon:&common];
    
    //place data into NSIndexSet
    for (NSNumber *section in insertions)
        [sectionsToInsert addIndex:[section intValue]];
    
    for (NSNumber *section in deletions)
        [sectionsToDelete addIndex:[section intValue]];
    
    //make changes to table's sections
    [table deleteSections:sectionsToDelete withRowAnimation:UITableViewRowAnimationAutomatic];
    [table insertSections:sectionsToInsert withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    
    //ROWS
    
    //for each section that wasn't deleted and isn't new
    for (NSArray *rowPair in common) {        
        NSInteger oldSection, newSection;
        
        //schema for "common": (NSNumber *oldSection, NSNumber *newSection)
        oldSection = [[rowPair objectAtIndex:0] intValue];
        newSection = [[rowPair objectAtIndex:1] intValue];
        
        oldRows = [oldContent objectAtIndex:oldSection];
        newRows = [newContent objectAtIndex:newSection];
        
        //play musical tables with rows in sections that weren't deleted and aren't new (determine differences between rows in said sections)    
        [MusicalTables differenceBetweenOldArray:oldRows andNewArray:newRows resultingInsertions:&insertions resultingDeletions:&deletions resultingCommon:nil];
        
        //place data into NSArray of NSIndexPaths
        for (NSNumber *row in insertions)
            [rowsToInsert addObject:[NSIndexPath indexPathForRow:[row intValue] inSection:newSection]];
        
        for (NSNumber *row in deletions)
            [rowsToDelete addObject:[NSIndexPath indexPathForRow:[row intValue] inSection:newSection]];
        
    }
    
    //make changes to table's rows
    [table deleteRowsAtIndexPaths:rowsToDelete withRowAnimation:UITableViewRowAnimationAutomatic];
    [table insertRowsAtIndexPaths:rowsToInsert withRowAnimation:UITableViewRowAnimationAutomatic];
    
    //that's all, folks!
}


+ (void)differenceBetweenOldArray:(NSArray *)oldArray andNewArray:(NSArray *)newArray resultingInsertions:(NSArray **)insertionsPtr resultingDeletions:(NSArray **)deletionsPtr resultingCommon:(NSArray **)commonPtr {
    NSInteger oldPos, oldCount, newPos, newCount;
    NSObject *oldItem, *newItem, *nextOldItem;
    
    NSMutableArray *deletions, *insertions, *common;
    deletions = [NSMutableArray array];
    insertions = [NSMutableArray array];
    common = [NSMutableArray array];
    
    oldPos = newPos = 0;
    
    oldCount = oldArray.count;
    newCount = newArray.count;
    
    for (;;) {        
        oldItem = (oldPos < oldCount ? [oldArray objectAtIndex:oldPos] : nil);
        newItem = (newPos < newCount ? [newArray objectAtIndex:newPos] : nil);
        
        if (nil == oldItem && nil == newItem) {
            //we're done here
            break;
        } else if (nil == oldItem) {
            //we've exhausted all old items - just insert, insert, insert
            [insertions addObject:[NSNumber numberWithInt:newPos++]];
            
        } else if (nil == newItem) {
            //we've exhausted all new items - just delete, delete, delete
            [deletions addObject:[NSNumber numberWithInt:oldPos++]];
            
        } else if ([oldItem isEqual:newItem]) {
            //keep this section - need to play musical tables with the rows
            
            [common addObject:[NSArray arrayWithObjects:
                               [NSNumber numberWithInt:oldPos++],
                               [NSNumber numberWithInt:newPos++], 
                               nil]];
            
        } else {
            //check if the new item matches any proceeding old items
            nextOldItem = nil;
            NSInteger i;
            
            for (i = oldPos + 1; i < oldCount && nil == nextOldItem; i++)
                if ([[oldArray objectAtIndex:i] isEqual:newItem]) {
                    nextOldItem = [oldArray objectAtIndex:i];
                    break;
                }
            
            if (nil != nextOldItem) {
                //one of the old items matched - delete old items from oldPos to i - 1
                for (NSInteger j = oldPos; j < i; j++) {
                    [deletions addObject:[NSNumber numberWithInt:j]];
                }
                
                //move to old pos after matching old pos, move to next new pos
                oldPos = i + 1;
                newPos++;
                
            } else {
                //no old items matched - add new item
                [insertions addObject:[NSNumber numberWithInt:newPos++]];
            }
            
        }
        
    }    
    //return arrays
    
    if (nil != insertionsPtr)
        *insertionsPtr = insertions;
    
    if (nil != deletionsPtr)
        *deletionsPtr = deletions;
    
    if (nil != commonPtr)
        *commonPtr = common;
}

@end
