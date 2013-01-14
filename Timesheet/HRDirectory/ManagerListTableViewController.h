//
//  ManagerListTableViewController.h
//  HRDirectory
//
//  Created by Alex Chiu on 11/27/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ManagerListTableViewController;

@protocol ManagerListTableViewControllerDelegate <NSObject>

-(void)selectedManager:(NSString *)_managerName userName:(NSString *)_managerUsername;

@end

@interface ManagerListTableViewController : UITableViewController

@property (nonatomic) id<ManagerListTableViewControllerDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *managersList;
@property (strong, nonatomic) NSMutableArray *managersUsernameList;

@end
