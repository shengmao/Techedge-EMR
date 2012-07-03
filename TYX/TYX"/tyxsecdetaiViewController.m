//
//  tyxsecdetaiViewController.m
//  TYX"
//
//  Created by LISComputer on 12.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tyxsecdetaiViewController.h"

@interface tyxsecdetaiViewController ()

@end

@implementation tyxsecdetaiViewController

- (void)viewDidLoad
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

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
    } 
}
@end