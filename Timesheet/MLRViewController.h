//
//  MLRViewController.h
//  Timesheet
//
//  Created by Andrew Furusawa on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLRDetailViewController.h"

@interface MLRViewController : UIViewController <MLRDetailViewControllerDelegate>
{
    NSString *workerName;
    NSInteger selectedIndex;
}

@property (weak, nonatomic) IBOutlet UITableView *leaveRequestTable;

@end
