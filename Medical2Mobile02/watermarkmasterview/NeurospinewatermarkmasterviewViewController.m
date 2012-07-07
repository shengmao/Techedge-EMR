//
//  NeurospinewatermarkmasterviewViewController.m
//  TYX"
//
//  Created by LISComputer on 25.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NeurospinewatermarkmasterviewViewController.h"

@interface NeurospinewatermarkmasterviewViewController ()
@property NSMutableArray *usertabsarray;

@end

@implementation NeurospinewatermarkmasterviewViewController
@synthesize usertabs;
@synthesize usertabsarray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    usertabsarray = [[NSMutableArray alloc] initWithObjects:@"Übersicht", @"Chronik", @"Diagnostik", @"klinische Aufträge", @"Vitalwerte", @"Labor", @"Demographie", @"Dokumente", @"Abrechnung", @"EMR Info",nil];
    
    
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated

{
    
    //preselect a cell
    
    NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
    
    [(UITableView*)self.usertabs selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
    
}

- (void)viewDidUnload
{
    [self setUsertabs:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark patientList - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [self.usertabsarray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    // Configure the cell...
    cell.textLabel.text = [self.usertabsarray objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //read the current selection in tableview and perform the next segue
     NSString *object = [self.usertabsarray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:object sender:self];
}

@end
