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

typedef enum
{
    selectedOptionName,
    selectedOptionDepartment,
} selectedOption;

@interface iPhoneOfflineSearchViewController : UnderlyingView<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    //Instance Variables
    NSMutableArray *employeeArray;
    NSMutableArray *displayEmployeeArray;
    int selected;
    
    NSMutableArray *letters; //Contains all the letters
    NSMutableArray *structuredDisplyEmployeeArray;  //Structures the displayEmployeeArray
    
    IBOutlet UITableView *table;
}

- (IBAction)goBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *btnName;
@property (weak, nonatomic) IBOutlet UIButton *btnDepartment;
@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;

- (IBAction)selectName:(id)sender;
- (IBAction)selectDepartment:(id)sender;

@end
