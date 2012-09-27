//
//  JMTeamMemberViewController.h
//  Timesheet
//
//  Created by Rapid Consulting on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMJobViewController.h"


@interface JMTeamMemberViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, JMJobViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *taskTable;

- (IBAction)removeTask:(id)sender;

@end
