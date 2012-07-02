//
//  tyxSingleChronikViewController.m
//  Medical2Mobile
//
//  Created by Sandra Möller on 26.06.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import "tyxSingleChronikViewController.h"

@interface tyxSingleChronikViewController ()
@property NSMutableArray *wholeChronikList;
@property NSMutableDictionary *wholeChronikListDictionary;
@end

@implementation tyxSingleChronikViewController
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@synthesize wholeChronikList;
@synthesize wholeChronikListDictionary;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{    
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super viewDidLoad];
    //self.detailViewController = (tyxDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    
    //create a dictionary for each section and adds them to the array wholePatientList
    wholeChronikList = [[NSMutableArray alloc] init];
    
    
    //set up databasePath
    NSString *docsDir;
    NSArray *dirPaths;
    
    //get documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    //Build the path to database file
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"medicaldb02.sqlite"]];
    
    const char *dbPath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbPath, &medicaldb)==SQLITE_OK) {
        //create SQL statement
        NSString *querySQL = [NSString stringWithFormat:@"SELECT tab_activities.dateinsert,  tab_activities.longdescription, tab_activitytype.shortdescription FROM tab_activities INNER JOIN tab_activitytype ON tab_activities.fk_idactivitytype = tab_activitytype.idactivitytype ORDER BY dateinsert DESC"];
        NSLog(@"%@",querySQL);
        const char *query_stmt = [querySQL UTF8String];
        
        //send SQL statement to database
        sqlite3_prepare_v2(medicaldb, query_stmt, -1, &statement, NULL);
            //fetch result of SQL statement
            while (sqlite3_step(statement)==SQLITE_ROW) {
                
                NSString *activityDate = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];

                NSString *activityLongDescription = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *activityTypeShortDescription = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                
                NSArray  *sectionArray = [NSArray arrayWithObjects:activityDate, activityLongDescription, activityTypeShortDescription, nil ];
                NSLog(@"-----------");
                NSLog(@"%@",sectionArray);
                NSLog(@"-----------");
                NSMutableDictionary *sectionDictionary = [NSMutableDictionary dictionaryWithObject:sectionArray forKey:@"Chronik"];
                [wholeChronikList addObject: sectionDictionary];
            }
        NSLog(@"%@",wholeChronikList);
            sqlite3_finalize(statement);
        sqlite3_close(medicaldb);
    }
    
    //'''''''''''''''''''''''''''''''''''''''''''
//    NSLog(@"%s",__PRETTY_FUNCTION__);
//    [super viewDidLoad];
//    
//    //clear background of tableview
//    //[self.tableView setBackgroundColor:[UIColor clearColor]];
//    //set up a background image for tableview
//    //[self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grey_background.png"]]];                           
//        
//    //create a dictionary for each section and adds them to the array wholePatientList
//    wholeChronikList = [[NSMutableArray alloc] init];
//    
//    //set up databasePath
//    NSString *docsDir;
//    NSArray *dirPaths;
//    
//    //get documents directory
//    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    docsDir = [dirPaths objectAtIndex:0];
//    
//    //Build the path to database file
//    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"medicaldb02.sqlite"]];
//    
//    const char *dbPath = [databasePath UTF8String];
//    sqlite3_stmt *statement;
//    
//    if (sqlite3_open(dbPath, &medicaldb)==SQLITE_OK) {
//        //create SQL statement
//        //the where part of sql statement have to be dynamic - its only static for testing
//        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM tab_activities INNER JOIN tab_activitytype ON tab_activities.fk_idactivitytype = tab_activitytype.idactivitytype"];
//        const char *query_stmt = [querySQL UTF8String];
//        
//        //send SQL statement to database
//        if (sqlite3_prepare_v2(medicaldb, query_stmt, -1, &statement, NULL)==SQLITE_OK) {
//            
//            NSMutableArray *sectionNumberArray = [NSMutableArray arrayWithObjects: nil];
//            //fetch result of SQL statement
//            while (sqlite3_step(statement)==SQLITE_ROW) {
//                NSString *patientChronik = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
//                [sectionNumberArray addObject:patientChronik];
//            }
//            
//            NSDictionary *sectionNumberDictionary = [NSDictionary dictionaryWithObject:sectionNumberArray forKey:@"Chronik"];
//            [wholeChronikList addObject:sectionNumberDictionary];
//            sqlite3_finalize(statement);
//        }
//        sqlite3_close(medicaldb);
//    }
//    else {
//        NSLog(@"DB Fehler");
//    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark
#pragma mark - TableView Sections

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    //returns number of rows in a section
//    NSDictionary *helperDictionary = [wholeChronikList objectAtIndex:section];
//    NSArray *helperArray = [helperDictionary objectForKey:@"Chronik"];
//    NSLog(@"%i",[helperArray count]);
//    return [helperArray count];
    return [wholeChronikList count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//     if (section == 0) {
//        return @"23.04.2012";
//    }
//    else {
//        return @"25.05.2012";
//    }
//}

#pragma mark TableView Rows
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSArray *array = [[NSArray alloc]init];
    NSMutableDictionary *dictionary = [wholeChronikList objectAtIndex:indexPath.row];
    array = [dictionary objectForKey:@"Chronik"];

    // Get the text so we can measure it
    NSString *text = [array objectAtIndex:1];
    // Get a CGSize for the width and, effectively, unlimited height
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    // Get the size of the text given the CGSize we just made as a constraint
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    // Get the height of our measurement, with a minimum of 44 (standard cell size)
    CGFloat height = MAX(size.height, 70.0f);
    // return the height, with a bit of extra padding in
    return height + (CELL_CONTENT_MARGIN * 2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChronikCell"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"ChronikCell"];
    }
    
    NSArray *array = [[NSArray alloc]init];
    NSMutableDictionary *dictionary = [wholeChronikList objectAtIndex:indexPath.row];
    array = [dictionary objectForKey:@"Chronik"];
    
    NSLog(@"%@",[array objectAtIndex:1]);
    
    UILabel *chronikdate = (UILabel *)[cell viewWithTag:100];
    chronikdate.text = [array objectAtIndex:0];
    
    UILabel *chronikShortDescription = (UILabel *) [cell viewWithTag:101];
    chronikShortDescription.text = [array objectAtIndex:2];
    [chronikShortDescription sizeToFit];
    
    UILabel *chronikLongDescription = (UILabel *) [cell viewWithTag:102];
    chronikLongDescription.text = [array objectAtIndex:1];
    [chronikLongDescription sizeToFit];
    
    return cell;
}


//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSDate *object = [_objects objectAtIndex:indexPath.row];
    //self.detailViewController.detailItem = object;
}
@end
