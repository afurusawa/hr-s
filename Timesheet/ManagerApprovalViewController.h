//
//  ManagerApprovalViewController.h
//  Timesheet
//
//  Created by Andrew Furusawa on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ManagerApprovalViewController;

@protocol ManagerApprovalViewControllerDelegate <NSObject>
- (void)refreshView;
@end

@interface ManagerApprovalViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
{
    //NSMutableArray *hoursList;
    //NSMutableArray *projectsList;
    //NSMutableArray *totalHoursList;
    
    
    //parse statistics
    NSString *hWeek;// = [temp objectAtIndex:0];
    NSString *jWeek;// = [temp objectAtIndex:1];
    NSString *hDay;// = [temp objectAtIndex:2];
    NSString *jDay;// = [temp objectAtIndex:3];
    NSString *totalHours;// = [temp objectAtIndex:4];
    
    NSArray *hoursWeek;// = [hWeek componentsSeparatedByString: @";"];
    NSArray *jobsWeek;// = [jWeek componentsSeparatedByString: @";"];
    NSArray *hoursDay;// = [hDay componentsSeparatedByString: @";"];
    NSArray *jobsDay;
}

- (IBAction)approveTimesheet:(id)sender;
- (IBAction)denyTimesheet:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *totalHoursLabel;

@property (weak, nonatomic) IBOutlet UITextView *managerNotes;

@property (weak, nonatomic) id <ManagerApprovalViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *overviewTable;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
