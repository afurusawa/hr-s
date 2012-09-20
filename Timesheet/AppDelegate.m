//
//  AppDelegate.m
//  Timesheet
//
//  Created by Andrew Furusawa on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "SUPApplication.h"
#import "SUPApplicationCallback.h"
#import "SUPRegistrationStatus.h"

#import "HR_SuiteHR_SuiteDB.h"
#import "CallbackHandler.h"
#import "SUPEngine.h"
#import "SUPDataVault.h"
#import "SUPConnectionProfile.h"
#import "HR_SuiteLocalKeyGenerator.h"
#import "SUPSyncStatusInfo.h"

#define kHR_SuiteDataVaultID @"HR_SuiteDataVaultID"
#define kHR_SuiteDataVaultSalt @"HR_SuiteDataVaultSalt"

#define kHR_SuiteErrorBadPin -11111
#define kHR_SuiteErrorNoSettings -11112
#define kHR_SuiteErrorKeyNotAvailable -11113
#define kHR_SuiteErrorFailure -11114

@implementation AppDelegate

@synthesize window = _window;
@synthesize user, manager, isManager, weekView ;
@synthesize selectedDay, selectedDate, selectedUser, currentDate, employeeName;

@synthesize HISTORY_SIZE, historyState;

@synthesize isSUPConnection;

//synthesize SUP properties
@synthesize navController, connectStartTime, callbackHandler, firstrun, pin;
@synthesize passwordAlert, noTransportAlert;
@synthesize PINField, SUPPasswordField;
@synthesize SUPServerName, SUPServerPort, SUPUserName, SUPConnectionName, SUPPassword, SUPFarmID, SUPActivationCode, SUPManualRegistration;

@synthesize entry, hr_tasks, hr_users, hr_approvals, HR_Suite, hr_leaverequests, hr_taskmanagement;

//new method to load sup
- (BOOL)connectToSUP {
    if([self testForRequiredSettings])
    {
        // If messaging DB does not exist yet, we are running the app for the first time since installing it on the device
        self.firstrun = (![MessagingClientLib isMessagingDBExist]);
        
        //[self showPasswordDialog]; //this is for the pin, which we aren't using.
        [self initializeHR_Suite];        
    }
    return YES;
}

-(NSDictionary *)findByUsername:(NSString *)username
{
    for(NSDictionary *thisUser in self.hr_users)
    {
        NSString *tempUsername = [thisUser objectForKey:@"employeeID"];
        if([tempUsername isEqualToString:username])
            return thisUser;
    }
    return nil;
}

