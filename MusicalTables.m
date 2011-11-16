//
//  MusicalTables.m
//  MusicalTables
//
//  Created by Tim Cinel on 2011-11-15.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MusicalTables.h"

@implementation MusicalTables

+ (void)musicalTables:(UITableView *)table oldContent:(NSArray *)oldContent newContent:(NSArray *)newContent {
    NSInteger oldPos, oldCount, newPos, newCount;
    NSObject *oldItem, *newItem, *nextOldItem;
    
    NSMutableArray *deletions, *insertions;
    deletions = [NSMutableArray array];
    insertions = [NSMutableArray array];
    
    oldPos = newPos = 0;
    
    oldCount = oldContent.count;
    newCount = newContent.count;
    
    for (;;) {        
        oldItem = (oldPos < oldCount ? [oldContent objectAtIndex:oldPos] : nil);
        newItem = (newPos < newCount ? [newContent objectAtIndex:newPos] : nil);
        
        if (nil == oldItem && nil == newItem) {
            //we're done here
            break;
        } else if (nil == oldItem) {
            //we've exhausted all old items - just insert, insert, insert
            NSLog(@"A: Insert %d", newPos);
            [insertions addObject:[NSIndexPath indexPathForRow:newPos inSection:0]];
            newPos++;
            
        } else if (nil == newItem) {
            NSLog(@"B: Delete %d", oldPos);
            //we've exhausted all new items - just delete, delete, delete
            [deletions addObject:[NSIndexPath indexPathForRow:oldPos inSection:0]];
            oldPos++;
            
        } else if (oldItem == newItem) {
            //keep this section - need to play musical tables with the rows
            NSLog(@"C: Leave %d", newPos);
            
            //RECURSE?
            oldPos++;
            newPos++;
            
        } else {
            //check if the new item matches any proceeding old items
            nextOldItem = nil;
            NSInteger i;
            
            for (i = oldPos + 1; i < oldCount && nil == nextOldItem; i++)
                if ([oldContent objectAtIndex:i] == newItem) {
                    nextOldItem = [oldContent objectAtIndex:i];
                    break;
                }
            
            if (nil != nextOldItem) {
                //one of the old items matched - delete old items from oldPos to i - 1
                for (NSInteger j = oldPos; j < i; j++) {
                    NSLog(@"D: Delete %d (%d, %d)", j, j, newPos);
                    [deletions addObject:[NSIndexPath indexPathForRow:j inSection:0]];
                }
                
                //move to old pos after matching old pos, move to next new pos
                oldPos = i + 1;
                newPos++;
                
            } else {
                //no old items matched - add new item
                NSLog(@"E: Insert %d (%d %d)", newPos, oldPos, newPos);
                [insertions addObject:[NSIndexPath indexPathForRow:newPos inSection:0]];
                newPos++;
            }
            
        }
        
    }
    
    NSLog(@"Result:\nInsertions:\n%@\n\nDeletions:%@", insertions, deletions);
    
    [table deleteRowsAtIndexPaths:deletions withRowAnimation:UITableViewRowAnimationAutomatic];
    [table insertRowsAtIndexPaths:insertions withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

@end
