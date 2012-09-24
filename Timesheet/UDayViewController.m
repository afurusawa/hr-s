//
//  UDayViewController.m
//  Timesheet
//
//  Created by Rapid Consulting on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UDayViewController.h"
#import "AppDelegate.h"
#import "DayCell.h"

#import "TimesheetDate.h"
#import "HR_SuiteTimesheet.h"
#import "HR_SuiteJobs.h"
#import "HR_SuiteHR_SuiteDB.h"

@implementation UDayViewController
{
    AppDelegate *d;
    TimesheetDate *tsDate;
    NSMutableArray *taskList;
    NSDictionary *entry;
    
    UIPopoverController *popover;
    NSInteger selectedIndex;
    
    UITapGestureRecognizer *tap;
    BOOL taskListIsEmpty;
    int selectedFieldIndex;
    
    NSInteger totalAssigned;
}
@synthesize dayLabel;
@synthesize dateLabel;
@synthesize totalHours;
@synthesize doneButton;
@synthesize addTaskButton;
@synthesize dayTable;
@synthesize lockSwitch;
@synthesize lockSwitchLabel;
@synthesize hoursField;
@synthesize delegate;



/****************************************************************************************************
 Protocol Methods
 ****************************************************************************************************/
- (void)getTotalAssigned:(NSInteger)i
{
    totalAssigned = i;
}

- (void)setTaskListEmpty:(BOOL)i
{
    taskListIsEmpty = i;
}

- (NSMutableArray *)getCurrentTaskList
{
    return taskList;
}

