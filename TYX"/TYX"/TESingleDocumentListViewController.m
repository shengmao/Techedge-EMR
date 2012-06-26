//
//  TESingleDocumentListViewController.m
//  AlHami@Mobile
//
//  Created by Sandra Möller on 21.06.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import "TESingleDocumentListViewController.h"
#import <QuickLook/QuickLook.h>


@interface TESingleDocumentListViewController ()

@end

@implementation TESingleDocumentListViewController
@synthesize FileListTableView;
@synthesize fileURL;
@synthesize pdfPath;

#define kStringURLViewControllerPDF @"https://developer.apple.com/library/ios/DOCUMENTATION/NetworkingInternet/Reference/QLPreviewController_Class/QLPreviewController_Class.pdf"

#define kStringURLQLPreviewControllerPDF @"https://developer.apple.com/library/ios/DOCUMENTATION/NetworkingInternet/Reference/QLPreviewController_Class/QLPreviewController_Class.pdf"

#define kStringURLUIDocumentInteractionControllerPDF @"https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIDocumentInteractionController_class/UIDocumentInteractionController_class.pdf"


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //read document directory from the application
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSLog(@"%@",path);
    
    //set up data for table view
    fileNameList = [[NSArray alloc] initWithObjects:@"Bild",@"UIViewController", @"QLPreview",@"localPDF", nil];
    
	//set up pdfpath
    pdfPath = [[NSBundle mainBundle] pathForResource:@"PDF" ofType:@"pdf"];
}

- (void)viewDidUnload
{
    FileListTableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Table view data source

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
    switch (indexPath.row) {
        case 0:
            fileURL = [NSURL URLWithString:kStringURLViewControllerPDF];
            break;
        case 1:
            fileURL = [NSURL URLWithString:kStringURLQLPreviewControllerPDF];
        case 2:
            fileURL = [NSURL URLWithString:kStringURLUIDocumentInteractionControllerPDF];
            break;
        case 3:
            fileURL = [NSURL fileURLWithPath:pdfPath];
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
    return fileURL;
}
@end
