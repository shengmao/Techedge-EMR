//
//  tyxSingleVitalFunctionGraphViewController.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 02.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "sqlite3.h"

@interface tyxSingleVitalFunctionGraphViewController : UIViewController <CPTPlotDataSource>
{	
    IBOutlet CPTGraphHostingView *hostView;
	CPTXYGraph *graph;
    NSMutableArray *xyvaluepairs;
    sqlite3 *medicaldb;
    NSString *databasePath;
}
@end
