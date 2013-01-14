//
//  JobViewController.h
//  Timesheet
//
//  Created by Andrew Furusawa on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class JobViewController;

@protocol JobViewControllerDelegate <NSObject>
//- (NSInteger)getJobIndex;
- (NSMutableArray *)getCurrentTaskList;
- (void)setJobName:(NSString *)name;
- (void)setTaskListEmpty:(BOOL)i;
- (UIPopoverController *)getPopover;
//- (void)refreshView;
- (NSInteger)getTotalAssigned:(NSInteger)i;
@end


@interface JobViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *jobNumberList;
    NSMutableArray *jobNameList;

}

@property (weak, nonatomic) id <JobViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *jobTable;

- (IBAction)clearJob:(id)sender;

//- (IBAction)iPhoneClearJob:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;
- (IBAction)goBack:(id)sender;
@end
