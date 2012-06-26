//
//  tyxMasterViewController.h
//  TYX"
//
//  Created by LISComputer on 12.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class tyxDetailViewController;

@interface tyxMasterViewController : UITableViewController

@property (strong, nonatomic) tyxDetailViewController *detailViewController;
@property (weak, nonatomic) IBOutlet UIImageView *mvimage;
@property (weak, nonatomic) IBOutlet UIImageView *mvimage3;
@property (weak, nonatomic) IBOutlet UIImageView *mvimage2;
@property (weak, nonatomic) IBOutlet UIImageView *mvimage4;
@property (weak, nonatomic) IBOutlet UIImageView *mvimage5;

@end
