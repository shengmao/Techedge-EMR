//
//  tyxSingleVitalFunctionGraphViewController.m
//  Medical2Mobile
//
//  Created by Sandra Möller on 02.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import "tyxSingleVitalFunctionGraphViewController.h"

#define START_POINT -2.0
#define END_POINT 2.0
#define NUM_SAMPLES 2

#define X_VAL @"X_VAL"
#define Y_VAL @"Y_VAL"

@interface tyxSingleVitalFunctionGraphViewController ()

@end

@implementation tyxSingleVitalFunctionGraphViewController



-(void) generateData
{
    //set up databasePath
    NSString *docsDir;
    NSArray *dirPaths;
    
    //get documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    //Build the path to database file
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"medicaldb02.sqlite"]];
    
    const char *dbPath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbPath, &medicaldb)==SQLITE_OK) {
        //create SQL statement
        NSString *querySQL = [NSString stringWithFormat:@"SELECT xvalue, yvalue, xunit, yunit FROM tab_measurmentvalues ORDER BY dateinsert ASC;"];
        NSLog(@"%@",querySQL);
        const char *query_stmt = [querySQL UTF8String];
        
        //send SQL statement to database
        sqlite3_prepare_v2(medicaldb, query_stmt, -1, &statement, NULL);
        //fetch result of SQL statement
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            NSString *measureXValue = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
            
            NSString *measureYValue = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
            
//            NSDateFormatter *dateValue = [[NSDateFormatter alloc] init];
//            [dateValue setDateFormat:@"d LLLL yyyy"];
//            NSDate *date = [dateValue dateFromString:measureXValue];
            
            NSDictionary  *measureDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSNumber numberWithDouble:[measureXValue intValue]], X_VAL,
                                                [NSNumber numberWithDouble:[measureYValue intValue]], Y_VAL, nil];
            [xyvaluepairs addObject:measureDictionary];
        }
        NSLog(@"%@",xyvaluepairs);
        sqlite3_finalize(statement);
        sqlite3_close(medicaldb);
    }
    
//	double length = (END_POINT - START_POINT);
//	double delta = length / (NUM_SAMPLES - 1);
//	
//	xyvaluepairs = [[NSMutableArray alloc] initWithCapacity:NUM_SAMPLES];
//	
//	for (int i = 0; i < NUM_SAMPLES; i++){
//		double x = START_POINT + (delta * i);
//		double y = x * x;
//		NSDictionary *xyvalue = [NSDictionary dictionaryWithObjectsAndKeys:
//								[NSNumber numberWithDouble:x],X_VAL,
//								[NSNumber numberWithDouble:y],Y_VAL,
//								nil];
//		[xyvaluepairs addObject:xyvalue];
// 
//	}	
//    NSLog(@"%@",xyvaluepairs);
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot; 
{
	return NUM_SAMPLES;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum 
			   recordIndex:(NSUInteger)index;
{
	NSDictionary *sample = [xyvaluepairs objectAtIndex:index];
	
	if (fieldEnum == CPTScatterPlotFieldX)
		return [sample valueForKey:X_VAL];
	else
		return [sample valueForKey:Y_VAL];
}

- (void)viewDidLoad {
    [super viewDidLoad];    //create a dictionary for each section and adds them to the array wholePatientList
    xyvaluepairs = [[NSMutableArray alloc] init];
    
    
    
    
	[self generateData];
	
	double xAxisStart = START_POINT;
	double xAxisLength = END_POINT - START_POINT;
	
	double maxY = [[xyvaluepairs valueForKeyPath:@"@max.Y_VAL"] doubleValue];
	double yAxisStart = 0;
	double yAxisLength = 45;
	
	
	CPTGraphHostingView *hostingView = [[CPTGraphHostingView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:hostingView];
    
	CPTXYGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.view.bounds];
	hostingView.hostedGraph = graph;
	
	
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
	plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(xAxisStart)
												   length:CPTDecimalFromDouble(xAxisLength)];
	
	plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromDouble(yAxisStart)
												   length:CPTDecimalFromDouble(yAxisLength)];	
	
	CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] init];
	dataSourceLinePlot.dataSource = self;
	
	[graph addPlot:dataSourceLinePlot];
}

@end