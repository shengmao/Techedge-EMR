//
//  tyxsecdetaiViewController.m
//  TYX"
//
//  Created by LISComputer on 12.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tyxsecdetaiViewController.h"

@interface tyxsecdetaiViewController ()

//@property (strong, nonatomic) UIPopoverController *secmasterPopoverController;

@end

@implementation tyxsecdetaiViewController

//@synthesize secmasterPopoverController = _masterPopoverController;

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    } }

#pragma mark - Split view
/*
- (void)splitViewController:(UISplitViewController *)secsplitController willHideViewController:(UIViewController *)aviewController withBarButtonItem:(UIBarButtonItem *)secbarButtonItem forPopoverController:(UIPopoverController *)pc
{
    secbarButtonItem.title = NSLocalizedString(@"secMaster", @"secMaster");
    [self.navigationItem setLeftBarButtonItem:secbarButtonItem animated:YES];
    self.secmasterPopoverController = pc;
}

- (void)splitViewController:(UISplitViewController *)secsplitController willShowViewController:(UIViewController *)secviewController invalidatingBarButtonItem:(UIBarButtonItem *)secbarButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.secmasterPopoverController = nil;
}
*/
@end