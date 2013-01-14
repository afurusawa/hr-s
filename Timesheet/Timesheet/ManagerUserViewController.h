//
//  ManagerUserViewController.h
//  Timesheet
//
//  Created by Andrew Furusawa on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerApprovalViewController.h"

@interface ManagerUserViewController : UIViewController <ManagerApprovalViewControllerDelegate>
{
    NSMutableArray *workerList;
    NSMutableArray *dateList;
    NSMutableArray *timestampList;
    
    NSMutableArray *filter;
    
    NSString *workerName;
    
    NSString *currentDate;
}

@property (weak, nonatomic) IBOutlet UITableView *workerTable;

- (IBAction)goBack:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;

@end
