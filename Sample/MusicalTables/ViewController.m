//
//  ViewController.m
//  MusicalTables
//
//  Created by Tim Cinel on 2011-11-15.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#import "MusicalTables.h"
#import "MusicalTablesSection.h"

@implementation ViewController

@synthesize tableView = _tableView;
@synthesize tableData = _tableData;

@synthesize tableSections = _tableSections;
@synthesize tableRows = _tableRows;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _tableRows = [[NSArray alloc] initWithObjects:
                        @"Hello", @"World", //0
                        @"All", @"Your", @"Base", @"Are",  @"Belong", @"To", @"Us", //2
                        @"Y", @"U", @"NO", //9
                        @"Then", @"Who", @"Was", @"Telephone", nil]; //12
    
    _tableSections = [[NSMutableArray alloc] initWithObjects:
                        [MusicalTablesSection musicalTablesSectionWithIdentifier:@"HW" rows:[NSMutableArray arrayWithObjects: [self.tableRows objectAtIndex:0], [self.tableRows objectAtIndex:1], nil]], 
                        [MusicalTablesSection musicalTablesSectionWithIdentifier:@"AYB" rows:[NSMutableArray arrayWithObjects: [self.tableRows objectAtIndex:2], [self.tableRows objectAtIndex:3], [self.tableRows objectAtIndex:4], [self.tableRows objectAtIndex:5], [self.tableRows objectAtIndex:6], [self.tableRows objectAtIndex:7], [self.tableRows objectAtIndex:8], nil]],
                        [MusicalTablesSection musicalTablesSectionWithIdentifier:@"YUNO" rows:[NSMutableArray arrayWithObjects: [self.tableRows objectAtIndex:9], [self.tableRows objectAtIndex:10], [self.tableRows objectAtIndex:11], nil]],
                        [MusicalTablesSection musicalTablesSectionWithIdentifier:@"THW" rows:[NSMutableArray arrayWithObjects: [self.tableRows objectAtIndex:12], [self.tableRows objectAtIndex:13], [self.tableRows objectAtIndex:14], [self.tableRows objectAtIndex:15], nil]],
                        nil];
    
    _tableData = [[NSMutableArray alloc] init];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.tableView = nil;
    self.tableData = nil;
    
    self.tableSections = nil;
    self.tableRows = nil;
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
    static NSInteger test = -1;
    NSMutableArray *newTableElements, *tempArray;
    
    switch ((test = (test + 1) % 5)) {
        case 0:
            newTableElements = [NSMutableArray arrayWithObjects:
                                [self.tableSections objectAtIndex:0],
                                [self.tableSections objectAtIndex:1],
                                [self.tableSections objectAtIndex:2],
                                nil];

            break;
        case 1:            
            newTableElements = [NSMutableArray arrayWithObjects:
                                [self.tableSections objectAtIndex:1],
                                [self.tableSections objectAtIndex:3],
                                nil];
            break;
        case 2:
            tempArray = [(MusicalTablesSection *)[self.tableSections objectAtIndex:1] copy];
            [tempArray insertObject:@"lolWAT" atIndex:0];
            [tempArray insertObject:@"huh?!" atIndex:2];
            [tempArray removeLastObject];
            [tempArray removeLastObject];
            [tempArray removeLastObject];
            
            [self.tableSections replaceObjectAtIndex:1 withObject:tempArray];
            
            newTableElements = [NSMutableArray arrayWithObjects:
                                [self.tableSections objectAtIndex:1],
                                [self.tableSections objectAtIndex:0],
                                [self.tableSections objectAtIndex:3],
                                nil];
            break;
        case 3:
            tempArray = [(MusicalTablesSection *)[self.tableSections objectAtIndex:1] copy];
            [tempArray removeObjectAtIndex:2];
            [tempArray removeObjectAtIndex:0];
            [tempArray addObject:[self.tableRows objectAtIndex:6]];
            [tempArray addObject:[self.tableRows objectAtIndex:7]];
            [tempArray addObject:[self.tableRows objectAtIndex:8]];
            
            [self.tableSections replaceObjectAtIndex:1 withObject:tempArray];
            
            newTableElements = [NSMutableArray arrayWithObjects:
                                [self.tableSections objectAtIndex:1],
                                [self.tableSections objectAtIndex:2],
                                [self.tableSections objectAtIndex:0],
                                [self.tableSections objectAtIndex:3],
                                nil];
            break;
        default:
            newTableElements = [NSMutableArray array];
            break;
    }
    
    [self.tableView beginUpdates];
    NSLog(@"newTableElements: %@", self.tableData);
    NSLog(@"oldTableElements: %@", newTableElements);
    
    [MusicalTables musicalTables:self.tableView oldContent:self.tableData newContent:newTableElements];
    self.tableData = newTableElements;
    [self.tableView endUpdates];
    
}






#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(NSArray *)[self.tableData objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"MTCell";
    UITableViewCell *cell;
    
    if (nil == (cell = [tableView dequeueReusableCellWithIdentifier:identifier])) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    
    cell.textLabel.text = [(NSArray *)[self.tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end