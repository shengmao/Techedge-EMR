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
@end

@implementation tyxSingleChronikViewController
@synthesize wholeChronikList;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super viewDidLoad];
    
    //clear background of tableview
    //[self.tableView setBackgroundColor:[UIColor clearColor]];
    //set up a background image for tableview
    //[self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grey_background.png"]]];                           
        
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
        //the where part of sql statement have to be dynamic - its only static for testing
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM tab_activities INNER JOIN tab_activitytype ON tab_activities.fk_idactivitytype = tab_activitytype.idactivitytype"];
        const char *query_stmt = [querySQL UTF8String];
        
        //send SQL statement to database
        if (sqlite3_prepare_v2(medicaldb, query_stmt, -1, &statement, NULL)==SQLITE_OK) {
            
            NSMutableArray *sectionNumberArray = [NSMutableArray arrayWithObjects: nil];
            //fetch result of SQL statement
            while (sqlite3_step(statement)==SQLITE_ROW) {
                NSString *patientChronik = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
                [sectionNumberArray addObject:patientChronik];
            }
            NSLog(@"%@",sectionNumberArray);
            NSDictionary *sectionNumberDictionary = [NSDictionary dictionaryWithObject:sectionNumberArray forKey:@"Chronik"];
            [wholeChronikList addObject:sectionNumberDictionary];
            sqlite3_finalize(statement);
        }
        sqlite3_close(medicaldb);
    }
    else {
        NSLog(@"DB Fehler");
    }
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
    return [wholeChronikList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //returns number of rows in a section
    NSDictionary *helperDictionary = [wholeChronikList objectAtIndex:section];
    NSArray *helperArray = [helperDictionary objectForKey:@"Chronik"];
    return [helperArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"23.04.2012";
    }
    else {
        return @"25.05.2012";
    }
}

#pragma mark TableView Rows
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChronikCell"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"ChronikCell"];
    }
    
    NSDictionary *dictionary = [wholeChronikList objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Chronik"];
    NSString *cellValue = [array objectAtIndex:indexPath.row];
    NSLog(@"Hallo");
    NSLog(@"%@", cellValue);
    
    //setup custom tableviewcell, identifies the labels with tag numbers that can be set in IB inspector -> second possibility is to create a new TableViewCell Class
    UILabel *patientnameTextfield = (UILabel *)[cell viewWithTag:100];
    patientnameTextfield.text = cellValue;
//    
//    UILabel *patientsurnameTextfield = (UILabel *) [cell viewWithTag:101];
//    patientsurnameTextfield.text = @"";
//    
//    UIImageView *patientpicture = (UIImageView *) [cell viewWithTag:102];
//    patientpicture.image = [UIImage imageNamed:@"patientpicture.png"];
    
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
