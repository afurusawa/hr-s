//
//  OfflineSearchViewController.h
//  HRDirectory
//
//  Created by Alex Chiu on 9/18/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnderlyingView.h"

@interface OfflineSearchViewController : UnderlyingView<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    //Instance Variables
    NSMutableArray *employeeArray;
    NSMutableArray *displayEmployeeArray;
    
    IBOutlet UISegmentedControl *toggleSegment;
    IBOutlet UITableView *table;
    
    NSString *selectedSearchOption;
    
}

- (IBAction)goBack:(id)sender;
- (IBAction)changeToggleSettings:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
