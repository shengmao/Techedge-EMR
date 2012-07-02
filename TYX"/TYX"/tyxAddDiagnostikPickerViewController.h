//
//  tyxAddDiagnostik.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 29.06.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface tyxAddDiagnostikPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    sqlite3 *medicaldb;
    NSString *databasePath;
}
@property (weak, nonatomic) IBOutlet UIPickerView *activitytypePicker;
@property NSMutableArray *activitytype;
@property (weak, nonatomic) IBOutlet UILabel *selectedPickerRow;
@property (weak, nonatomic) IBOutlet UITextField *choosenNumber;
@property (weak, nonatomic) IBOutlet UITextField *shortDescription;
@property (weak, nonatomic) IBOutlet UITextView *longDescription;
@end