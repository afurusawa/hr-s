//
//  UserLeaveTypeViewController.h
//  Timesheet
//
//  Created by Andrew Furusawa on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserLeaveTypeViewController;

@protocol UserLeaveTypeViewControllerDelegate <NSObject>
- (UIPopoverController *)getPopover;
- (void)refreshViewWithLeaveTypeName:(NSString *)typeName;
@end

@interface UserLeaveTypeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *leaveTypeList;
}

@property (weak, nonatomic) id <UserLeaveTypeViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *leaveTypeTable;

@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;
- (IBAction)goBack:(id)sender;

@end
