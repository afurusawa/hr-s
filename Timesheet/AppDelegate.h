//
//  AppDelegate.h
//  Timesheet
//
//  Created by Andrew Furusawa on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallbackHandler.h"
#import "SUPSyncStatusListener.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, SUPSyncStatusListener>

@property (strong, nonatomic) UIWindow *window;

// App mode
@property BOOL isSUPConnection;

//Global variables
@property (strong, nonatomic) NSString *user; //name of the user.
@property NSInteger manager; //set as 1 or 0.
@property (strong, nonatomic) NSString *weekView; //type of week view; either "time entry" or "history".
@property (nonatomic, assign) BOOL isManager; //Whether or not this person is manager

@property (strong, nonatomic) NSString *selectedUser; //user that was selected.
@property (strong, nonatomic) NSString *selectedDay; //stores current day (e.g. Monday, Tuesday, etc.).
@property (strong, nonatomic) NSString *selectedDate; //stores the date.
@property (strong, nonatomic) NSString *currentDate; //stores date for day.
@property (strong, nonatomic) NSString *employeeName;

//History
@property NSInteger HISTORY_SIZE;
@property NSString *historyState; //stores the sign code for history

//SUP properties
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) NSDate *connectStartTime;
@property (nonatomic, retain) CallbackHandler *callbackHandler;

@property (nonatomic, assign) BOOL firstrun;
@property (nonatomic, retain) UIAlertView *passwordAlert;
@property (nonatomic, retain) UIAlertView *noTransportAlert;

@property (nonatomic, retain) NSString *pin;
@property (nonatomic, retain) NSString *SUPPassword;
@property (nonatomic, retain) UITextField *PINField;
@property (nonatomic, retain) UITextField *SUPPasswordField;

@property (nonatomic, retain) NSString *SUPServerName;
@property (nonatomic, retain) NSString *SUPServerPort;
@property (nonatomic, retain) NSString *SUPUserName;
@property (nonatomic, retain) NSString *SUPFarmID;
@property (nonatomic, retain) NSString *SUPConnectionName;
@property (nonatomic, retain) NSString *SUPActivationCode;
@property (nonatomic, assign) BOOL SUPManualRegistration;

-(void)onConnectSuccess:(NSNotification *)obj;

- (BOOL)connectToSUP;


/*** Demo Database ***/
@property (nonatomic, retain) NSDictionary *entry;
@property (nonatomic, retain) NSMutableArray *hr_users;
@property (nonatomic, retain) NSMutableArray *HR_Suite;
@property (nonatomic, retain) NSMutableArray *hr_approvals;
@property (nonatomic, retain) NSMutableArray *hr_leaverequests;
@property (nonatomic, retain) NSMutableArray *hr_tasks;
@property (nonatomic, retain) NSMutableArray *hr_taskmanagement;
- (void)createHRUsers;
- (void)createHRTasks;
- (void)createHRTaskManagement;
- (void)createHRLeaveRequests;
- (void)createHRTimesheetApprovals;
- (void)createHRTimesheet;
-(NSDictionary *)findByUsername:(NSString *)username;

@end
