//
//  tyxDetailViewController.m
//  TYX"
//
//  Created by LISComputer on 12.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tyxDetailViewController.h"
#import "coredataMasterViewController.h"
#import "tyxAppDelegate.h"
#import "Desease.h"
#import "PossibleICDNumber.h"

@interface tyxDetailViewController ()
- (void)configureView;
- (void)acesscoredta;
@end

@implementation tyxDetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize patientview = _patientview;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize fetchedObjects = __fetchedObjects;
@synthesize masterview =_masterview;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

}



- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
     
        // Configure the name of patient...
        NSString  *patientname = [[NSString alloc] init];
        patientname = [patientname stringByAppendingString: [self.detailItem fname]];
        patientname = [patientname stringByAppendingString:@" "];
        patientname = [patientname stringByAppendingString:[self.detailItem lname]];

        self.detailDescriptionLabel.text = patientname;
        NSLog(@"detailDescriptionLabel passed successfully");
        
        
        //Configure the patient picture.
        if([self.detailItem picture]){
        UIImage *patientpic =[UIImage imageWithData:[self.detailItem picture]];
        _patientview.image = patientpic;
        }
        else{
            _patientview.image = [UIImage imageNamed:@"patientpicture.png"];
        }
    }
    
}

- (void) acesscoredta
{
    
//    //Pass managedObjectContext from App delegate.
//    if (self.managedObjectContext == nil) 
//    { 
//       self.managedObjectContext = [(tyxAppDelegate *)[[UIApplication sharedApplication] delegate]managedObjectContext]; 
//       NSLog(@"After managedObjectContext: %@",  self.managedObjectContext);
//    }
//    //create a row in datatable Desease.
//    Desease *desease = [NSEntityDescription insertNewObjectForEntityForName:@"Desease" inManagedObjectContext:self.managedObjectContext];
//    [desease setDatestart:[NSDate date]];    
//     self.masterview = (coredataMasterViewController *)[self.splitViewController.viewControllers objectAtIndex:0];
//    [desease setPatient: [self.masterview.fetchedObjects objectAtIndex:0]];
//    
//    //create a row in database possibleicdnumber.
    

    
    
//    NSError *error = nil;
//    
//    // Define which datatable should be accessed. 
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Desease"
//                                                  inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:entity];
//        
//    // Define how we will sort the records  
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fname" ascending:NO];  
//    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];  
//    [fetchRequest setSortDescriptors:sortDescriptors];  
//       
//    //Define the selection criteria.
//    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(fname Like 'Martin')" ];
//    //[fetchRequest setPredicate:predicate];
//       
//    //Execute Request.
//    self.fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self acesscoredta];
    [self configureView];
    
}

- (void)viewDidUnload
{
    [self setPatientview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.detailDescriptionLabel = nil;
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

#pragma mark - Split view
/*
- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Masterha2");
    [self.navigationItem setLeftBarButtonItem:(UIBarButtonItem *)barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}
*/
@end
