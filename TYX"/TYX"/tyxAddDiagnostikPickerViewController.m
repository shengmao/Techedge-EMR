//
//  tyxAddDiagnostikPickerViewController.m
//  Medical2Mobile
//
//  Created by Sandra Möller on 27.06.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import "tyxAddDiagnostikPickerViewController.h"

@implementation tyxAddDiagnostikPickerViewController 
@synthesize activitytypePicker;
@synthesize activitytype;
@synthesize selectedPickerRow;
@synthesize choosenNumber;
@synthesize shortDescription;
@synthesize longDescription;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    activitytype = [[NSMutableArray alloc] init];
    [activitytype addObject:@"Anamnese"];
    [activitytype addObject:@"Diagnose"];
    [activitytype addObject:@"Befund"];
    
    //set up databasePath
    NSString *docsDir;
    NSArray *dirPaths;
    
    //get documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    //Build the path to database file
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"medicaldb02.sqlite"]];
    
    const char *dbPath = [databasePath UTF8String];
    if (sqlite3_open(dbPath, &medicaldb)==SQLITE_OK) {
        NSLog(@"Open database successfully");
        sqlite3_close(medicaldb);
    }
    else {
        NSLog(@"Failed to open database");
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)viewDidUnload {
    [self setActivitytypePicker:nil];
    [self setSelectedPickerRow:nil];
    [self setChoosenNumber:nil];
    [self setShortDescription:nil];
    [self setLongDescription:nil];
    [super viewDidUnload];
}

#pragma mark PickerView 
#pragma mark PickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [activitytype count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [activitytype objectAtIndex:row];
}

#pragma mark PickerView Handling
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //write selected pickerrow into a label for controll and further access
    selectedPickerRow.text = [NSString stringWithFormat:@"%i", row];
}
#pragma mark saveData
- (IBAction)saveDiagnostic:(id)sender 
{
    const char *dbPath = [databasePath UTF8String];
    //sqlite3_stmt *statement;
    if (sqlite3_open(dbPath, &medicaldb)==SQLITE_OK) {
        //create SQL statement
        NSString *querySQL = [NSString stringWithFormat:@"INSERT INTO tab_activities (fk_idpatient, fk_iduser, fk_idactivitytype, dateinsert, longdescription) VALUES ('1','1',%@,datetime(), \'%@\')",selectedPickerRow.text,longDescription.text];
        NSLog(@"---------------------STATEMENT----------------");
        NSLog(@"%@",querySQL);
        NSLog(@"----------------------------------------------");
        const char *query_stmt = [querySQL UTF8String];
        char *error = NULL;
        //send SQL statement to database
        sqlite3_exec(medicaldb, query_stmt, NULL, NULL, &error);
        if (sqlite3_exec(medicaldb, query_stmt, NULL,NULL, &error) == SQLITE_OK)
        {
            NSLog(@"Inserted.");        
        }
        else
        {
            NSLog(@"Error: %s", error);
        }
        
        //        sqlite3_prepare_v2(medicaldb, query_stmt, -1, &statement, NULL); 
        //            NSLog(@"hier bin ich");
        //            //fetch result of SQL statement
        //        sqlite3_step(statement);
        //        sqlite3_finalize(statement);
        sqlite3_close(medicaldb);
    }
}
@end