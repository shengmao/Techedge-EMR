//
//  tyxthirddetailViewController.m
//  TYX"
//
//  Created by LISComputer on 15.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tyxthirddetailViewController.h"

@interface tyxthirddetailViewController ()

@end

@implementation tyxthirddetailViewController
@synthesize Eclipse;

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
    self.Eclipse.image = [UIImage imageNamed:@"img1.bmp"];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setEclipse:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
