//
//  TimesheetDate.h
//  Timesheet
//
//  Created by Andrew Furusawa on 8/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimesheetDate : NSObject


/*** Method Declarations ***/
- (NSString *)getDate:(NSInteger)month day:(NSInteger)day year:(NSInteger)year;
- (NSString *)getTodaysDay;
- (NSString *)getTodaysDate;
- (void)splitDateUsingSlash:(NSString *)date;
- (NSInteger)getMonth;
- (NSInteger)getDay;
- (NSInteger)getYear;
- (NSString *)getTimestamp;
- (BOOL)compareTimestamp:(NSString *)left isMoreRecentThan:(NSString *)right;



@end
