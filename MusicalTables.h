//
//  MusicalTables.h
//  MusicalTables
//
//  Created by Tim Cinel on 2011-11-15.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicalTables : NSObject

+ (void)musicalTables:(UITableView *)table oldContent:(NSArray *)oldContent newContent:(NSArray *)newContent;
+ (void)differenceBetweenOldArray:(NSArray *)oldArray andNewArray:(NSArray *)newArray resultingInsertions:(NSArray **)insertionsPtr resultingDeletions:(NSArray **)deletionsPtr resultingCommon:(NSArray **)commonPtr;

@end
