//
//  LRHistory.h
//  Timesheet
//
//  Created by Andrew Furusawa on 11/27/12.
//
//

#import <UIKit/UIKit.h>

@interface LRHistory : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *lrhtable;
@property BOOL sup;
@end
