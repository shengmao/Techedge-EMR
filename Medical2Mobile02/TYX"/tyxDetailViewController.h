//
//  tyxDetailViewController.h
//  TYX"
//
//  Created by LISComputer on 12.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/Coredata.h>
//#import "Patient.h"
//#import "PossibleICDNumber.h"
//#import "Desease.h"

@class coredataMasterViewController;

@interface tyxDetailViewController : UITableViewController

@property (strong, nonatomic) id detailItem;

//@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *patientview;
//@property (weak, nonatomic) IBOutlet UILabel *shortdescription;
//
//@property (weak, nonatomic) IBOutlet UILabel *ICDnumber;
//@property (weak, nonatomic) IBOutlet UILabel *startdate;

@property ( strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *fetchedObjects;
@property (strong, nonatomic) coredataMasterViewController *masterview;
@property (strong, nonatomic) NSArray *fetchedObjects1;

@end
