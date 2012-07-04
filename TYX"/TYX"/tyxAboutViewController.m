//
//  tyxAboutViewController.m
//  Medical2Mobile
//
//  Created by Sandra Möller on 25.06.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import "tyxAboutViewController.h"

@interface tyxAboutViewController ()

@end

@implementation tyxAboutViewController
@synthesize versionNumber;

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
	// Do any additional setup after loading the view.
    versionNumber.text = [[NSBundle bundleForClass:[self class]] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

- (void)viewDidUnload
{
    [self setVersionNumber:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
