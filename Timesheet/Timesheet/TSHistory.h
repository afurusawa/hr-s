//
//  TimesheetHistory.h
//  Timesheet
//
//  Created by Andrew Furusawa on 11/27/12.
//
//

#import <UIKit/UIKit.h>

@interface TSHistory : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tshtable;
@property BOOL sup;

@end
