//
//  SearchViewController.h
//  HRDirectory
//
//  Created by Alex Chiu on 8/8/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnderlyingView.h"
#import "EmployeeDetailsViewController.h"

@interface SearchViewController : UnderlyingView <EmployeeDetailsViewControllerDelegate,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    //Instance Variables
    NSMutableArray *employeeArray;
    NSMutableArray *displayEmployeeArray;
    
    IBOutlet UISegmentedControl *toggleSegment;
    IBOutlet UITableView *table;

    BOOL keyboardShown;
}

- (IBAction)goBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
