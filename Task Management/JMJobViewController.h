//
//  JMJobViewController.h
//  Timesheet
//
//  Created by Jun on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMViewController;
@protocol JMJobViewControllerDelegate <NSObject>
- (NSString *)getJobName;
- (UIPopoverController *)getPopover;
- (void)refreshViewForTasks;
- (void)refresh; //for iphone

@end

@interface JMJobViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *jobNumberList;
    NSMutableArray *jobNameList;

}

@property (weak, nonatomic) id <JMJobViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITableView *jobTable;


@end
