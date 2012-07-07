//
//  coredataMasterViewController.m
//  Medical2Mobile
//
//  Created by LISComputer on 03.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "coredataMasterViewController.h"
#import "tyxAppDelegate.h"
#import "Patient.h"
#import "tyxDetailViewController.h"

@interface coredataMasterViewController ()

@end

@implementation coredataMasterViewController
@synthesize managedObjectContext = __managedObjectContext;
@synthesize fetchedObjects = __fetchedObjects;
@synthesize detailViewController=_detailViewController;

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
    [super viewDidLoad];
    
    //Get managedObjectContext from App delegate.
    if (self.managedObjectContext == nil) 
    { 
        self.managedObjectContext = [(tyxAppDelegate *)[[UIApplication sharedApplication] delegate]managedObjectContext]; 
        NSLog(@"After managedObjectContext: %@",  self.managedObjectContext);
    }
    
    //Create a new row in data table Patient.
//    Patient *pat = [NSEntityDescription insertNewObjectForEntityForName:@"Patient" inManagedObjectContext:self.managedObjectContext];
//    
//    [pat setFname:@"Martin"];
//    [pat setLname:@"Müller"];
//    UIImage *pacpic = [UIImage imageNamed:@"1.png"];
//    NSData *imgData = UIImagePNGRepresentation(pacpic);
//    [pat setPicture:imgData];
    
    NSError *error = nil;
    // Define which datatable should be accessed. 
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Patient"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Define how we will sort the records  
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fname" ascending:NO];  
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];  
    [fetchRequest setSortDescriptors:sortDescriptors];  
    
    //Define the selection criteria.
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(fname Like 'Martin')" ];
//    [fetchRequest setPredicate:predicate];

    //Execute Request.
    self.fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    //Output for test.
    for (Patient *patient in self.fetchedObjects) {
        NSLog(@"%@", patient.fname);
        NSLog(@"%@", patient.lname);
    }        

}

//serialize the data in database otherwise only saved in memory.
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}


//preselect a row.
-(void)viewDidAppear:(BOOL)animated

{
    
    //preselect a cell
    
    NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
    
    [(UITableView*)self.view selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
    
    //preselect a detailview 
    self.detailViewController = (tyxDetailViewController *)[self.splitViewController.viewControllers lastObject];
    Patient *object = [self.fetchedObjects objectAtIndex:0];
    
    self.detailViewController.detailItem = object;
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PatientCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    NSString  *patientname = [[NSString alloc] init];
    patientname = [patientname stringByAppendingString:[[self.fetchedObjects objectAtIndex:indexPath.row] fname] ];
    patientname = [patientname stringByAppendingString:@" "];
    patientname = [patientname stringByAppendingString:[[self.fetchedObjects objectAtIndex:indexPath.row] lname]];
    
    UILabel *patientNameTextfield = (UILabel *)[cell viewWithTag:100];
    patientNameTextfield.text = patientname;

    UIImageView *patientpicture = (UIImageView *) [cell viewWithTag:102];
    patientpicture.image = [UIImage imageWithData:[[self.fetchedObjects objectAtIndex:indexPath.row] picture]];
     return cell;
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    self.detailViewController = (tyxDetailViewController *)[self.splitViewController.viewControllers lastObject];
    Patient *object = [self.fetchedObjects objectAtIndex:indexPath.row];

    self.detailViewController.detailItem = object;}

@end
