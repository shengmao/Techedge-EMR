//
//  tyxMasterViewController.h
//  TYX"
//
//  Created by LISComputer on 12.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@class tyxDetailViewController;

@interface tyxMasterViewController : UITableViewController

{
    sqlite3 *medicaldb;
    NSString *databasePath;
}

@property (strong, nonatomic) tyxDetailViewController *detailViewController;
//@property (strong, nonatomic) NSMutableArray *sectionNumberDictionary;

@end
