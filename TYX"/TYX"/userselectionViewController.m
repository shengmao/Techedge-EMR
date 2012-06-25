//
//  userselectionViewController.m
//  TYX"
//
//  Created by LISComputer on 22.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "userselectionViewController.h"

@interface userselectionViewController ()

@end

@implementation userselectionViewController
@synthesize patientview;
@synthesize emailview;
@synthesize calenderview;
@synthesize Intranetview;

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
     patientview.image = [UIImage imageNamed:@"patient1.jpg"];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPatientview:nil];
    [self setEmailview:nil];
    [self setCalenderview:nil];
    [self setIntranetview:nil];
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
/*
- (void)mouseDragged:(NSEvent *)event {
    NSPoint eventLocation = [event locationInWindow];
    center = [self convertPoint:eventLocation fromView:nil];
    //[self setNeedsDisplay:YES];
}
*/

@end
