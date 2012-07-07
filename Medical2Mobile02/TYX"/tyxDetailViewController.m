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
#import "Patient.h"

@interface tyxDetailViewController ()
- (void)configureView;
//- (void)acesscoredta;
@property NSMutableArray *patientArray;
@property NSMutableDictionary *patientDictionary;
@end

@implementation tyxDetailViewController

@synthesize detailItem = _detailItem;
//@synthesize detailDescriptionLabel = _detailDescriptionLabel;
//@synthesize patientview = _patientview;
//@synthesize shortdescription = _shortdescription;
//@synthesize ICDnumber = _ICDnumber;
//@synthesize startdate = _startdate;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize fetchedObjects = __fetchedObjects;
@synthesize fetchedObjects1 = __fetchedObjects1;
@synthesize masterview =_masterview;
@synthesize patientArray;
@synthesize patientDictionary;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    if (_detailItem != newDetailItem) 
    {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    else {
        NSLog(@"hier bin ich");
        //using default lines
        NSArray *PatientBasic = [NSArray arrayWithObjects:@"Nachname", @"Vorname", [UIImage imageNamed:@"patientpicture.png"], nil];
        NSMutableDictionary *section1Dictionary = [NSMutableDictionary dictionaryWithObject:PatientBasic forKey:@"PatientBasic"];
        [patientArray addObject:section1Dictionary];
        patientDictionary = [NSMutableDictionary dictionaryWithObject:section1Dictionary forKey:@"PatientDetails"];
        NSLog(@"%@",section1Dictionary);
        
        NSArray *PatientDesease = [NSArray arrayWithObjects:@"Diagnose",@"ICDNummer", nil];
        NSMutableDictionary *section2Dictionary = [NSMutableDictionary dictionaryWithObject:PatientDesease forKey:@"PatientDesease"];
        [patientArray addObject:section2Dictionary]; 
        patientDictionary = [NSMutableDictionary dictionaryWithObject:section2Dictionary forKey:@"PatientDesease"];
        NSLog(@"%@",section2Dictionary);

        
        NSArray *PatientIssue = [NSArray arrayWithObjects:@"Auftrag", nil];
        NSMutableDictionary *section3Dictionary = [NSMutableDictionary dictionaryWithObject:PatientIssue forKey:@"PatientIssue"];
        [patientArray addObject:section3Dictionary];
        patientDictionary = [NSMutableDictionary dictionaryWithObject:section3Dictionary forKey:@"PatientIssue"];
        NSLog(@"%@",section3Dictionary);
        
        patientDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:section1Dictionary, @"PatientBasic", section2Dictionary, @"PatientDesease", section3Dictionary, @"PatientIssue", nil];
        NSLog(@"%@",[patientDictionary allKeys]);
        NSLog(@"%@",[patientDictionary allValues]);
    }
}



- (void)configureView
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    // Update the user interface for the detail item.
    NSLog(@"%@",self.detailItem);
    patientArray = [[NSMutableArray alloc]init];
    patientDictionary = [NSMutableDictionary dictionary];
    if (self.detailItem) 
    {
        patientArray = [[NSMutableArray alloc] init];
        
        //Configure the name of patient...
        NSString  *patientname = [[NSString alloc] init];
        patientname = [patientname stringByAppendingString: [self.detailItem fname]];
        patientname = [patientname stringByAppendingString:@" "];
        patientname = [patientname stringByAppendingString:[self.detailItem lname]];
        
        
        //Configure the patient picture.
        if([self.detailItem picture])
        {
            UIImage *patientpic =[UIImage imageWithData:[self.detailItem picture]];
            //configure first section for patient details
            NSArray *PatientBasic = [NSArray arrayWithObjects: [self.detailItem lname],[self.detailItem fname], patientpic, nil];
            NSMutableDictionary *sectionDictionary = [NSMutableDictionary dictionaryWithObject:PatientBasic forKey:@"PatientBasic"];
            [patientArray addObject:sectionDictionary];
        }
        else
        {
            //load default picture if the patient do not have one
            NSArray *PatientBasic = [NSArray arrayWithObjects:patientname, [UIImage imageNamed:@"patientpicture.png"], nil];
            NSMutableDictionary *sectionDictionary = [NSMutableDictionary dictionaryWithObject:PatientBasic forKey:@"PatientDetails"];
            [patientArray addObject:sectionDictionary];
        }
        
        NSLog(@"%@",patientArray);
        
        //        NSEnumerator *enumerator = [[self.detailItem desease ] objectEnumerator ];
        //        Desease *desease;
        //        
        //        if ([[self.detailItem desease] count] >= 1) 
        //        {
        //            while (desease = [enumerator nextObject]){
        //                self.shortdescription.text = [[desease possibleicdnumber] field7_description];
        //                self.ICDnumber.text = [[desease possibleicdnumber] field4_primaryKey]; 
        //                
        //                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //                [formatter setDateFormat:@"dd-MM-yyyy"];
        //                NSString *stringFromDate = [formatter stringFromDate:[desease datestart]];
        //                self.startdate.text = stringFromDate;
        //                
        //                
        //            }                       
        //        } 
        //        else 
        //        {
        //            self.shortdescription.text =@"";
        //            self.ICDnumber.text = @"ICD Number";
        //            self.startdate.text =@"14.02.2012";
        //        }
    }  
    else 
    {
//do nothing
        NSLog(@"hier passiert nichts");
    }
}

