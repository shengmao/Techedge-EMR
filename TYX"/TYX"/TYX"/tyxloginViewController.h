//
//  tyxloginViewController.h
//  TYX"
//
//  Created by LISComputer on 18.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tyxloginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *customerLogo;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwortTextfield;
@property (weak, nonatomic) IBOutlet UIImageView *companyLogo;
- (IBAction)establishConnection:(id)sender;


/*
@property (weak, nonatomic) IBOutlet UIImageView *customerLogo;
@property (weak, nonatomic) IBOutlet UITextField *passwortTextfield;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
- (IBAction)establishConnection:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *companyLogo;
*/

@end
