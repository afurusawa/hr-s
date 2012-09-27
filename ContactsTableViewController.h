//
//  ContactsTableViewController.h
//  HRDirectory
//
//  Created by Alex Chiu on 8/8/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UnderlyingView.h"
//#import "SUPSyncStatusListener.h"

@interface ContactsTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    //Instance Variables
    NSMutableArray *employeeArray;
    IBOutlet UITableView *table;
}

@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@end