- (void)setJobName:(NSString *)name
{
    NSLog(@"name ===== %@", name);
    // First, if clear button was pressed, disable hours field, gray out, and set to 0
    if ([name isEqualToString:@"Touch to select task"]) {
        
        DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
        cell.taskLabel.text = @"Touch to select task";
        cell.hoursField.text = @"0";
        cell.hoursField.enabled = NO;
        cell.hoursField.textColor = [UIColor lightGrayColor];
        [taskList replaceObjectAtIndex:selectedIndex withObject:[NSDictionary dictionaryWithObjectsAndKeys:name, @"taskName", @"0", @"hours", nil]];
        cell.selected = NO;
        return;
    }

    // Next, check if job selected was a duplicate. If so, set flag.  don't add it
    BOOL isDuplicate = NO;
    int i = 0;
    for (NSDictionary *item in taskList) {

        // If duplicate was found, set flag
        if ([[item objectForKey:@"taskName"] isEqualToString:name]) {
            isDuplicate = YES;            
        }
        i++;        
    } //end for
    
    
    // If duplicate was found, keep hours field disabled 
    if (isDuplicate) {
        NSLog(@"Is duplicate");
        DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.hoursField.text = @"0";
        cell.hoursField.enabled = NO;
        cell.hoursField.textColor = [UIColor lightGrayColor];
    }
    
    // Otherwise replace last cell, reload table, and set hours field enabled
    else {
        [taskList replaceObjectAtIndex:selectedIndex withObject:[NSDictionary dictionaryWithObjectsAndKeys:name, @"taskName", @"0", @"hours", nil]];
        [self.dayTable reloadData];

        // Enable hours entry
        DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.hoursField.enabled = YES;
        cell.hoursField.textColor = [UIColor blackColor];
    }
    
    
//    if (taskListIsEmpty) {
//        //addTaskButton.hidden = YES;
//        [addTaskButton setEnabled:NO];
//        addTaskButton.titleLabel.textColor = [UIColor lightGrayColor];
//        NSLog(@"task list button is empty");
//    }
//    else {
//        //addTaskButton.hidden = NO;
//        [addTaskButton setEnabled:YES];
//        addTaskButton.titleLabel.textColor = [UIColor blackColor];
//        NSLog(@"task list button has stuff");
//    }
    
    [self checkForUnassignedTasksAndUpdate];
    if ([taskList count] == totalAssigned) {
        addTaskButton.enabled = NO;
        [addTaskButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    else {
        addTaskButton.enabled = YES;
        [addTaskButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (UIPopoverController *)getPopover
{
    return popover;
}

//this will check if there is an unallocated space for tasks that are added so we can prevent a user from adding empty tasks into the list.
- (void)checkForUnassignedTasksAndUpdate
{
    BOOL hasNew = NO;
    NSArray *temp = taskList;
    //int i = 0;
    for (NSDictionary *item in temp) {
        // Remove all unallocated entries
        if ([[item objectForKey:@"taskName"] isEqualToString:@"new"]) {
            //[taskList removeObjectAtIndex:i];
            hasNew = YES;
        }
        //i++;
    }
    
    if (hasNew) {
        //[taskList addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"new", @"taskName", @"0", @"hours", nil]];
        addTaskButton.enabled = NO;
        [addTaskButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    else {
        addTaskButton.enabled = YES;
        [addTaskButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void)dismissKeyboard {
    [self.view removeGestureRecognizer:tap];
    //int i = 0;
    //for (NSDictionary *item in taskList) {
        DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedFieldIndex inSection:0]];
        [cell.hoursField resignFirstResponder];
        //i++;
    //}
}

/****************************************************************************************************
 Prepare for segue and delegate control
 ****************************************************************************************************/
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toTaskView"]) {
        JobViewController *dayView = [segue destinationViewController];
        dayView.delegate = self;
    }
}

/****************************************************************************************************
 View Did Load
 ****************************************************************************************************/
- (void)viewDidLoad
{
    // Initializations
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    tsDate = [[TimesheetDate alloc] init];
    taskList = [[NSMutableArray alloc] init];
    taskListIsEmpty = NO;

    
    // Set day and date labels
    dayLabel.text = d.selectedDay;
    dateLabel.text = d.currentDate;
    
    if ([d.historyState isEqualToString:@"Status: Approved"]) {
        doneButton.hidden = YES;
        addTaskButton.hidden = YES;
        lockSwitch.hidden = YES;
        lockSwitchLabel.hidden = YES;
    }
    else {
        doneButton.hidden = NO;
        addTaskButton.hidden = NO;
        lockSwitch.hidden = NO;
        lockSwitchLabel.hidden = NO;
    }
    
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        // Populate tasklist for the day if data exists
        HR_SuiteTimesheetList *list = [HR_SuiteTimesheet findStatsFromDay:d.user withDate:d.selectedDate withDay:d.selectedDay];
        if ([list length] > 0) {
            for (HR_SuiteTimesheet *item in list) {
                entry = [NSDictionary dictionaryWithObjectsAndKeys:
                         item.job, @"taskName", 
                         [item.hours stringValue], @"hours", 
                         nil];
                [taskList addObject:entry];
            }
        } 
    } //end sup
    
    
    /************/
    /*   DEMO   */
    /************/
    else {
        for (NSDictionary *item in d.HR_Suite) {
            BOOL isUser = [[item objectForKey:@"employeeID"] isEqualToString:d.user];
            BOOL isDate = [[item objectForKey:@"date"] isEqualToString:d.selectedDate];
            BOOL isDay = [[item objectForKey:@"day"] isEqualToString:d.selectedDay];
            if (isUser && isDate && isDay) {
                entry = [NSDictionary dictionaryWithObjectsAndKeys:
                         [item objectForKey:@"job"], @"taskName", 
                         [item objectForKey:@"hours"], @"hours", 
                         nil];
                [taskList addObject:entry];
            }
        }
        
    } //end demo
    
    
    [self.dayTable reloadData];
    
    // Calculate total hours
    int i = 0, total = 0;
    for (NSDictionary *item in taskList) {
        DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        total += [cell.hoursField.text intValue];
        i++;
    }
    totalHours.text = [NSString stringWithFormat:@"Total: %i hours", total];
}

- (void)viewDidUnload
{
    [self setHoursField:nil];
    [self setDayTable:nil];
    [self setLockSwitch:nil];
    [self setDayLabel:nil];
    [self setDateLabel:nil];
    [self setTotalHours:nil];
    [self setDoneButton:nil];
    [self setAddTaskButton:nil];
    [self setLockSwitchLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



/****************************************************************************************************
 Table View
 ****************************************************************************************************/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [taskList count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    static NSString *CellIdentifier = @"DayCell";
    DayCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    // If its not new, display the contents in cell.
    if (![[[taskList objectAtIndex:indexPath.row] objectForKey:@"taskName"] isEqualToString:@"new"]) {
        [cell setBackgroundColor:[UIColor whiteColor]];
        cell.taskLabel.text = [[taskList objectAtIndex:indexPath.row] objectForKey:@"taskName"];
        cell.hoursField.text = [[taskList objectAtIndex:indexPath.row] objectForKey:@"hours"];
        cell.hoursField.enabled = YES;
        cell.hoursField.textColor = [UIColor blackColor];
        
        // Tag cell components to make them unique
        cell.deleteButton.tag = indexPath.row;
        cell.hoursField.tag = indexPath.row;
    }
    else {
        cell.taskLabel.text = @"Touch to select task";
        cell.hoursField.text = @"0";
        cell.hoursField.enabled = NO;
        cell.hoursField.textColor = [UIColor lightGrayColor];
        
        // Tag cell components to make them unique
        cell.deleteButton.tag = indexPath.row;
        cell.hoursField.tag = indexPath.row;
    }
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    selectedIndex = indexPath.row;
    
    // Retract keyboard
    for (int i = 0; i < [taskList count]; i++) {
        DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.hoursField.selected = NO;
        [cell.hoursField resignFirstResponder];
    }
    
    // If iPhone version
    if (tableView.tag == 2) {
        [self performSegueWithIdentifier:@"toTaskView" sender:self];
    }
    else {
        
        
        if ([taskList count] < totalAssigned) {      
            // Show pop-over
            JobViewController *jobView = [self.storyboard instantiateViewControllerWithIdentifier:@"jobView"];
            jobView.delegate = self;
            popover = [[UIPopoverController alloc] initWithContentViewController:jobView];
            
            DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
            //cell.selected = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            if (selectedIndex > 4) {
                CGRect position = CGRectMake(165, cell.frame.origin.y + 40 , 1, 1);
                [popover presentPopoverFromRect:position inView:dayTable permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
            }
            else {
                CGRect position = CGRectMake(165, cell.frame.origin.y + 40, 1, 1);
                [popover presentPopoverFromRect:position inView:dayTable permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            }
        
            cell.tag = indexPath.row;
            
            addTaskButton.enabled = YES;
            [addTaskButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
        else {
            DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
            
            cell.selected = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }

}



/****************************************************************************************************
 Add Task - For iPad
 ****************************************************************************************************/
- (IBAction)addTask:(UIButton *)sender {
    //taskListIsEmpty = NO;
    [self.view removeGestureRecognizer:tap];
    [taskList addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"new", @"taskName", @"0", @"hours", nil]];
    [self checkForUnassignedTasksAndUpdate];
    
    NSLog(@"added new item \n %@", taskList);
    NSLog(@"with count %i", [taskList count]);
    
    // Track latest selected
    selectedIndex = [taskList count]-1;
    DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
    cell.taskLabel.text = @"Touch to select task";
    NSLog(@"selected index set = %i", selectedIndex);
    
    // Show pop-over before reloading the table
    JobViewController *jobView = [self.storyboard instantiateViewControllerWithIdentifier:@"jobView"];
    jobView.delegate = self;
    popover = [[UIPopoverController alloc] initWithContentViewController:jobView];
    
    if (selectedIndex > 4) {
        CGRect position = CGRectMake(165, sender.frame.origin.y + 40 , 1, 1);
        [popover presentPopoverFromRect:position inView:dayTable permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }
    else {
        CGRect position = CGRectMake(165, sender.frame.origin.y + 40, 1, 1);
        [popover presentPopoverFromRect:position inView:dayTable permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    
    // Reload the table
    [self.dayTable reloadData];
    
    // Check delete button visibility after new task was added
    if (![lockSwitch isOn]) {        
        int i = 0;
        for (NSDictionary *item in taskList) {
            DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.deleteButton.hidden = NO;
            i++;
        }
    }
    else {
        int i = 0;
        for (NSDictionary *item in taskList) {
            DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.deleteButton.hidden = YES;
            i++;
        }
    }

}



/****************************************************************************************************
 Add a task - For iPhone
 ****************************************************************************************************/
- (IBAction)addTask_iPhone:(id)sender {
    [self.view removeGestureRecognizer:tap];
    [taskList addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"new", @"taskName", @"0", @"hours", nil]];
    NSLog(@"added new item \n %@", taskList);
    NSLog(@"with count %i", [taskList count]);
    
    // Track latest selected
    selectedIndex = [taskList count]-1;
    DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
    cell.taskLabel.text = @"Touch to select task";
    NSLog(@"selected index set = %i", selectedIndex);

    // Reload the table
    [self.dayTable reloadData];
    
    // Perform Segue
    [self performSegueWithIdentifier:@"toTaskView" sender:self];
    
    // Check delete button visibility after new task was added
    if (![lockSwitch isOn]) {        
        int i = 0;
        for (NSDictionary *item in taskList) {
            DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.deleteButton.hidden = NO;
            i++;
        }
    }
    else {
        int i = 0;
        for (NSDictionary *item in taskList) {
            DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.deleteButton.hidden = YES;
            i++;
        }
    }

}



/****************************************************************************************************
 Remove a task
 ****************************************************************************************************/
- (IBAction)removeTask:(UIButton *)sender {
    NSLog(@" x = tag %i", sender.tag);
    selectedIndex = sender.tag;
    
    //DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];

    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        // Remove item in database as well. Changes will be displayed when the view is reloaded
        HR_SuiteTimesheetList *list = [HR_SuiteTimesheet findStatsFromDay:d.user withDate:d.selectedDate withDay:d.selectedDay];
        if ([list length] > 0) {
            for (HR_SuiteTimesheet *sup in list) {
                
                for (NSDictionary *item in taskList) {
                    
                    // Direct match
                    if ([sup.job isEqualToString:[item objectForKey:@"taskName"]] && [sup.hours isEqualToNumber:[NSNumber numberWithInt:[[item objectForKey:@"hours"] intValue]]]) {
                        
                        [sup delete];
                        [sup submitPending];
                        [HR_SuiteHR_SuiteDB synchronize:@"default"];
                    }            
                } //for
            } //for
        }
    } //end sup
    
    
    /************/
    /*   DEMO   */
    /************/
    else {
         
        // Remove object from db if it exists in db
        for (int i = 0; i < [d.HR_Suite count]; i++) {
            NSDictionary *item = [d.HR_Suite objectAtIndex:i];
            BOOL isUser = [[item objectForKey:@"employeeID"] isEqualToString:d.user];
            BOOL isDate = [[item objectForKey:@"date"] isEqualToString:d.selectedDate];
            BOOL isDay = [[item objectForKey:@"day"] isEqualToString:d.selectedDay];
            if (isUser && isDate && isDay) {
                
                for (NSDictionary *task in taskList) {
                    if ([[item objectForKey:@"job"] isEqualToString:[task objectForKey:@"taskName"]]) {
                        [d.HR_Suite removeObjectAtIndex:i];
                    }
                }

            } //if
        } //for
                
    }
    
    // Remove from the table view and reload
    [taskList removeObjectAtIndex:sender.tag];
    NSLog(@"removed item \n %@", taskList);
    NSLog(@"with count %i", [taskList count]);
    [self.dayTable reloadData];
    
    // Update hours
    NSInteger total = 0;
    int i = 0;
    for (NSDictionary *item in taskList) {
        DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        total += [cell.hoursField.text intValue];
        i++;
    }
    
    totalHours.text = [NSString stringWithFormat:@"Total: %i hours", total];
    //addTaskButton.hidden = NO;
    [self checkForUnassignedTasksAndUpdate];
    //[addTaskButton setEnabled:YES];
    //addTaskButton.titleLabel.textColor = [UIColor blackColor];
    taskListIsEmpty = NO;
}

/****************************************************************************************************
 Done Button
 ****************************************************************************************************/
/* What donePressed has to do is check for all new entries for a certain day and add them to the database. This is done by iterating through each element in taskList and checking for any matches in the database. If no matches were found, add them all. If */
- (IBAction)donePressed:(id)sender {
    NSLog(@"%@", taskList);
    
    // Account for having empty tasks by adding pop-up
    int i = 0;
    BOOL containsEmptyFields = NO;
    for (NSDictionary *item in taskList) {
        DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        if ([cell.hoursField.text intValue] == 0 || [cell.taskLabel.text isEqualToString:@"Touch to select task"]) {
            containsEmptyFields = YES;
        }
        i++;
    }
    
    if (containsEmptyFields) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Submission Error!" message:@"Please enter hours for each task and/or specify a task for each entry" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [message setAlertViewStyle:UIAlertViewStyleDefault];
        [message show];
        return;
    }
    
    
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        
        HR_SuiteTimesheetList *list = [HR_SuiteTimesheet findStatsFromDay:d.user withDate:d.selectedDate withDay:d.selectedDay];
        if ([list length] == 0) {
            //add all elements in tasklist
        }
        
        // For each item in the db
        for (NSDictionary *pendingItem in taskList) {
            
            // Find and update all existing entries
            for (HR_SuiteTimesheet *item in list) {
                if([[pendingItem objectForKey:@"taskName"] isEqualToString:item.job]) {
                    NSString *hours = [pendingItem objectForKey:@"hours"];
                    [item setJob:item.job];
                    [item setHours:[NSNumber numberWithInt:[hours intValue]]];
                    [item update];
                    [item submitPending];
                    [HR_SuiteHR_SuiteDB synchronize:@"default"];
                }
            }
        }
        
        // For each item to add
        for (NSDictionary *pendingItem in taskList) {
            BOOL isMatching = NO;
            // Check if pending task matches one in the db
            for (HR_SuiteTimesheet *item in list) {
                if([[pendingItem objectForKey:@"taskName"] isEqualToString:item.job]) {
                    isMatching = YES;
                }
            }
            
            // If pending task isn't in db, add it
            if (!isMatching) {
                HR_SuiteTimesheet *newEntry = [[HR_SuiteTimesheet alloc] init];
                [newEntry setEmployeeID:d.user];
                [newEntry setDay:d.selectedDay];
                [newEntry setDate:d.selectedDate];
                [newEntry setJob:[pendingItem objectForKey:@"taskName"]];
                [newEntry setHours:[NSNumber numberWithInt:[[pendingItem objectForKey:@"hours"] intValue]]];
                
                [newEntry createByDay];
                [newEntry submitPending];
                [HR_SuiteHR_SuiteDB synchronize:@"default"]; 
            }
            
        } //end for
        
    } //end sup
    
    
    /************/
    /*   DEMO   */
    /************/
    else {
        
        // Case 1: DB is empty
        if ([d.HR_Suite count] == 0) {
            for (NSDictionary *task in taskList) {
                entry = [NSDictionary dictionaryWithObjectsAndKeys:
                         d.user, @"employeeID",
                         [tsDate getTimestamp], @"timestamp", 
                         d.selectedDay, @"day",
                         d.selectedDate, @"date",
                         [task objectForKey:@"taskName"], @"job",
                         [task objectForKey:@"hours"], @"hours", 
                         @"manager", @"manager",
                         nil];
                
                NSLog(@"object added");
                [d.HR_Suite addObject:entry];
            }
        }
        
        // Case 2: DB contains data
        // first, update all entries so db data matches tasklist data.
        // next, add all entries in tasklist that is not in db
        else {
            
            NSMutableArray *temp = d.HR_Suite;
            NSLog(@"1 %@", d.HR_Suite);
            // Only get entries on certain day
            for (int i = 0; i < [temp count]; i++) {
                NSDictionary *item = [temp objectAtIndex:i];
                BOOL isUser = [[item objectForKey:@"employeeID"] isEqualToString:d.user];
                BOOL isDate = [[item objectForKey:@"date"] isEqualToString:d.selectedDate];
                BOOL isDay = [[item objectForKey:@"day"] isEqualToString:d.selectedDay];

                // Case 2.1: Info exists for date -> then update the info
                if (isUser && isDate && isDay) { 
                    // Update: Check if item matches with element in taskList. If so, replace it
                    for (NSDictionary *task in taskList) {
                        if ([[item objectForKey:@"job"] isEqualToString:[task objectForKey:@"taskName"]]) {
                            entry = [NSDictionary dictionaryWithObjectsAndKeys:
                                     d.user, @"employeeID",
                                     [tsDate getTimestamp], @"timestamp", 
                                     d.selectedDay, @"day",
                                     d.selectedDate, @"date",
                                     [task objectForKey:@"taskName"], @"job",
                                     [task objectForKey:@"hours"], @"hours", 
                                     @"manager", @"manager",
                                     nil];
                            
                            NSLog(@"object replaced");
                            [d.HR_Suite replaceObjectAtIndex:i withObject:entry];
                            
                        }
                    }
                   
                } //if

            } //for

            // Add new entries
            for (NSDictionary *task in taskList) {
                BOOL isMatching = NO;
                for (int i = 0; i < [d.HR_Suite count]; i++) {
                    
                    NSDictionary *item = [d.HR_Suite objectAtIndex:i];
                    BOOL isUser = [[item objectForKey:@"employeeID"] isEqualToString:d.user];
                    BOOL isDate = [[item objectForKey:@"date"] isEqualToString:d.selectedDate];
                    BOOL isDay = [[item objectForKey:@"day"] isEqualToString:d.selectedDay];
                    
                    // Case 2.1: Info exists for date -> then update the info
                    if (isUser && isDate && isDay && ([[item objectForKey:@"job"] isEqualToString:[task objectForKey:@"taskName"]])) {
                        isMatching = YES;
                    }
                }
                
                // If pending task isn't in db, add it
                if (!isMatching) {
                    entry = [NSDictionary dictionaryWithObjectsAndKeys:
                             d.user, @"employeeID",
                             [tsDate getTimestamp], @"timestamp", 
                             d.selectedDay, @"day",
                             d.selectedDate, @"date",
                             [task objectForKey:@"taskName"], @"job",
                             [task objectForKey:@"hours"], @"hours", 
                             @"manager", @"manager",
                             nil];
                    
                    NSLog(@"object added");
                    [d.HR_Suite addObject:entry];
                }
                
            }
            
            
        }
} //end demo

    [self.delegate reloadView];
    [self.navigationController popViewControllerAnimated:YES];
}



/****************************************************************************************************
 Lock Switch Pressed
 ****************************************************************************************************/
- (IBAction)switchPressed:(id)sender {
    if ([lockSwitch isOn]) {
        int i = 0;
        for (NSDictionary *item in taskList) {
            DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.deleteButton.hidden = YES;
            i++;
        }
    }
    else {
        int i = 0;
        for (NSDictionary *item in taskList) {
            DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.deleteButton.hidden = NO;
            i++;
        }
    }
}



/****************************************************************************************************
 After Hours Entered
 ****************************************************************************************************/
- (IBAction)hoursEntered:(UITextField *)sender {
    [self.view removeGestureRecognizer:tap];
    DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    
    NSLog(@"sender int val = %i", [sender.text intValue]);
    
    // Limit hours entered to 24
    if ([sender.text intValue] > 24) {
        sender.text = @"24";
    }
    else if ([sender.text intValue] <= 0) {
        sender.text = @"0";
    }
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:cell.taskLabel.text, @"taskName", sender.text, @"hours", nil];
    [taskList replaceObjectAtIndex:sender.tag withObject:entry];
    [self.dayTable reloadData];

    // Update hours
    NSInteger total = 0;
    int i = 0;
    for (NSDictionary *item in taskList) {
        DayCell *cell = (DayCell *)[self.dayTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        total += [cell.hoursField.text intValue];
        i++;
    }
    
    totalHours.text = [NSString stringWithFormat:@"Total: %i hours", total];
}



- (IBAction)hoursBeginEditing:(UITextField *)sender {
    // Dismiss keyboard on tap
    tap = [[UITapGestureRecognizer alloc] 
           initWithTarget:self
           action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    selectedFieldIndex = sender.tag;
}



@end
