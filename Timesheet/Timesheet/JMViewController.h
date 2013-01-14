//
//  JMViewController.h
//  Timesheet
//
//  Created by Jun on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMJobViewController.h"
#import "JMMemberViewController.h"

@interface JMViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, JMJobViewControllerDelegate, JMMemberViewControllerDelegate>
{

    NSString *jobName;
    
    NSMutableArray *workerList; //stores the employee ids of the workers
    NSMutableArray *nameList; //stores the name of the workers
    NSMutableArray *jobList;
    
    UIPopoverController *popover;
}
@property (strong, nonatomic) IBOutlet UITableView *workerTable;
@property (strong, nonatomic) IBOutlet UITableView *jobTable;

@property (weak, nonatomic) IBOutlet UIButton *addTaskButton;
@property (weak, nonatomic) IBOutlet UIButton *addTeamMemberButton;
@property (weak, nonatomic) IBOutlet UILabel *selectTeamMemberLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@property (weak, nonatomic) IBOutlet UILabel *assignTaskLabel;

- (IBAction)removeTask:(id)sender;
- (IBAction)removeTeamMember:(id)sender;
- (void)animateDeleteWithIndex:(NSInteger)i;
@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;
- (IBAction)goBack:(id)sender;

//label
@property (weak, nonatomic) IBOutlet UILabel *teammemberTextLabel;


@end
