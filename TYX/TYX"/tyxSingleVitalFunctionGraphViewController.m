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
#define NUM_SAMPLES 30

#define X_VAL @"X_VAL"
#define Y_VAL @"Y_VAL"

@interface tyxSingleVitalFunctionGraphViewController ()

@end

@implementation tyxSingleVitalFunctionGraphViewController



-(void) generateDataSamples
{
	double length = (END_POINT - START_POINT);
	double delta = length / (NUM_SAMPLES - 1);
	
	samples = [[NSMutableArray alloc] initWithCapacity:NUM_SAMPLES];
	
	for (int i = 0; i < NUM_SAMPLES; i++){
		double x = START_POINT + (delta * i);
		double y = x * x;
		NSDictionary *sample = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSNumber numberWithDouble:x],X_VAL,
								[NSNumber numberWithDouble:y],Y_VAL,
								nil];
		[samples addObject:sample];
 
	}	
    NSLog(@"%@",samples);
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot; 
{
	return NUM_SAMPLES;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum 
			   recordIndex:(NSUInteger)index;
{
	NSDictionary *sample = [samples objectAtIndex:index];
	
	if (fieldEnum == CPTScatterPlotFieldX)
		return [sample valueForKey:X_VAL];
	else
		return [sample valueForKey:Y_VAL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	[self generateDataSamples];
	
	double xAxisStart = START_POINT;
	double xAxisLength = END_POINT - START_POINT;
	
	double maxY = [[samples valueForKeyPath:@"@max.Y_VAL"] doubleValue];
	double yAxisStart = -maxY;
	double yAxisLength = 2 * maxY;
	
	
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