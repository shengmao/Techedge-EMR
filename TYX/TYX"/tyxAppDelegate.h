//
//  tyxAppDelegate.h
//  TYX"
//
//  Created by LISComputer on 12.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface tyxAppDelegate : UIResponder <UIApplicationDelegate>
{
  // Database variables
NSString *databaseName;
NSString *databasePath;  
}

@property (strong, nonatomic) UIWindow *window;
@end
