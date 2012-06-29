//
//  tyxAddDiagnostikPickerViewController.m
//  Medical2Mobile
//
//  Created by Sandra Möller on 27.06.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import "tyxAddDiagnostikPickerViewController.h"

@implementation tyxAddDiagnostikPickerViewController
@synthesize activitytype;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    activitytype = [[NSMutableArray alloc] init];
    [activitytype addObject:@"Anamnese"];
    [activitytype addObject:@"Diagnose"];
    [activitytype addObject:@"Befund"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)viewDidUnload {
    activitytypePicker = nil;
    selectedPickerRow = nil;
    choosenDiagnosticNumber = nil;
    shortDescription = nil;
    longDescription = nil;
    [super viewDidUnload];
}

#pragma mark PickerView 
#pragma mark PickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [activitytype count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [activitytype objectAtIndex:row];
}

#pragma mark PickerView Handling
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"Selected: %@. Index of selected: %i", [activitytype objectAtIndex:row], row);
}
#pragma mark saveData
- (IBAction)saveDiagnostic:(id)sender 
{
    NSLog(@"Code for saving data goes here.");
}
@end
