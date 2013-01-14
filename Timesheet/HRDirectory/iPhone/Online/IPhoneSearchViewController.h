//
//  IPhoneSearchViewController.h
//  HR_Suite
//
//  Created by Alex Chiu on 9/7/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnderlyingView.h"

typedef enum
{
    selectedOptionName,
    selectedOptionDepartment,
} selectedOption;

@interface IPhoneSearchViewController : UnderlyingView<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    //Instance Variables
    NSMutableArray *employeeArray;
    NSMutableArray *displayEmployeeArray;
    int selected;
    
    __weak IBOutlet UINavigationBar *navbar;

    NSMutableArray *letters; //Contains all the letters
    NSMutableArray *structuredDisplyEmployeeArray;  //Structures the displayEmployeeArray
    
    IBOutlet UITableView *table;
}

- (IBAction)goBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *btnName;
@property (weak, nonatomic) IBOutlet UIButton *btnDepartment;

- (IBAction)selectName:(id)sender;
- (IBAction)selectDepartment:(id)sender;

@end