- (void)createHRUsers {
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Bilbo Baggins", @"employeeName",
             @"bbaggins", @"employeeID",
             @"test", @"password",
             @"HTML5", @"department",
             @"manager", @"manager",
             @"Web Developer", @"position",
             @"3 Corporate Park \n Irvine, CA 92606", @"address",
             @"bbaggins@lotr.com", @"email",
             @"0938495857", @"phone",
             @"Bilbo", @"firstName",
             @"Baggins", @"lastName",
             @"http://4.bp.blogspot.com/-sZb0qXbNrtE/ToH3uMSIqrI/AAAAAAAACYA/7WrSzaTBKy0/s1600/animals_cats_small1.jpg", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Frodo Baggins", @"employeeName",
             @"fbaggins", @"employeeID",
             @"test", @"password",
             @"HR", @"department",
             @"manager", @"manager",
             @"Ringbearer", @"position",
             @"3 Corporate Park \n Irvine, CA 92606", @"address",
             @"fbaggins@lotr.com", @"email",
             @"3849102333", @"phone",
             @"Frodo", @"firstName",
             @"Baggins", @"lastName",
             @"http://4.bp.blogspot.com/-sZb0qXbNrtE/ToH3uMSIqrI/AAAAAAAACYA/7WrSzaTBKy0/s1600/animals_cats_small1.jpg", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Gandalf White", @"employeeName",
             @"gandalf", @"employeeID",
             @"test", @"password",
             @"Mgmt", @"department",
             @"Senior SAP Architect", @"position",
             @"", @"manager",
             @"3 Corporate Park \n Irvine, CA 92606", @"address",
             @"manager@lotr.com", @"email",
             @"7378485929", @"phone",
             @"Gandalf", @"firstName",
             @"White", @"lastName",
             @"http://4.bp.blogspot.com/-sZb0qXbNrtE/ToH3uMSIqrI/AAAAAAAACYA/7WrSzaTBKy0/s1600/animals_cats_small1.jpg", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Meriadoc Brandybuck", @"employeeName",
             @"mbrandybuck", @"employeeID",
             @"test", @"password",
             @"Android", @"department",
             @"Mobile Developer", @"position",
             @"", @"manager",
             @"3 Corporate Park \n Irvine, CA 92606", @"address",
             @"mbrandybuck@lotr.com", @"email",
             @"9038498485", @"phone",
             @"Meriadoc", @"firstName",
             @"Brandybuck", @"lastName",
             @"http://4.bp.blogspot.com/-sZb0qXbNrtE/ToH3uMSIqrI/AAAAAAAACYA/7WrSzaTBKy0/s1600/animals_cats_small1.jpg", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Peregrin Took", @"employeeName",
             @"ptook", @"employeeID",
             @"test", @"password",
             @"IT", @"department",
             @"Network Administrator", @"position",
             @"", @"manager",
             @"3 Corporate Park \n Irvine, CA 92606", @"address",
             @"ptook@lotr.com", @"email",
             @"6572837485", @"phone",
             @"Peregrin", @"firstName",
             @"Took", @"lastName",
             @"http://4.bp.blogspot.com/-sZb0qXbNrtE/ToH3uMSIqrI/AAAAAAAACYA/7WrSzaTBKy0/s1600/animals_cats_small1.jpg", @"picture",
             nil];
    [self.hr_users addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Samwise Gamgee", @"employeeName",
             @"sgamgee", @"employeeID",
             @"test", @"password",
             @"HR", @"department",
             @"Recruiter", @"position",
             @"gandalf", @"manager",
             @"3 Corporate Park \n Irvine, CA 92606", @"address",
             @"sgamgee@lotr.com", @"email",
             @"8762345647", @"phone",
             @"Samwise", @"firstName",
             @"Gamgee", @"lastName",
             @"http://4.bp.blogspot.com/-sZb0qXbNrtE/ToH3uMSIqrI/AAAAAAAACYA/7WrSzaTBKy0/s1600/animals_cats_small1.jpg", @"picture",
             nil];
    [self.hr_users addObject:entry];
}

