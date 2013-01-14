//
//  JMMemberViewController.h
//  Timesheet
//
//  Created by Rapid Consulting on 8/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMMemberViewController;
@protocol JMMemberViewControllerDelegate <NSObject>

- (void)refreshViewForMembers;

@end

@interface JMMemberViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) id <JMMemberViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *employeeTable;
@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;
- (IBAction)goBack:(id)sender;

@end
