//
//  SimpleNameCell.h
//  HRDirectory
//
//  Created by Alex Chiu on 8/8/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//
//  Defines a simple cell used in the list view in the Contacts directory and the Search directory.

#import <UIKit/UIKit.h>

@interface SimpleNameCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblFirstName;
@property (weak, nonatomic) IBOutlet UILabel *lblLastName;
@property (weak, nonatomic) IBOutlet UILabel *lblDepartment;

@end