- (void)createHRTasks {
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Overhead", @"jobName", 
             @"100", @"jobNumber", 
             nil];
    [self.hr_tasks addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Meeting", @"jobName", 
             @"102", @"jobNumber", 
             nil];
    [self.hr_tasks addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"iOS Development", @"jobName", 
             @"103", @"jobNumber", 
             nil];
    [self.hr_tasks addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Android Development", @"jobName", 
             @"105", @"jobNumber", 
             nil];
    [self.hr_tasks addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"HR Suite", @"jobName", 
             @"106", @"jobNumber", 
             nil];
    [self.hr_tasks addObject:entry];
}
- (void)createHRTaskManagement {
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"Overhead", @"jobName", 
             @"100", @"jobNumber", 
             nil];
    [self.hr_taskmanagement addObject:entry];
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"iOS Development", @"jobName", 
             @"103", @"jobNumber", 
             nil];
    [self.hr_taskmanagement addObject:entry];
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"Meeting", @"jobName", 
             @"102", @"jobNumber", 
             nil];
    [self.hr_taskmanagement addObject:entry];
    
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"bbaggins", @"employeeID",
             @"Overhead", @"jobName", 
             @"100", @"jobNumber", 
             nil];
    [self.hr_taskmanagement addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"bbaggins", @"employeeID",
             @"Meeting", @"jobName", 
             @"102", @"jobNumber", 
             nil];
    [self.hr_taskmanagement addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"fbaggins", @"employeeID",
             @"Overhead", @"jobName", 
             @"100", @"jobNumber", 
             nil];
    [self.hr_taskmanagement addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"fbaggins", @"employeeID",
             @"Meeting", @"jobName", 
             @"102", @"jobNumber", 
             nil];
    [self.hr_taskmanagement addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"mbrandybuck", @"employeeID",
             @"Overhead", @"jobName", 
             @"100", @"jobNumber", 
             nil];
    [self.hr_taskmanagement addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"mbrandybuck", @"employeeID",
             @"Meeting", @"jobName", 
             @"102", @"jobNumber", 
             nil];
    [self.hr_taskmanagement addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"ptook", @"employeeID",
             @"Overhead", @"jobName", 
             @"100", @"jobNumber", 
             nil];
    [self.hr_taskmanagement addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"ptook", @"employeeID",
             @"Meeting", @"jobName", 
             @"102", @"jobNumber", 
             nil];
    [self.hr_taskmanagement addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"sgamgee", @"employeeID",
             @"Overhead", @"jobName", 
             @"100", @"jobNumber", 
             nil];
    [self.hr_taskmanagement addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"sgamgee", @"employeeID",
             @"Meeting", @"jobName", 
             @"102", @"jobNumber", 
             nil];
    [self.hr_taskmanagement addObject:entry];
}
- (void)createHRLeaveRequests {
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"User", @"employeeName",
             @"9/3/2012, 12:11:12", @"timestamp", 
             @"8/5/2012", @"startDate",
             @"8/23/2012", @"endDate",
             @"Paid Time-off", @"leaveType",
             @"Vacation to Europe", @"reason",
             @"Keep up the good work", @"managerNotes",
             @"0", @"signCode", 
             @"manager", @"manager",
             nil];
    [self.hr_leaverequests addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"bbaggins", @"employeeID",
             @"Bilbo Baggins", @"employeeName",
             @"8/30/2012, 12:11:12", @"timestamp", 
             @"8/15/2012", @"startDate",
             @"8/20/2012", @"endDate",
             @"Paid Time-off", @"leaveType",
             @"Vacation in Rivendell", @"reason",
             @"Keep up the good work", @"managerNotes",
             @"100", @"signCode", 
             @"manager", @"manager",
             nil];
    [self.hr_leaverequests addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"fbaggins", @"employeeID",
             @"Frodo Baggins", @"employeeName",
             @"8/29/2012, 12:11:12", @"timestamp",
             @"8/5/2012", @"startDate",
             @"9/2/2012", @"endDate",
             @"Unpaid Time-off", @"leaveType",
             @"Going to Mordor to take care of business", @"reason",
             @"Keep up the good work", @"managerNotes",
             @"0", @"signCode",
             @"manager", @"manager",
             nil];
    [self.hr_leaverequests addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"sgamgee", @"employeeID",
             @"Samwise Gamgee", @"employeeName",
             @"8/31/2012, 12:11:12", @"timestamp",
             @"8/5/2012", @"startDate",
             @"9/2/2012", @"endDate",
             @"Unpaid Time-off", @"leaveType",
             @"Going to Morder with Frodo", @"reason",
             @"Keep up the good work", @"managerNotes",
             @"0", @"signCode",
             @"manager", @"manager",
             nil];
    [self.hr_leaverequests addObject:entry];
    
}
- (void)createHRTimesheetApprovals {
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"bbaggins", @"employeeID",
             @"manager", @"manager",
             @"Bilbo Baggins", @"employeeName",
             @"8/30/2012, 12:11:12", @"timestamp", 
             @"1", @"signCode",
             @"Keep up the good work", @"managerNotes",
             @"8/20/2012", @"date",
             nil];
    [self.hr_approvals addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"fbaggins", @"employeeID",
             @"manager", @"manager",
             @"Frodo Baggins", @"employeeName",
             @"8/31/2012, 2:51:12", @"timestamp", 
             @"1", @"signCode",
             @"", @"managerNotes",
             @"8/27/2012", @"date",
             nil];
    [self.hr_approvals addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"sgamgee", @"employeeID",
             @"manager", @"manager",
             @"Samwise Gamgee", @"employeeName",
             @"8/20/2012, 15:11:12", @"timestamp", 
             @"100", @"signCode",
             @"", @"managerNotes",
             @"8/20/2012", @"date",
             nil];
    [self.hr_approvals addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"manager", @"manager",
             @"User", @"employeeName",
             @"8/23/2012, 15:11:12", @"timestamp", 
             @"100", @"signCode",
             @"Keep up the good work!", @"managerNotes",
             @"8/20/2012", @"date",
             nil];
    [self.hr_approvals addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"manager", @"manager",
             @"User", @"employeeName",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"99", @"signCode",
             @"Add meeting for 1 hour on Friday", @"managerNotes",
             @"8/27/2012", @"date",
             nil];
    [self.hr_approvals addObject:entry];

}
- (void)createHRTimesheet {
    
    // WEEK 8/27/2012 = user
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Monday", @"day",
             @"8/27/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Tuesday", @"day",
             @"8/27/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Wednesday", @"day",
             @"8/27/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Thursday", @"day",
             @"8/27/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Friday", @"day",
             @"8/27/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    // WEEK 8/27/2012 = user
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"fbaggins", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Monday", @"day",
             @"8/27/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"fbaggins", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Tuesday", @"day",
             @"8/27/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"fbaggins", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Wednesday", @"day",
             @"8/27/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"fbaggins", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Thursday", @"day",
             @"8/27/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"fbaggins", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Friday", @"day",
             @"8/27/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    // WEEK 8/20/2012 = user
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"08/27/2012, 15:11:12", @"timestamp", 
             @"Monday", @"day",
             @"8/20/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Tuesday", @"day",
             @"8/20/2012", @"date",
             @"iOS Development", @"job",
             @"5", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Tuesday", @"day",
             @"8/20/2012", @"date",
             @"Meeting", @"job",
             @"3", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Wednesday", @"day",
             @"8/20/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Thursday", @"day",
             @"8/20/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"user", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Friday", @"day",
             @"8/20/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    // WEEK 8/20/2012 = bbaggins
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"bbaggins", @"employeeID",
             @"08/27/2012, 15:11:12", @"timestamp", 
             @"Monday", @"day",
             @"8/20/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"bbaggins", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Tuesday", @"day",
             @"8/20/2012", @"date",
             @"iOS Development", @"job",
             @"5", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"bbaggins", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Tuesday", @"day",
             @"8/20/2012", @"date",
             @"Meeting", @"job",
             @"3", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"bbaggins", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Wednesday", @"day",
             @"8/20/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"bbaggins", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Thursday", @"day",
             @"8/20/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];
    
    entry = [NSDictionary dictionaryWithObjectsAndKeys:
             @"bbaggins", @"employeeID",
             @"8/27/2012, 15:11:12", @"timestamp", 
             @"Friday", @"day",
             @"8/20/2012", @"date",
             @"iOS Development", @"job",
             @"8", @"hours", 
             @"manager", @"manager",
             nil];
    [self.HR_Suite addObject:entry];

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /* this connects sup when the app runs
      
    // copied from did launch (below).
    // Override point for customization after application launch
    if([self testForRequiredSettings])
    {
        
        // If messaging DB does not exist yet, we are running the app for the first time since installing it on the device
        self.firstrun = (![MessagingClientLib isMessagingDBExist]);
        
        //[self showPasswordDialog]; //this is for the pin, which we aren't using.
        [self initializeHR_Suite];
        
    }
    */
//    // Create the main UI for the application. We will update it as we receive messages from the server.
//    [window addSubview:navController.view];
//    [window makeKeyAndVisible];
    
    
    
    
    // Override point for customization after application launch.
    return YES;
    
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

//- (void)applicationDidEnterBackground:(UIApplication *)application
//{
//    /*
//     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
//     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//     */
//}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

//- (void)applicationWillTerminate:(UIApplication *)application
//{
//    /*
//     Called when the application is about to terminate.
//     Save data if appropriate.
//     See also applicationDidEnterBackground:.
//     */
//}



/****************************************************************************************************
SUP Methods 
 ****************************************************************************************************/

//- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

//- (id)init

- (void)showNoTransportAlert:(NSInteger) ret
{
    NSString *message = nil;
    
    if (ret == kHR_SuiteErrorNoSettings) {
        message = @"The connection settings have not been filled in for this application. Go to Settings, enter the connection information, and restart this app.";
    } else if (ret == kHR_SuiteErrorKeyNotAvailable) {
        message = @"Unable to access the key.";
    } else if (ret == kHR_SuiteErrorBadPin) {
        message = @"Incorrect PIN entered.";
    } else {
        message = @"An error occurred attempting to log in.";
    }
    
    self.noTransportAlert = [[UIAlertView alloc] initWithTitle:@"Unable to start message server" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [self.noTransportAlert performSelectorOnMainThread:@selector(show) withObject:self waitUntilDone:YES];
//    [self.noTransportAlert release];
}

//this is application-side and not necessary
//- (void)showPasswordDialog

- (BOOL)testForRequiredSettings
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.SUPServerName = @"68.225.30.194";
    self.SUPServerPort = @"5002";
    self.SUPUserName = @"test";
    self.SUPFarmID = @"0";
    self.SUPPassword = @"test"; //add this line.
    self.pin = @"1234";
    self.SUPManualRegistration = [defaults boolForKey:@"manualregistration_preference"];
    if(self.SUPManualRegistration)
    {
        self.SUPConnectionName = [defaults stringForKey:@"connectionname_preference"];
        self.SUPActivationCode = [defaults stringForKey:@"activationcode_preference"];
    }
    
    if(self.SUPServerName == nil ||
       self.SUPUserName == nil ||
       self.SUPFarmID == nil)
    {
        [self showNoTransportAlert:kHR_SuiteErrorNoSettings];
        return NO;
    }
    
    if(self.SUPManualRegistration && (self.SUPConnectionName == nil || self.SUPActivationCode == nil))
    {
        [self showNoTransportAlert:kHR_SuiteErrorNoSettings];
        return NO;        
    }
    
    return YES;
}



-(void)onConnectSuccess:(NSNotification *)obj
{
    // Connection to the server was made, so log in.
    // See [CallbackHandler onLoginSuccess] and [CallbackHandler onLoginFailure]. One of those
    // callbacks will be called at some point in the future.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ON_CONNECT_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ON_CONNECT_FAILURE object:nil];
    
    NSString *supuser = nil;
    NSString *suppass = nil;
    SUPDataVault *HR_Suitevault = nil;
    @try {
        NSLog(@"Unlock HR_Suite vault to get username/password credentials");
        HR_Suitevault = [SUPDataVault getVault:kHR_SuiteDataVaultID];
        [HR_Suitevault unlock:self.pin withSalt:kHR_SuiteDataVaultSalt];
        supuser = self.SUPUserName;
        suppass = [HR_Suitevault getString:@"password"];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception unlocking messaging data vault: %@: %@",[exception name],[exception reason]);
        [self showNoTransportAlert:kHR_SuiteErrorKeyNotAvailable];
    }
    @finally {
        [HR_Suitevault lock];
    }
    
    // subscribe to database:
    // make sure the databse connection profile has correct username and password
    SUPConnectionProfile *sp = [HR_SuiteHR_SuiteDB getSynchronizationProfile];
    // by default the AsyncReplay is enabled. We will turn it off. This will make the next syncrhonization a blocking call.
    // to make the 
    [sp setAsyncReplay:NO];
    [sp setUser:supuser];
    [sp setPassword:suppass];
    [sp setServerName:self.SUPServerName];
    
    
    @try {
        [HR_SuiteHR_SuiteDB subscribe]; 
    }
    @catch (NSException *exception) {
        MBOLogError(@"%@: %@", [exception name], [exception reason]);
    }
    
    // send the notification , so that the UI enables the Subscribe button
    NSNotification *n = [NSNotification notificationWithName:ON_LOGIN_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:n];
    
    
    
}

-(void)onConnectFailure:(NSNotification *)obj
{
    // Once [SUPMessageClient start] is called, ON_CONNECT_FAILURE is sent from our callback handler
    // until the device is connected or something changes. If we haven't connected in 30 seconds, give up.
    NSDate *now = [NSDate date];
    if ([now timeIntervalSinceDate:self.connectStartTime] > 30) {
        [SUPApplication stopConnection:30];
        [self showNoTransportAlert:kHR_SuiteErrorFailure];
    }
}


//- (void)applicationDidFinishLaunching:(UIApplication *)application {    


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // In this example, because we delete and recreate the local database, we need to unsubscribe
    // and shut down the app when it is no longer active.  All data will be sent on next launch.
    [HR_SuiteHR_SuiteDB unsubscribe];
    [SUPApplication stopConnection:0];
}

