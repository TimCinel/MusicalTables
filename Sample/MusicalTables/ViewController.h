//
//  ViewController.h
//  MusicalTables
//
//  Created by Tim Cinel on 2011-11-15.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *tableData;

@property (nonatomic, retain) NSArray *tableSections;
@property (nonatomic, retain) NSArray *tableRows;

- (IBAction)runNextTest:(id)sender;

@end
