//
//  ManagerListTableViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 11/27/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "ManagerListTableViewController.h"

@interface ManagerListTableViewController ()

@end

@implementation ManagerListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.managersList count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"ManagerCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    cell.textLabel.text = [self.managersList objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Getting the name of the manager
    NSString *managerName = [self.managersList objectAtIndex:indexPath.row];
    
    //Change the selected manager login (their unique identifier) to the manager selected
    NSString *managerUsername = [self.managersUsernameList objectAtIndex:indexPath.row];
    
    [self.delegate selectedManager:managerName userName:managerUsername];
    
    //exit table view
    [self.navigationController popViewControllerAnimated:YES];
}

@end
