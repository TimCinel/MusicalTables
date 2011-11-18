MusicalTables - It's like Musical Chairs in your UITableView #
==============================================================

Overview
--------

MusicalTables looks at the changes in your table source data and automatically calls deleteSections, deleteRows, insertSections, insertRows where appropriate. Just worry about the data, let MusicalTables take care of the transition.


Details
-------

There are two classes: MusicalTables.(m|h) and MusicalTablesSection.(m|h)


### MusicalTables ###

#### ` + (void)musicalTables:(UITableView *)table oldContent:(NSArray *)oldContent newContent:(NSArray *)newContent;` ####

Takes the existing data source for your table (oldContent), the new data source
(newContent) and the table (table). The method compares oldContent and newContent,
determines the differences, and performs deleteSections/insertSections 
insertRows/deleteRows on the table accordingly.

There is a prescribed schema for oldData and newData:
     NSArray *(old|new)Content:
         (
             MusicalTableSection *(id row, id row, id row, id row, id row),
             MusicalTableSection *(id row, id row),
             MusicalTableSection *(id row, id row, id row, id row),
         );

Read about the MusicalTableSection class below for more information on it.



#### `+ (void)differenceBetweenOldArray:(NSArray *)oldArray andNewArray:(NSArray *)newArray resultingInsertions:(NSArray **)insertionsPtr resultingDeletions:(NSArray **)deletionsPtr resultingCommon:(NSArray **)commonPtr;` ####
 
Takes an old array (oldArray) and new array (newArray), analyses the differences 
between the two, and sets pointers to arrays containing insertions (insertionPtrOrNil) 
and deletions (deletionPtrOrNil) required to transition from the old array to the new
array. An array of elements from the old array that aren't deleted is also maintained 
(commonPtrOrNil).


### MusicalTablesSection ###

Sections don't have to be stored as MusicalTableSelection objects. The class
used to store sections should: 
 * Allow "tagging" so equivalent sections can be detected
 * Have an NSArray or other storage mechanism to store rows
 * Implement objectAtIndex: and count: like NSArray, so rows can be retrieved.



Contributors
------------

Created by [Tim Cinel](http://github.com/sickanimations) [web](http://timcinel.com/) [twitter](http://twitter.com/TimCinel) 
