//
//  coredataMasterViewController.h
//  Medical2Mobile
//
//  Created by LISComputer on 03.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Coredata/Coredata.h>

@class tyxDetailViewController;
@interface coredataMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property ( strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *fetchedObjects;
@property (strong, nonatomic) tyxDetailViewController *detailViewController;
//testing properties
@property (nonatomic,retain) NSFetchedResultsController *fetchedResultsController;
@end
