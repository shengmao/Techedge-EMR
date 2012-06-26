//
//  internalpdfViewController.h
//  Medical2Mobile
//
//  Created by LISComputer on 26.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

@interface internalpdfViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource, QLPreviewControllerDataSource, QLPreviewControllerDelegate>

{
    NSArray *fileNameList;
    NSURL *pdfURL;
    NSString *pdfPath;
    
}

@property (nonatomic, retain) NSURL *pdfURL;
@property (nonatomic, retain) NSString *pdfPath;



@end
