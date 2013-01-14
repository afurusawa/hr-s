//
//  UMonthViewController.m
//  Timesheet
//
//  Created by Andrew Furusawa on 11/15/12.
//
//

#import "UMonthViewController.h"
#import "AppDelegate.h"
#import "HR_SuiteTimesheet.h"
#import "HR_SuiteTimesheetApprovals.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "SUPSyncStatusInfo.h"


@interface UMonthViewController ()
{
    AppDelegate *d;
    NSString *monthstring;
    NSString *yearstring;
    
    NSString *week1; //stores value of Monday's date of current week.
    NSString *week2;
    NSString *week3;
    NSString *week4;
    NSString *week5;
}

@end

@implementation UMonthViewController

@synthesize homebutton, backBarButtonItem, navbar, mainView;
@synthesize monthLabel, yearLabel;
@synthesize w1DateLabel, w1HoursLabel, w1StatusImage, w1TasksLabel, w2DateLabel, w2HoursLabel, w2StatusImage, w2TasksLabel, w3DateLabel, w3HoursLabel, w3StatusImage, w3TasksLabel, w4DateLabel, w4HoursLabel, w4StatusImage, w4TasksLabel, w5DateLabel, w5HoursLabel, w5StatusImage, w5TasksLabel;
@synthesize w1HoursTextLabel, w1TasksTextLabel, w2HoursTextLabel, w2TasksTextLabel, w3HoursTextLabel, w3TasksTextLabel, w4HoursTextLabel, w4TasksTextLabel, w5HoursTextLabel, w5TasksTextLabel;

/****************************************************************************************************
 Protocol Methods
 ****************************************************************************************************/
- (void)reloadView
{
    //set month
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM"];
    NSDate *now = [[NSDate alloc] init];
    monthstring = [format stringFromDate:now]; //contains abbrev. month
    monthLabel.text = [monthstring uppercaseString]; //set abbrev. month with upper case
    
    //set year
    [format setDateFormat:@"yyyy"];
    yearstring = [format stringFromDate:now]; //contains abbrev. month
    yearLabel.text = yearstring; //set abbrev. month with upper case
    
    //set dates
    
    //current week: get today, then get monday using getMondayFromDate
    [format setDateFormat:@"EEEE"];
    NSString *daystring = [format stringFromDate:now];
    NSString *currentWeeksMondayString = [self getMondayFromDate:now onDay:daystring]; //returns string in the format of MM/dd/yyyy
    
    w1DateLabel.text = [self getWeekSpanFromDateString:currentWeeksMondayString withOffset:-14];
    w2DateLabel.text = [self getWeekSpanFromDateString:currentWeeksMondayString withOffset:-7];
    w3DateLabel.text = [self getWeekSpanFromDateString:currentWeeksMondayString withOffset:0];
    w4DateLabel.text = [self getWeekSpanFromDateString:currentWeeksMondayString withOffset:7];
    w5DateLabel.text = [self getWeekSpanFromDateString:currentWeeksMondayString withOffset:14];
    
    //set status
    [self setStatusForWeek:1 withImage:w1StatusImage];
    [self setStatusForWeek:2 withImage:w2StatusImage];
    [self setStatusForWeek:3 withImage:w3StatusImage];
    [self setStatusForWeek:4 withImage:w4StatusImage];
    [self setStatusForWeek:5 withImage:w5StatusImage];
    
    //set hours worked
    //set tasks worked
    [self setHoursAndTasksWorked];

}

/****************************************************************************************************
 Prepare for segue and delegate control
 ****************************************************************************************************/
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toWeekView"]) {
        UserWeekViewController *wView = [segue destinationViewController];
        wView.delegate = self;
    }
}


