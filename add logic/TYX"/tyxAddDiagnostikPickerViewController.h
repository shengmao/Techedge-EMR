//
//  tyxAddDiagnostikPickerViewController.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 27.06.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tyxAddDiagnostikPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
   IBOutlet UIPickerView *activitytypePicker;
}
@property NSMutableArray *activitytype;
- (IBAction)saveDiagnostic:(id)sender;
@end
