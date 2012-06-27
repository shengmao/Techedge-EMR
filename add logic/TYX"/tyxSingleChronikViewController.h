//
//  tyxSingleChronikViewController.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 26.06.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface tyxSingleChronikViewController : UITableViewController
{
    sqlite3 *medicaldb;
    NSString *databasePath;
}
@end