- (void)initializeHR_Suite
{
    // Set log level (optional -- this will generate a lot of output in the debug console)
    [MBOLogger setLogLevel:LOG_DEBUG];
    
    SUPDataVault *HR_Suitevault = nil;
    SUPDataVault *messagingvault = nil;
    
    if(self.firstrun)
    {
        NSLog(@"Running the app for the first time.");
        
        
        
        // If the application is being run for the first time, we do the following:
        //      1. Remove the messaging data vault created by earlier versions of the application, if it exists.
        //      2. Remove the HR_Suite data vault created by earlier versions of the application, if it exists.
        //      3. Create the messaging vault using the PIN as the password, leaving it unlocked for use by the messaging layer.
        //      4. Create the HR_Suite data vault using the PIN as the password, and store the SUP username/password credentials 
        //                  and a database encryption key in the vault.
        //      
        @try
        {  
            NSLog(@"Delete preexisting messaging vault");
            [SUPDataVault deleteVault:kMessagingDataVaultID];
        }
        @catch(NSException *e)
        {  
            // Ignore any exception
        }
        @try {
            NSLog(@"Delete preexisting HR_Suite data vault");
            [SUPDataVault deleteVault:kHR_SuiteDataVaultID];
        }
        @catch(NSException *e)
        {  
            // Ignore any exception
        }
        
        @try {
            NSLog(@"Create new HR_Suite data vault and store credentials and a generated encryption key");
            HR_Suitevault = [SUPDataVault createVault:kHR_SuiteDataVaultID withPassword:self.pin withSalt:kHR_SuiteDataVaultSalt]; // creates the vault
            [HR_Suitevault setString:@"password" withValue:self.SUPPassword];
            [HR_Suitevault lock];
        }
        @catch (NSException *exception) {
            NSLog(@"Exception in creating new HR_Suite data vault: %@: %@",[exception name], [exception reason]);
        }
        @try {
            NSLog(@"Create new messaging vault and leave it unlocked");
            messagingvault = [SUPDataVault createVault:kMessagingDataVaultID withPassword:self.pin withSalt:kDVStandardSalt];
        }
        @catch (NSException *exception) {
            NSLog(@"Exception in creating new messaging data vault: %@: %@",[exception name], [exception reason]);                
        }
        
    }
    else
    {
        // If the application has been run before, we get the PIN from the user, and use it to unlock the existing messaging data vault
        // (otherwise the messaging layer cannot start).
        //
        //
        NSLog(@"App has been run before.");
        @try {
            NSLog(@"Unlock messaging vault");
            messagingvault = [SUPDataVault getVault:kMessagingDataVaultID];
            [messagingvault unlock:self.pin withSalt:kDVStandardSalt];
        }
        @catch (NSException *exception) {
            NSLog(@"Exception unlocking messaging data vault: %@: %@",[exception name],[exception reason]);
            [self showNoTransportAlert:kHR_SuiteErrorBadPin];
        }
        
    }
    
    // Start up the messaging client. This will attempt to connect to the server. If a connection was
    // established we can proceed with login. See onConnectFailure: for more information about handling connection failure.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onConnectSuccess:) name:ON_CONNECT_SUCCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onConnectFailure:) name:ON_CONNECT_FAILURE object:nil];
    self.connectStartTime = [NSDate date];
    SUPApplication* app = [SUPApplication getInstance];
    
    @try {
        HR_Suitevault = [SUPDataVault getVault:kHR_SuiteDataVaultID];
        [HR_Suitevault unlock:self.pin withSalt:kHR_SuiteDataVaultSalt];
        
        // make sure to have the applicationIdentifer same as the project name. This is case sensetive.
        app.applicationIdentifier = @"HR_Suite";
        CallbackHandler *ch = [CallbackHandler getInstance];
        [self setCallbackHandler:ch];
        
        [app setApplicationCallback:[self callbackHandler]];
        
        // Register a callback handler. This should be done before any other SUP code is called.
        // self.callbackHandler = [[CallbackHandler new] autorelease];
        [HR_SuiteHR_SuiteDB registerCallbackHandler:self.callbackHandler];
        
        
        SUPConnectionProperties* props = app.connectionProperties;
        [props setServerName:self.SUPServerName];
        [props setPortNumber:[self.SUPServerPort intValue]];
        [props setUrlSuffix:@""];
        [props setFarmId:self.SUPFarmID];
        
        SUPLoginCredentials* login = [SUPLoginCredentials getInstance];
        if(self.SUPManualRegistration)
        {
            login.username = self.SUPConnectionName;
            login.password = nil;
            props.activationCode = self.SUPActivationCode;
        }
        else
        {
            login.username = self.SUPUserName;
            login.password = [HR_Suitevault getString:@"password"];   
            props.activationCode = nil;
        }
        props.loginCredentials = login;
        
        
        
        // Normally you would not delete the local database. For this simple example, though,
        // deleting and creating an empty database will cause all data to be sent from the
        // server, and we can use [CallbackHandler onImportSuccess:] to know when to proceed.        
        [HR_SuiteHR_SuiteDB deleteDatabase];
        [HR_SuiteHR_SuiteDB createDatabase];
        SUPConnectionProfile *cp = [HR_SuiteHR_SuiteDB getConnectionProfile];
        [cp.syncProfile setDomainName:@"default"];
        [cp enableTrace:NO];
        [cp.syncProfile enableTrace:YES];
        
        // Generate an encryption key for the database.
        [HR_SuiteHR_SuiteDB generateEncryptionKey];
        [HR_SuiteHR_SuiteDB closeConnection];
        // Store the encryption key in the data vault for future use.
        [HR_Suitevault setString:@"encryptionkey" withValue:[cp getEncryptionKey]];
        
        // Since we are creating the database from scratch, we set the encryption key for the new database
        
        // If we were using the database from a previous run of the app and not creating it each time, an application should run the code below instead.
        // To successfully access a previously encrypted database, we set the key used by the connection profile.
        NSString *key = [HR_Suitevault getString:@"encryptionkey"];
        NSLog(@"Got the encryption key: %@",key);
        [cp setEncryptionKey:key];
        [HR_SuiteHR_SuiteDB closeConnection];
        
        [HR_SuiteHR_SuiteDB setApplication:app];
        
        [app registerApplication:30];
        
        while([app registrationStatus] != SUPRegistrationStatus_REGISTERED)
        {
            NSLog(@"waiting for registration...");
            
            //wrong code
//            NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];            
//            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
//            [pool release];
            
            //sleep instead
            [NSThread sleepForTimeInterval:1.0];
        }
        while([app connectionStatus] != SUPConnectionStatus_CONNECTED)
        {
            NSLog(@"waiting for connection...");
//            NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];            
//            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
//            [pool release];
            
            //sleep instead
            [NSThread sleepForTimeInterval:1.0];
        }
        
        
        
    }
    @catch (SUPPersistenceException * pe) {
        NSLog(@"%@: %@", [pe name],[pe message]);
        [self showNoTransportAlert:kHR_SuiteErrorFailure];
    }
    @finally 
    {
        [HR_Suitevault lock];
    }
    
    //add from view did appear from subscribecontroller
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLoginSuccess:) name:ON_LOGIN_SUCCESS object:nil];
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [HR_SuiteHR_SuiteDB unsubscribe];
    [SUPApplication stopConnection:0];
}



//- (void)dealloc {


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

//copied from subscribercontroller
- (void)onLoginSuccess:(NSNotification *)notification {
    //    self.button.enabled = YES; //dont need button
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ON_LOGIN_SUCCESS object:nil];
    
    @try {
        
        // [HR_SuiteHR_SuiteDB synchronize] will be a blocking call. So using a non blocking call. 
        // we cna track the sync status thrgouh onGetSyncStatusChange from SUPSyncStatusListener protocol.
        // this way we are not blocking the UI thread
        [HR_SuiteHR_SuiteDB  synchronizeWithListener:self];
    }
    @catch (NSException *exception) {
        MBOLogError(@"%@: %@", [exception name], [exception reason]);
    }
    
}


@end