//copied from subscribecontroller
-(void) onGetSyncStatusChange:(SUPSyncStatusInfo*)info
{
    switch(info.state)
    {
        case SYNC_STATE_NONE:
            MBOLogDebug(@"SYNC_STATE_NONE");
            break;
        case SYNC_STATE_STARTING:
            MBOLogDebug(@"SYNC_STATE_STARTING");
            break;
        case SYNC_STATE_CONNECTING:
            MBOLogDebug(@"SYNC_STATE_CONNECTING");
            break;
        case SYNC_STATE_SENDING_HEADER:
            MBOLogDebug(@"SYNC_STATE_SENDING_HEADER");
            break;
        case SYNC_STATE_SENDING_TABLE:
            MBOLogDebug(@"SYNC_STATE_SENDING_TABLE");
            break;
        case SYNC_STATE_SENDING_DATA:
            MBOLogDebug(@"SYNC_STATE_SENDING_DATA");
            break;
        case SYNC_STATE_FINISHING_UPLOAD:
            MBOLogDebug(@"SYNC_STATE_FINISHING_UPLOAD");
            break;
        case SYNC_STATE_RECEIVING_UPLOAD_ACK:
            MBOLogDebug(@"SYNC_STATE_RECEIVING_UPLOAD_ACK");
            break;
        case SYNC_STATE_RECEIVING_TABLE:
            MBOLogDebug(@"SYNC_STATE_RECEIVING_TABLE");
            break;
        case SYNC_STATE_RECEIVING_DATA:
            MBOLogDebug(@"SYNC_STATE_RECEIVING_DATA");
            break;
        case SYNC_STATE_COMMITTING_DOWNLOAD:
            MBOLogDebug(@"SYNC_STATE_COMMITTING_DOWNLOAD");
            break;
        case SYNC_STATE_SENDING_DOWNLOAD_ACK:
            MBOLogDebug(@"SYNC_STATE_SENDING_DOWNLOAD_ACK");
            break;
        case SYNC_STATE_DISCONNECTING:
            MBOLogDebug(@"SYNC_STATE_DISCONNECTING");
            break;
        case SYNC_STATE_DONE:
            MBOLogDebug(@"SYNC_STATE_DONE");
            //these aren't needed because we don't change the view.
            //            self.menuController = [[MenuListController alloc] initWithStyle:UITableViewStylePlain];
            //            [self showListController];
            NSLog(@"Done.");
            break;
        case SYNC_STATE_ERROR:
            MBOLogDebug(@"SYNC_STATE_ERROR");
            break;
        case SYNC_STATE_ROLLING_BACK_DOWNLOAD:
            MBOLogDebug(@"SYNC_STATE_ROLLING_BACK_DOWNLOAD");
            break;
        case SYNC_STATE_UNKNOWN:
            MBOLogDebug(@"SYNC_STATE_UNKNOWN");
            break;
        default:
            MBOLogDebug(@"DEFAULT");
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [monthLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:35]];
    [yearLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:15]];

    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    //navbar title bg
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    //set view for iphone 4 or 5
    NSLog(@"size = %f", self.view.frame.size.height);
    if (self.view.frame.size.height > 460) { //iphone5
        [mainView setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    }
    [mainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    //set fonts
    [self configureFont];
    
    //set tab images
    UITabBarController *tabBarController = self.tabBarController;
    UITabBarItem * tabItem = [tabBarController.tabBar.items objectAtIndex: 0];
    tabItem.image = [UIImage imageNamed:@"ts-mainnavi-timesheets-up.png"];
     
    int offset = 6;
    UIEdgeInsets imageInset = UIEdgeInsetsMake(offset, 0, -offset, 0);
    
    [[tabBarController.tabBar.items objectAtIndex:0] setImageInsets:imageInset];
    [[tabBarController.tabBar.items objectAtIndex:1] setImageInsets:imageInset];
    [[tabBarController.tabBar.items objectAtIndex:2] setImageInsets:imageInset];
    
    [[tabBarController.tabBar.items objectAtIndex:0] setFinishedSelectedImage:[UIImage imageNamed:@"ts-mainnavi-timesheets-down.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"ts-mainnavi-timesheets-up.png"]];
    [[tabBarController.tabBar.items objectAtIndex:1] setFinishedSelectedImage:[UIImage imageNamed:@"ts-mainnavi-leaverequests-down.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"ts-mainnavi-leaverequests-up.png"]];
    [[tabBarController.tabBar.items objectAtIndex:2] setFinishedSelectedImage:[UIImage imageNamed:@"ts-mainnavi-history-down.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"ts-mainnavi-history-up.png"]];
    
    //set month
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM"];
    NSDate *now = [[NSDate alloc] init];
    monthstring = [format stringFromDate:now]; //contains abbrev. month
    monthLabel.text = [monthstring uppercaseString]; //set abbrev. month with upper case
    
    //set year
    [format setDateFormat:@"yyyy"];
    yearstring = [format stringFromDate:now]; //contains abbrev. month
    yearLabel.text = yearstring; //set abbrev. month with upper case
    
    //set dates
    
    //current week: get today, then get monday using getMondayFromDate
    [format setDateFormat:@"EEEE"];
    NSString *daystring = [format stringFromDate:now];
    NSString *currentWeeksMondayString = [self getMondayFromDate:now onDay:daystring]; //returns string in the format of MM/dd/yyyy
    
    w1DateLabel.text = [self getWeekSpanFromDateString:currentWeeksMondayString withOffset:-14];
    w2DateLabel.text = [self getWeekSpanFromDateString:currentWeeksMondayString withOffset:-7];
    w3DateLabel.text = [self getWeekSpanFromDateString:currentWeeksMondayString withOffset:0];
    w4DateLabel.text = [self getWeekSpanFromDateString:currentWeeksMondayString withOffset:7];
    w5DateLabel.text = [self getWeekSpanFromDateString:currentWeeksMondayString withOffset:14];

    //set status
    [self setStatusForWeek:1 withImage:w1StatusImage];
    [self setStatusForWeek:2 withImage:w2StatusImage];
    [self setStatusForWeek:3 withImage:w3StatusImage];
    [self setStatusForWeek:4 withImage:w4StatusImage];
    [self setStatusForWeek:5 withImage:w5StatusImage];
    
    //set hours worked
    //set tasks worked
    [self setHoursAndTasksWorked];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMonthLabel:nil];
    [self setYearLabel:nil];
    
    [self setW1DateLabel:nil];
    [self setW2DateLabel:nil];
    [self setW3DateLabel:nil];
    [self setW4DateLabel:nil];
    [self setW5DateLabel:nil];
    
    [self setW1StatusImage:nil];
    [self setW2StatusImage:nil];
    [self setW3StatusImage:nil];
    [self setW4StatusImage:nil];
    [self setW5StatusImage:nil];
    
    [self setW1HoursLabel:nil];
    [self setW1TasksLabel:nil];
    [self setW2HoursLabel:nil];
    [self setW2TasksLabel:nil];
    [self setW1DateLabel:nil];
    [self setW2DateLabel:nil];
    [self setW3DateLabel:nil];
    [self setW3HoursLabel:nil];
    [self setW3TasksLabel:nil];
    [self setW4DateLabel:nil];
    [self setW4HoursLabel:nil];
    [self setW4TasksLabel:nil];
    [self setW5DateLabel:nil];
    [self setW5HoursLabel:nil];
    [self setW5TasksLabel:nil];
    [self setHomebutton:nil];
    
    [self setBackBarButtonItem:nil];
    [self setNavbar:nil];

    [self setW1HoursTextLabel:nil];
    [self setW1TasksTextLabel:nil];
    [self setW2HoursTextLabel:nil];
    [self setW2TasksTextLabel:nil];
    [self setW3HoursTextLabel:nil];
    [self setW3TasksTextLabel:nil];
    [self setW4HoursTextLabel:nil];
    [self setW4TasksTextLabel:nil];
    [self setW5HoursTextLabel:nil];
    [self setW5TasksTextLabel:nil];
    [self setMainView:nil];
    [super viewDidUnload];
}

- (void)configureFont {
    [w1DateLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:13]];
    [w2DateLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:13]];
    [w3DateLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:15]];
    [w4DateLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:13]];
    [w5DateLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:13]];
    
    [w1HoursLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:28]];
    [w2HoursLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:28]];
    [w3HoursLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:30]];
    [w4HoursLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:28]];
    [w5HoursLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:28]];
    
    [w1HoursTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [w2HoursTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [w3HoursTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [w4HoursTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [w5HoursTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    
    [w1TasksLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:28]];
    [w2TasksLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:28]];
    [w3TasksLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:30]];
    [w4TasksLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:28]];
    [w5TasksLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:28]];
    
    [w1TasksTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [w2TasksTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [w3TasksTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [w4TasksTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [w5TasksTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    
}

- (NSString *)getWeekSpanFromDateString:(NSString *)currentWeeksMondayString withOffset:(NSInteger)offset
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"M/d/yyyy"];
    
    //convert currentWeeksMondayString to NSDate
    NSDate *date = [format dateFromString:currentWeeksMondayString];
    
    //apply offset
    date = [date dateByAddingTimeInterval:60*60*24*offset];
    
    //store monday date value for each week
    if (offset==0) {
        week3 = [format stringFromDate:date];
    }
    else if (offset==-7) {
        week2 = [format stringFromDate:date];
    }
    else if (offset==-14) {
        week1 = [format stringFromDate:date];
    }
    else if (offset==7) {
        week4 = [format stringFromDate:date];
    }
    else if (offset==14) {
        week5 = [format stringFromDate:date];
    }
    
    //get monday of the calculated week as a number
    [format setDateFormat:@"dd"];
    NSString *startDay = [format stringFromDate:date];

    //get sunday of the calculated week as a number by adding 6 days
    date = [date dateByAddingTimeInterval:60*60*24*6];
    NSString *endDay = [format stringFromDate:date];

    return [NSString stringWithFormat:@"%@-%@", startDay, endDay];
}

//returns a string with the date for that week's monday in the following format: MM/dd/yyyy
- (NSString *)getMondayFromDate:(NSDate *)date onDay:(NSString *)day
{
    NSString *result = @"error";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    if ([day isEqualToString:@"Monday"]) {
        result = [dateFormatter stringFromDate:date];
    }
    else if ([day isEqualToString:@"Tuesday"]) {
        int daysToAdd = -1;
        NSDate *newDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
        result = [dateFormatter stringFromDate:newDate];
    }
    else if ([day isEqualToString:@"Wednesday"]) {
        int daysToAdd = -2;
        NSDate *newDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
        result = [dateFormatter stringFromDate:newDate];
    }
    else if ([day isEqualToString:@"Thursday"]) {
        int daysToAdd = -3;
        NSDate *newDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
        result = [dateFormatter stringFromDate:newDate];
    }
    else if ([day isEqualToString:@"Friday"]) {
        int daysToAdd = -4;
        NSDate *newDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
        result = [dateFormatter stringFromDate:newDate];
    }
    else if ([day isEqualToString:@"Saturday"]) {
        int daysToAdd = -5;
        NSDate *newDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
        result = [dateFormatter stringFromDate:newDate];
    }
    else if ([day isEqualToString:@"Sunday"]) {
        int daysToAdd = -6;
        NSDate *newDate = [date dateByAddingTimeInterval:60*60*24*daysToAdd];
        result = [dateFormatter stringFromDate:newDate];
    }

    return result;
}

- (void)setStatusForWeek:(NSInteger)i withImage:(UIImageView *)image
{
    int status = 0;
    NSString *date;
    if (i==1) date = week1;
    else if (i==2) date = week2;
    else if (i==3) date = week3;
    else if (i==4) date = week4;
    else if (i==5) date = week5;

    [image setImage:[UIImage imageNamed:nil]];
    
    //sup
    if (d.isSUPConnection) {
        
        //[LoadingScreen startLoadingScreenWithView:self.view];
        //[HR_SuiteHR_SuiteDB  synchronizeWithListener:self];
        //[LoadingScreen stopLoadingScreenWithView:self.view];
        
        HR_SuiteTimesheetApprovalsList *list = [HR_SuiteTimesheetApprovals findAll];
        for (HR_SuiteTimesheetApprovals *item in list) {
            
            if ([item.date isEqualToString:date] && [item.employeeID isEqualToString:d.user])
                status = [item.signCode intValue];
        }
    } //end sup
    
    //demo
    else {
        for (int i = 0; i < [d.hr_approvals count]; i++) {
            NSDictionary *item = [d.hr_approvals objectAtIndex:i];
            if ([[item objectForKey:@"date"] isEqualToString:date]) {
                status = [[item objectForKey:@"signCode"] intValue];
            }
        }
    }
    
    //waiting
    if (status==1) {
        [image setImage:[UIImage imageNamed:@"ts-history-status-waiting.png"]];
    }
    //deny
    else if(status==99) {
        [image setImage:[UIImage imageNamed:@"ts-history-status-denied.png"]];
    }
    //approve
    else if (status==100) {
        [image setImage:[UIImage imageNamed:@"ts-history-status-approved.png"]];
    }
    else {
        [image setImage:[UIImage imageNamed:nil]];
    }
}

//sets the total hours worked per week for each week
- (void)setHoursAndTasksWorked
{
    // sup
    if (d.isSUPConnection) {
        HR_SuiteTimesheetList *list = [HR_SuiteTimesheet findByEmployeeIDandDate:d.user withDate:week1];
        
        // Week 1
        if ([list length] > 0) {
            NSMutableArray *jobsArray = [[NSMutableArray alloc] initWithCapacity:1];
            NSInteger hours = 0;
            for (HR_SuiteTimesheet *item in list) {
                if (![jobsArray containsObject:item.job]) {
                    [jobsArray addObject:item.job];
                }
                
                hours += [item.hours intValue];
            }
            w1TasksLabel.text = [NSString stringWithFormat:@"%i", [jobsArray count]];
            w1HoursLabel.text = [NSString stringWithFormat:@"%i", hours];
        }
        else {
            w1TasksLabel.text = @"0";
            w1HoursLabel.text = @"0";
        }
        
        // Week 2
        list = [HR_SuiteTimesheet findByEmployeeIDandDate:d.user withDate:week2];
        if ([list length] > 0) {
            NSMutableArray *jobsArray = [[NSMutableArray alloc] initWithCapacity:1];
            NSInteger hours = 0;
            for (HR_SuiteTimesheet *item in list) {
                if (![jobsArray containsObject:item.job]) {
                    [jobsArray addObject:item.job];
                }
                
                hours += [item.hours intValue];
            }
            w2TasksLabel.text = [NSString stringWithFormat:@"%i", [jobsArray count]];
            w2HoursLabel.text = [NSString stringWithFormat:@"%i", hours];
        }
        else {
            w2TasksLabel.text = @"0";
            w2HoursLabel.text = @"0";
        }
        
        // Week 3
        NSLog(@"User: %@, Week: %@", d.user, week3);
        list = [HR_SuiteTimesheet findByEmployeeIDandDate:d.user withDate:week3];
        if ([list length] > 0) {
            NSMutableArray *jobsArray = [[NSMutableArray alloc] initWithCapacity:1];
            NSInteger hours = 0;
            for (HR_SuiteTimesheet *item in list) {
                if (![jobsArray containsObject:item.job]) {
                    [jobsArray addObject:item.job];
                }
                
                hours += [item.hours intValue];
            }
            w3TasksLabel.text = [NSString stringWithFormat:@"%i", [jobsArray count]];
            w3HoursLabel.text = [NSString stringWithFormat:@"%i", hours];
        }
        else {
            w3TasksLabel.text = @"0";
            w3HoursLabel.text = @"0";
        }
        
        // Week 4
        list = [HR_SuiteTimesheet findByEmployeeIDandDate:d.user withDate:week4];
        if ([list length] > 0) {
            NSMutableArray *jobsArray = [[NSMutableArray alloc] initWithCapacity:1];
            NSInteger hours = 0;
            for (HR_SuiteTimesheet *item in list) {
                if (![jobsArray containsObject:item.job]) {
                    [jobsArray addObject:item.job];
                }
                
                hours += [item.hours intValue];
            }
            w4TasksLabel.text = [NSString stringWithFormat:@"%i", [jobsArray count]];
            w4HoursLabel.text = [NSString stringWithFormat:@"%i", hours];
        }
        else {
            w4TasksLabel.text = @"0";
            w4HoursLabel.text = @"0";
        }
        
        // Week 5
        list = [HR_SuiteTimesheet findByEmployeeIDandDate:d.user withDate:week5];
        if ([list length] > 0) {
            NSMutableArray *jobsArray = [[NSMutableArray alloc] initWithCapacity:1];
            NSInteger hours = 0;
            for (HR_SuiteTimesheet *item in list) {
                if (![jobsArray containsObject:item.job]) {
                    [jobsArray addObject:item.job];
                }
                
                hours += [item.hours intValue];
            }
            w5TasksLabel.text = [NSString stringWithFormat:@"%i", [jobsArray count]];
            w5HoursLabel.text = [NSString stringWithFormat:@"%i", hours];
        }
        else {
            w5TasksLabel.text = @"0";
            w5HoursLabel.text = @"0";
        }
    }
    
    //demo
    else {
        
        // week 1
        NSMutableArray *jobsArray = [[NSMutableArray alloc] initWithCapacity:1];
        NSInteger hours = 0;
        for (int i = 0; i < [d.HR_Suite count]; i++) {
            NSDictionary *item = [d.HR_Suite objectAtIndex:i];
            if ([[item objectForKey:@"employeeID"] isEqualToString:d.user] && [[item objectForKey:@"date"] isEqualToString:week1]) {
  
                if (![jobsArray containsObject:[item objectForKey:@"job"]]) {
                    [jobsArray addObject:[item objectForKey:@"job"]];
                }
                
                hours += [[item objectForKey:@"hours"] intValue];
            }
        }
        if ([jobsArray count] > 0) {
            w1TasksLabel.text = [NSString stringWithFormat:@"%i", [jobsArray count]];
            w1HoursLabel.text = [NSString stringWithFormat:@"%i", hours];
        }
        else {
            w1TasksLabel.text = @"0";
            w1HoursLabel.text = @"0";
        }
        [jobsArray removeAllObjects];
        
        
        // week 2
        jobsArray = [[NSMutableArray alloc] initWithCapacity:1];
        hours = 0;
        for (int i = 0; i < [d.HR_Suite count]; i++) {
            NSDictionary *item = [d.HR_Suite objectAtIndex:i];
            if ([[item objectForKey:@"employeeID"] isEqualToString:d.user] && [[item objectForKey:@"date"] isEqualToString:week2]) {
                
                if (![jobsArray containsObject:[item objectForKey:@"job"]]) {
                    [jobsArray addObject:[item objectForKey:@"job"]];
                }
                
                hours += [[item objectForKey:@"hours"] intValue];
            }
        }
        if ([jobsArray count] > 0) {
            w2TasksLabel.text = [NSString stringWithFormat:@"%i", [jobsArray count]];
            w2HoursLabel.text = [NSString stringWithFormat:@"%i", hours];
        }
        else {
            w2TasksLabel.text = @"0";
            w2HoursLabel.text = @"0";
        }
        [jobsArray removeAllObjects];
        
        
        // week 3
        jobsArray = [[NSMutableArray alloc] initWithCapacity:1];
        hours = 0;
        for (int i = 0; i < [d.HR_Suite count]; i++) {
            NSDictionary *item = [d.HR_Suite objectAtIndex:i];
            if ([[item objectForKey:@"employeeID"] isEqualToString:d.user] && [[item objectForKey:@"date"] isEqualToString:week3]) {
                
                if (![jobsArray containsObject:[item objectForKey:@"job"]]) {
                    [jobsArray addObject:[item objectForKey:@"job"]];
                }
                
                hours += [[item objectForKey:@"hours"] intValue];
            }
        }
        if ([jobsArray count] > 0) {
            w3TasksLabel.text = [NSString stringWithFormat:@"%i", [jobsArray count]];
            w3HoursLabel.text = [NSString stringWithFormat:@"%i", hours];
        }
        else {
            w3TasksLabel.text = @"0";
            w3HoursLabel.text = @"0";
        }
        [jobsArray removeAllObjects];
        
        
        // week 4
        jobsArray = [[NSMutableArray alloc] initWithCapacity:1];
        hours = 0;
        for (int i = 0; i < [d.HR_Suite count]; i++) {
            NSDictionary *item = [d.HR_Suite objectAtIndex:i];
            if ([[item objectForKey:@"employeeID"] isEqualToString:d.user] && [[item objectForKey:@"date"] isEqualToString:week4]) {
                
                if (![jobsArray containsObject:[item objectForKey:@"job"]]) {
                    [jobsArray addObject:[item objectForKey:@"job"]];
                }
                
                hours += [[item objectForKey:@"hours"] intValue];
            }
        }
        if ([jobsArray count] > 0) {
            w4TasksLabel.text = [NSString stringWithFormat:@"%i", [jobsArray count]];
            w4HoursLabel.text = [NSString stringWithFormat:@"%i", hours];
        }
        else {
            w4TasksLabel.text = @"0";
            w4HoursLabel.text = @"0";
        }
        [jobsArray removeAllObjects];
        
        
        // week 5
        jobsArray = [[NSMutableArray alloc] initWithCapacity:1];
        hours = 0;
        for (int i = 0; i < [d.HR_Suite count]; i++) {
            NSDictionary *item = [d.HR_Suite objectAtIndex:i];
            if ([[item objectForKey:@"employeeID"] isEqualToString:d.user] && [[item objectForKey:@"date"] isEqualToString:week5]) {
                
                if (![jobsArray containsObject:[item objectForKey:@"job"]]) {
                    [jobsArray addObject:[item objectForKey:@"job"]];
                }
                
                hours += [[item objectForKey:@"hours"] intValue];
            }
        }
        if ([jobsArray count] > 0) {
            w5TasksLabel.text = [NSString stringWithFormat:@"%i", [jobsArray count]];
            w5HoursLabel.text = [NSString stringWithFormat:@"%i", hours];
        }
        else {
            w5TasksLabel.text = @"0";
            w5HoursLabel.text = @"0";
        }
        [jobsArray removeAllObjects];
    }
    
}


- (IBAction)goHome:(id)sender {
    [self.parentViewController.navigationController popViewControllerAnimated:YES];
}

- (IBAction)w3Selected:(id)sender {
    d.selectedDate = week3;
    [self performSegueWithIdentifier:@"toWeekView" sender:self];
}
- (IBAction)w2Selected:(id)sender {
    d.selectedDate = week2;
    [self performSegueWithIdentifier:@"toWeekView" sender:self];
}
- (IBAction)w1Selected:(id)sender {
    d.selectedDate = week1;
    [self performSegueWithIdentifier:@"toWeekView" sender:self];
}

@end
