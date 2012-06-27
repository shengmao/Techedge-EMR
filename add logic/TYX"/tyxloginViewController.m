//
//  tyxloginViewController.m
//  TYX"
//
//  Created by LISComputer on 18.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tyxloginViewController.h"
@interface tyxloginViewController ()

@end

@implementation tyxloginViewController
@synthesize customerLogo;
@synthesize usernameTextfield;
@synthesize passwortTextfield;
@synthesize companyLogo;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    customerLogo.image = [UIImage imageNamed:@"neurospinecenter_logo.jpg"];
    companyLogo.image = [UIImage imageNamed:@"techedge_leverage_logo.jpg"];
	// Do any additional setup after loading the view.
    
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

- (void)viewDidUnload
{
    [self setCustomerLogo:nil];
    [self setUsernameTextfield:nil];
    [self setPasswortTextfield:nil];
    [self setCompanyLogo:nil];
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

- (IBAction)establishConnection:(id)sender {
    //check logindata and grants access to further views
    
    const char *dbPath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbPath, &medicaldb)==SQLITE_OK) {
        //create SQL statement
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM tab_user WHERE loginname=\"%@\"", self.usernameTextfield.text];
        const char *query_stmt = [querySQL UTF8String];
        
        //send SQL statement to database
        if (sqlite3_prepare_v2(medicaldb, query_stmt, -1, &statement, NULL)==SQLITE_OK) {
            
            //fetch result of SQL statement
            if (sqlite3_step(statement)==SQLITE_ROW) {
                [self performSegueWithIdentifier:@"loginSuccessful" sender:self];
            }
            else {
                //no result
                [self performSegueWithIdentifier:@"loginFailed" sender:self];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(medicaldb);
    }

}
@end
