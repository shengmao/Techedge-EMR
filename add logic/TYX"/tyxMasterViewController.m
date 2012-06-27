//
//  tyxMasterViewController.m
//  TYX"
//
//  Created by LISComputer on 12.06.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import "tyxMasterViewController.h"
#import "tyxDetailViewController.h"

@interface tyxMasterViewController () 
//create a new property that can be used by other views
@property NSMutableArray *wholePatientList;
@end

@implementation tyxMasterViewController

@synthesize wholePatientList; //hold all patient records
@synthesize detailViewController = _detailViewController;

#pragma mark MasterView Controller
- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [super viewDidLoad];
    //self.detailViewController = (tyxDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    
    //create a dictionary for each section and adds them to the array wholePatientList
    wholePatientList = [[NSMutableArray alloc] init];
    
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
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM tab_patient"];
        const char *query_stmt = [querySQL UTF8String];
        
        //send SQL statement to database
        if (sqlite3_prepare_v2(medicaldb, query_stmt, -1, &statement, NULL)==SQLITE_OK) {

            NSMutableArray *sectionNumberArray = [NSMutableArray arrayWithObjects: nil];
            //fetch result of SQL statement
            while (sqlite3_step(statement)==SQLITE_ROW) {
                
                NSString *patientsurName = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                
                NSString *patientName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                NSString *idpatient = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                NSLog(@"untill now it is ok 1");
                
                NSArray  *sectionNumberArray = [NSMutableArray arrayWithObjects:patientsurName, patientName, idpatient, nil ];
                NSLog(@"%@", sectionNumberArray);
                //[sectionNumberDictionary setObject:sectionNumberArray forKey:@"patient"];
                NSMutableDictionary *sectionNumberDictionary = [NSMutableDictionary dictionaryWithObject:sectionNumberArray forKey:@"Patients"];
                [wholePatientList addObject: sectionNumberDictionary];
                
                //release sectionNumberArray and sectionNumberDictionary
                //                [sectionNumberArray removeAllObjects];
                //                [sectionNumberDictionary removeAllObjects];
                
                //[sectionNumberArray addObject:patientsurName];
                //[sectionNumberArray addObject:patientName];
                
                
            }
            //NSMutableDictionary *sectionNumberDictionary = [NSMutableDictionary dictionaryWithObject:sectionNumberArray forKey:@"Patients"];
            //[wholePatientList addObject:sectionNumberDictionary];
            sqlite3_finalize(statement);

        }
        sqlite3_close(medicaldb);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
   
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(interfaceOrientation == UIInterfaceOrientationPortrait){
        return NO;
    }
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        return YES;
    }
    else 
    {
        return NO;
    }  
}

#pragma mark - Table View
#pragma mark - TableView Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [wholePatientList count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //returns number of rows in a section
    //    NSMutableDictionary *helperDictionary = [wholePatientList objectAtIndex:section];
    //    NSMutableArray *helperArray = [helperDictionary objectForKey:@"Patients"];
    //    return [helperArray count];
    return [wholePatientList count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Neurospine Center";
    }
    else {
        return @"Eichhoffklinik";
    }
}

#pragma mark TableView Rows
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientCell"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"PatientCell"];
    }
    NSLog(@"untill now it is ok 2");
    //    NSMutableDictionary *dictionary = [wholePatientList objectAtIndex:indexPath.section];
    //    NSMutableArray *array = [dictionary objectForKey:@"Patients"];
    //    NSString *cellValue = [array objectAtIndex:indexPath.row];
    //    NSLog(@"%@", cellValue);
    //    //setup custom tableviewcell, identifies the labels with tag numbers that can be set in IB inspector -> second possibility is to create a new TableViewCell Class
    //    UILabel *patientnameTextfield = (UILabel *)[cell viewWithTag:100];
    //    patientnameTextfield.text = cellValue;
    //    
    //    UILabel *patientsurnameTextfield = (UILabel *) [cell viewWithTag:101];
    //    patientsurnameTextfield.text = @"";
    //    
    //    UIImageView *patientpicture = (UIImageView *) [cell viewWithTag:102];
    //    patientpicture.image = [UIImage imageNamed:@"patientpicture.png"];
    
    NSMutableDictionary *dictionary = [wholePatientList objectAtIndex:indexPath.row];
    NSArray *array = [dictionary objectForKey:@"Patients"];
    
    NSLog(@"%@",[array objectAtIndex:1]);
    
    UILabel *patientnameTextfield = (UILabel *)[cell viewWithTag:100];
    patientnameTextfield.text = [array objectAtIndex:1];
    
    UILabel *patientsurnameTextfield = (UILabel *) [cell viewWithTag:101];
    patientsurnameTextfield.text = [array objectAtIndex:0];
    
    UIImageView *patientpicture = (UIImageView *) [cell viewWithTag:102];
    patientpicture.image = [UIImage imageNamed:@"patientpicture.png"];
    
    
    
    
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
