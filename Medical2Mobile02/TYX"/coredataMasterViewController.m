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
@synthesize fetchedResultsController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (NSFetchedResultsController *)fetchedResultsController {
    //Get managedObjectContext from App delegate.
    if (self.managedObjectContext == nil) 
    { 
        self.managedObjectContext = [(tyxAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    }
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    /*
	 Set up the fetched results controller.
     */
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Patient" inManagedObjectContext:__managedObjectContext];
	[fetchRequest setEntity:entity];

    // Sort using the timeStamp property..
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lname" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
		
    // Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];
    
//    // Use predicate
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dateend = %@", nil];
//    [fetchRequest setPredicate:predicate];
    
    // Use the sectionNameKeyPath property to group into sections.
	NSFetchedResultsController *FetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:__managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    FetchedResultsController.delegate = self;
	self.fetchedResultsController = FetchedResultsController;
	
	return fetchedResultsController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Get managedObjectContext from App delegate.
    if (self.managedObjectContext == nil) 
    { 
        self.managedObjectContext = [(tyxAppDelegate *)[[UIApplication sharedApplication] delegate]managedObjectContext]; 
        //NSLog(@"After managedObjectContext: %@",  self.managedObjectContext);
    }
    
    [self fetchedResultsController];
    
    NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
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
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    fetchedResultsController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

#pragma mark TableView Section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = [[fetchedResultsController sections]count];
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    NSInteger count = [sectionInfo numberOfObjects];
    return  count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    //here is some work to do
    if (section == 0) {
        return @"Neurospine Center";
    }
    else {
        return @"Eichhoffklinik";
    }
//    id <NSFetchedResultsSectionInfo> theSection = [[fetchedResultsController sections]objectAtIndex:section];
//    static NSDictionary *patientOverviewSections;
//    patientOverviewSections = [NSDictionary dictionaryWithObjectsAndKeys:@"Neurospine Center",@"1",
//                               @"Eichhoff Klinik",@"2",@"ambulant",@"3", nil];
//    
//    //NSInteger numericSection =[[theSection name]integerValue];
//    //Dictionary Zugriff muss erstellt werden.
//    NSString *titleString = [NSString stringWithFormat:@"%s",[patientOverviewSections objectForKey:[theSection name]]];
//    NSLog(@"%@",titleString);
//    return titleString;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PatientCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    Patient *patient = [fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString  *patientname = [[NSString alloc] init];
    patientname = [patientname stringByAppendingString:[patient lname]];
    patientname = [patientname stringByAppendingString:@", "];
    patientname = [patientname stringByAppendingString:[patient fname]];
    
    UILabel *patientNameTextfield = (UILabel *)[cell viewWithTag:100];
    patientNameTextfield.text = patientname;

    UIImageView *patientpicture = (UIImageView *) [cell viewWithTag:102];
    patientpicture.image = [UIImage imageWithData:[patient picture]];
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
    //This is getting the data from my CoreData fetch
    Patient *patient = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //I am able to now get the data for my specific key called complete
    //NSLog(@"Data: %@",[patient valueForKey:@"lname"]);
    // I can use [patient setValue:[NSNumber numberWithBool:NO] forKey:@"complete"];
    // to set the value to false.
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.detailViewController = (tyxDetailViewController *)[self.splitViewController.viewControllers lastObject];
    //Patient *object = [self.fetchedObjects objectAtIndex:indexPath.row];
    
    self.detailViewController.detailItem = patient;
    NSLog(@"%@",patient);
}

@end
