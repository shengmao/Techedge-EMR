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
    IBOutlet UILabel *selectedPickerRow;
    IBOutlet UITextField *choosenDiagnosticNumber;
    IBOutlet UITextField *shortDescription;
    IBOutlet UITextView *longDescription;
}
@property NSMutableArray *activitytype;
- (IBAction)saveDiagnostic:(id)sender;
@end