- (void)viewDidLoad
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    [super viewDidLoad];
    [self setDetailItem:_detailItem];
}

- (void)viewDidUnload
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    //    [self setPatientview:nil];
    //    [self setShortdescription:nil];
    //    [self setICDnumber:nil];
    //    [self setStartdate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    //    self.detailDescriptionLabel = nil;
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

#pragma mark - Table view data source

#pragma mark TableView Section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    //number of predefined sections to show
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    if (section==0)
    {
        return 1;
    }
    else
    { 
        //returns number of rows in a section, here is a problem reading number of rows of a section, because this section also uses a dictionary
        NSMutableDictionary *helperDictionary = [patientArray objectAtIndex:section];
        NSMutableArray *helperArray = [helperDictionary objectForKey:@"PatientDesease"];
        NSLog(@"%@",helperArray);
        NSLog(@"%i",[helperArray count]);
        //return [helperArray count]; 
        return 4;
    }

    //return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    //returns predefined SectionHeader
    switch (section) {
        case 0:
            return @"Person";
            break;
        case 1:
            return @"Diagnosen";
            break;
        case 2:
            return @"klinische Aufträge";
            break;
        default:
            return @"nicht bekannt";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---> %s",__PRETTY_FUNCTION__);
    
    // Configure the cell...
    NSLog(@"Keys: %@",[patientDictionary allKeys]);
        
    switch (indexPath.section) {
        case 0:
        {               
            NSMutableDictionary *dictionary = [patientArray objectAtIndex:indexPath.section];
            NSLog(@"%@",dictionary); //null at the moment
            NSArray *array = [dictionary objectForKey:@"PatientBasic"];
            NSLog(@"%@",array);
            
            static NSString *CellIdentifier = @"PatientBasicCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            //configuration of first section look and feel
            //            UILabel *patientNameTextfield =(UILabel *)[cell viewWithTag:100];
            NSLog(@"%@",[array objectAtIndex:0]);
            cell.textLabel.text = [array objectAtIndex:0];
            cell.detailTextLabel.text = [array objectAtIndex:1];
            cell.imageView.image = [array objectAtIndex:2];
            return cell;
            break;
        }
            
        case 1:
        {
            NSMutableDictionary *dictionary = [patientArray objectAtIndex:indexPath.section];
            NSLog(@"%@",dictionary); //null at the moment
            NSArray *array = [dictionary objectForKey:@"PatientDesease"];
            //            NSMutableDictionary *sectionDictionary = [array objectAtIndex:indexPath.section];
            //            NSArray *sectionArray = [sectionDictionary objectForKey:@"PatientDesease"];
            //configuration of second section look and feel
            static NSString *CellIdentifier = @"PatientDeseaseCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            //configuration of first section look and feel
            //            UILabel *patientNameTextfield =(UILabel *)[cell viewWithTag:100];
            cell.textLabel.text = @"Diagnosen";
            //cell.textLabel.text = [array objectAtIndex:0];
            //cell.detailTextLabel.text = [array objectAtIndex:1];
            return cell;
            break;
        }
        case 2:
        {
            NSMutableDictionary *dictionary = [patientArray objectAtIndex:indexPath.section];
            NSLog(@"%@",dictionary); //null at the moment
            NSArray *array = [dictionary objectForKey:@"PatientIssue"];
            //configuration of second section look and feel
            static NSString *CellIdentifier = @"PatientIssueCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            //configuration of first section look and feel
            //            UILabel *patientNameTextfield =(UILabel *)[cell viewWithTag:100];
            cell.textLabel.text = @"Auftrag";
            //cell.textLabel.text = [array objectAtIndex:0];
            //cell.detailTextLabel.text = [array objectAtIndex:1];
            return cell;
            break;
        }
        default:
            NSLog(@"default switch");
            static NSString *CellIdentifier = @"PatientDefaultCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            //configuration of first section look and feel
            //            UILabel *patientNameTextfield =(UILabel *)[cell viewWithTag:100];
            cell.detailTextLabel.text = @"Falsche Zelle gewählt";
            //cell.detailTextLabel.text = [array objectAtIndex:1];
            return cell;
            break;
            
    }
    
    
    //        UIImageView *patientpicture = (UIImageView *) [cell viewWithTag:102];
    //        patientpicture.image = [UIImage imageWithData:@"picture.png"];
    //return cell;
}
@end
