//
//  TESinglesecDocumenteViewController.m
//  Medical2Mobile
//
//  Created by LISComputer on 25.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TESinglesecDocumenteViewController.h"

@interface TESinglesecDocumenteViewController ()

@end

@implementation TESinglesecDocumenteViewController

@synthesize pdfURL;
@synthesize pdfPath;

- (void)viewDidLoad
{
    [super viewDidLoad];
	//set up pdfpath
    pdfPath = [[NSBundle mainBundle] pathForResource:@"PDF" ofType:@"pdf"];
    //set up data for table view
    fileNameList = [[NSArray alloc] initWithObjects:@"Bild", nil];
    NSLog(@"%@",fileNameList);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [fileNameList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.textLabel.text = [fileNameList objectAtIndex:indexPath.row];
    return cell;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {
            //pdfURL = [NSURL URLWithString:pdfPath];
            pdfURL = [NSURL fileURLWithPath: pdfPath];       
    
    }
    
    //creating object of QLPreviewController
    QLPreviewController *previewController = [[QLPreviewController alloc] init];
    
    //setting datasource to self
    previewController.dataSource = self;
    
    //pushing the controller to navigation stack
    [[self navigationController] pushViewController:previewController animated:YES];
    //[[self navigationController] pushViewController:previewController animated:YES];
    //remove the right bar print button
    [previewController.navigationItem setRightBarButtonItem:nil];
}


#pragma mark - QLPreviewControllerDataSource
//Returns the number of items the preview controller should preview
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController
{
    return 30;
}

//returns the item that the preview controller should preview
- (id)previewController:(QLPreviewController *)previewController previewItemAtIndex:(NSInteger)index
{
    return pdfURL;
}

@end
