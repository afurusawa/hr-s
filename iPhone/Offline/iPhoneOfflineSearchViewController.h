//
//  iPhoneOfflineSearchViewController.h
//  HRDirectory
//
//  Created by Alex Chiu on 9/19/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnderlyingView.h"
#import "AppDelegate.h"
#import "OfflineEmployeeDetailsViewController.h"

@interface iPhoneOfflineSearchViewController : UnderlyingView<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    //Instance Variables
    NSMutableArray *employeeArray;
    NSMutableArray *displayEmployeeArray;
    
    IBOutlet UITableView *table;
    
    NSString *selectedSearchOption;
    
}

- (IBAction)goBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
