#import <UIKit/UIKit.h>
#import "sqlite3.h"

@class tyxDetailViewController;

@interface tyxMasterViewController : UITableViewController

{
    sqlite3 *medicaldb;
    NSString *databasePath;
}

@property (strong, nonatomic) tyxDetailViewController *detailViewController;
//@property (strong, nonatomic) NSMutableArray *sectionNumberDictionary;

@end
