//
//  ViewController.m
//  MusicalTables
//
//  Created by Tim Cinel on 2011-11-15.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#import "MusicalTables.h"

@implementation ViewController

@synthesize tableView = _tableView;
@synthesize tableData = _tableData;

@synthesize tableElements = _tableElements;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _tableElements = [[NSArray alloc] initWithObjects:
                          @"Hello", @"World", //0
                          @"All", @"Your", @"Base", @"Are",  @"Belong", @"To", @"Us", //2
                          @"Then", @"Who", @"Was", @"Telephone", nil]; //9
    
    
    _tableData = [[NSMutableArray alloc] initWithObjects:
                  [self.tableElements objectAtIndex:0],
                  [self.tableElements objectAtIndex:2],
                  [self.tableElements objectAtIndex:4],
                  [self.tableElements objectAtIndex:6],
                  [self.tableElements objectAtIndex:8],
                  [self.tableElements objectAtIndex:10],
                  [self.tableElements objectAtIndex:12],
                  nil
                  ];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.tableView = nil;
    self.tableData = nil;
    
    self.tableElements = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - IBActions

- (IBAction)runNextTest:(id)sender {
    static NSInteger test = 0;
    NSMutableArray *newTableElements;
    
    switch (test++) {
        case 1:
            newTableElements = [[NSMutableArray alloc] initWithObjects:
                                  [self.tableElements objectAtIndex:0],
                                  [self.tableElements objectAtIndex:2],
                                  [self.tableElements objectAtIndex:4],
                                  [self.tableElements objectAtIndex:6],
                                  [self.tableElements objectAtIndex:8],
                                  [self.tableElements objectAtIndex:10],
                                  [self.tableElements objectAtIndex:12],
                                  nil
                                  ];

            break;
        case 2:
            newTableElements = [NSMutableArray arrayWithObjects:
                                [self.tableElements objectAtIndex:0],
                                [self.tableElements objectAtIndex:1], //insert 1 (1)
                                [self.tableElements objectAtIndex:2],
                                [self.tableElements objectAtIndex:3], //insert 3 (3)
                                [self.tableElements objectAtIndex:4],
                                [self.tableElements objectAtIndex:5], //insert 5 (5)
                                [self.tableElements objectAtIndex:7], //delete 6 (3), insert 7 (6)
                                [self.tableElements objectAtIndex:9], //delete 8 (4), insert 9 (7)
                                [self.tableElements objectAtIndex:11], //delete 10 (5), insert 11 (8)
                                [self.tableElements objectAtIndex:12],
                                nil
                                ];
            break;
        case 3:
            newTableElements = [NSMutableArray arrayWithObjects:
                                [self.tableElements objectAtIndex:1], 
                                [self.tableElements objectAtIndex:3],
                                [self.tableElements objectAtIndex:5],
                                [self.tableElements objectAtIndex:7],
                                [self.tableElements objectAtIndex:9],
                                [self.tableElements objectAtIndex:11],
                                nil
                                ];
            break;
        case 4:
            newTableElements = [NSMutableArray arrayWithObjects:
                                [self.tableElements objectAtIndex:1],
                                [self.tableElements objectAtIndex:11],
                                nil
                                ];
            break;
        default:
            newTableElements = [NSMutableArray array];
            break;
    }
    
    [self.tableView beginUpdates];
    [MusicalTables musicalTables:self.tableView oldContent:self.tableData newContent:newTableElements];
    self.tableData = newTableElements;
    [self.tableView endUpdates];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return self.tableData.count;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [(NSArray *)[self.tableData objectAtIndex:section] count];
    return self.tableData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"MTCell";
    UITableViewCell *cell;
    
    if (nil == (cell = [tableView dequeueReusableCellWithIdentifier:identifier])) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    
    //cell.textLabel.text = [(NSArray *)[self.tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end