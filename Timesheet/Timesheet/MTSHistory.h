//
//  MTSHistory.h
//  Timesheet
//
//  Created by Andrew Furusawa on 12/3/12.
//
//

#import <UIKit/UIKit.h>

@interface MTSHistory : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *htable;

@end
