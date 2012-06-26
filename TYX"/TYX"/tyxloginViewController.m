//
//  tyxloginViewController.m
//  TYX"
//
//  Created by LISComputer on 18.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tyxloginViewController.h"

@interface tyxloginViewController ()

@end

@implementation tyxloginViewController
@synthesize customerLogo;
@synthesize usernameTextfield;
@synthesize passwortTextfield;
@synthesize companyLogo;



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
    
    customerLogo.image = [UIImage imageNamed:@"neurospinecenter_logo.jpg"];
    companyLogo.image = [UIImage imageNamed:@"techedge_leverage_logo.jpg"];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setCustomerLogo:nil];
    [self setUsernameTextfield:nil];
    [self setPasswortTextfield:nil];
    [self setCompanyLogo:nil];
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

- (IBAction)establishConnection:(id)sender {
    //check logindata and grants access to further views
    [self performSegueWithIdentifier:@"loginSuccessful" sender:self];
}
@end
