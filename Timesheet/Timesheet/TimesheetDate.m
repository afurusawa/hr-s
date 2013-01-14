//
//  TimesheetDate.m
//  Timesheet
//
//  Created by Andrew Furusawa on 8/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TimesheetDate.h"

@implementation TimesheetDate
{
    NSInteger resultDay;
    NSInteger resultMonth;
    NSInteger resultYear;
}

//Calculates the date in the format of mm/dd/yyyy. In the case where the day entered exceeds the number of days in the month, the date calculates into the next month. For example, if month=7, day=33, year=2012, the results would yield "8/2/2012. Similarly, if the day is a negative value, the date would calculate into the previous month (e.g. 7/-1/2012 -> 6/30/2012).
- (NSString *)getDate:(NSInteger)month day:(NSInteger)day year:(NSInteger)year
{
    resultMonth = month;
    resultDay = day;
    resultYear = year;
    
    //January case
    if(month==1)
    {
        //Before January 1
        if(day<1)
        {
            resultDay = 31 + day; //add negative
            resultMonth = 12;
            resultYear = year - 1;
        }
        //After January 31
        else if(day>31)
        {
            resultDay = day - 31;
            resultMonth++;
        }        
    }
    
    //December case
    else if(month==12)
    {
        //Before December 1
        if(day<1)
        {
            resultDay = 30 + day;
            resultMonth--;
        }
        //After December 31
        else if(day>31)
        {
            resultDay = day%31;
            resultMonth = 1;
            resultYear++;
        }        
    }
    
    //August is special case.
    else if(month==8)
    {
        //Negative
        if(day<1)
        {
            resultDay = 31 + day; //30 days in April, June, September, November
            resultMonth--;
        }
        //Overflow
        else if(day>31)
        {
            resultDay = day%31;
            resultMonth++;
        }  
    }
    //31 days in March, May, July, August, October.
    else if(month==3 || month==5 || month==7 || month==10)
    {
        //Negative
        if(day<1)
        {
            resultDay = 30 + day; //30 days in April, June, September, November
            resultMonth--;
        }
        //Overflow
        else if(day>31)
        {
            resultDay = day%31;
            resultMonth++;
        }  
    }
    
    //28 days in February unless its a leap year.
    else if(month==2)
    {
        //Leap Year
        if((0 == year%4) && ((0 != year%100) || (0 == year%400)))
        {
            //Negative
            if(day<1)
            {
                resultDay = 31 + day; //31 days in January
                resultMonth--;
            }
            
            //Overflow
            else if(day>29)
            {
                resultDay = day%29;
                resultMonth++;
            }
        }
        
        //Regular Year
        else
        {
            //Negative
            if(day<1)
            {
                resultDay = 31 + day; //31 days in January
                resultMonth--;
            }
            
            //Overflow
            else if(day>28)
            {
                resultDay = day%28;
                resultMonth++;
            }
        }
    }
    //Otherwise there are 30 days.
    else
    {
        //Negative
        if(day<1)
        {
            resultDay = 31 + day; //31 days in March, May, July, August, October
            resultMonth--;
        }
        //Overflow
        else if(day>30)
        {
            resultDay = day%30;
            resultMonth++;
        }  
    }
    
    return [NSString stringWithFormat:@"%i/%i/%i", resultMonth, resultDay, resultYear];    
}

//Returns the current day (e.g. Monday, Tuesday, Wednesday, etc.).
- (NSString *)getTodaysDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];  
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *today = [dateFormatter stringFromDate:[NSDate date]];
    return today;
}

- (NSString *)getTodaysDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    return dateString;
}

- (NSString *)getTimestamp
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM/dd/yyyy, HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    return dateString;
}

- (BOOL)compareTimestamp:(NSDictionary *)left isMoreRecentThan:(NSDictionary *)right {
    
    // Currently left and right are dictionaries containing the timestamp, so extract from it
    NSString *lts = [left objectForKey:@"timestamp"];
    NSArray *split = [lts componentsSeparatedByString:@", "];
    TimesheetDate *start = [[TimesheetDate alloc] init];
    [start splitDateUsingSlash:[split objectAtIndex:0]];
    
    NSArray *leftTime = [[split objectAtIndex:1] componentsSeparatedByString:@":"];
    
    
    
    NSString *rts = [left objectForKey:@"timestamp"];
    split = [rts componentsSeparatedByString:@", "];
    TimesheetDate *end = [[TimesheetDate alloc] init];
    [end splitDateUsingSlash:[split objectAtIndex:0]];

    NSArray *rightTime = [[split objectAtIndex:1] componentsSeparatedByString:@":"];
    
    
    
    
    /* cases where end date is before the start date
     1) end year < start year
     2) end month < start month, end year <= start year
     3) end day < start day, end month <= start month, end year <= start year
     */
    
    // If the left/start date is greater, then it is more recent
    if (
        ([start getYear] > [end getYear]) ||
        ([start getMonth] > [end getMonth] && [start getYear] >= [end getYear]) ||
        ([start getDay] > [end getDay] && [start getMonth] >= [end getMonth] && [start getYear] >= [end getYear])
        ) {
        
        return YES;
    }
    
    // If left/start and right/end dates are the same, compare time
    else if ([start getDay] == [end getDay] && [start getMonth] == [end getMonth] && [start getYear] == [end getYear]) {
        
        NSInteger lh = [[leftTime objectAtIndex:0] intValue];
        NSInteger lm = [[leftTime objectAtIndex:1] intValue];
        NSInteger ls = [[leftTime objectAtIndex:2] intValue];
        NSInteger rh = [[rightTime objectAtIndex:0] intValue];
        NSInteger rm = [[rightTime objectAtIndex:1] intValue];
        NSInteger rs = [[rightTime objectAtIndex:2] intValue];
        
        // If left time is greater than right time, then left is more recent
        if (
            (lh > rh) ||
            (lm > rm && lh >= rh) ||
            (ls > rs && lm >= rm && lh >= rh)
            ) {
            
            return YES;
        }
        
        else {
            return NO;
        }

    }
    
    else {
        return NO;
    }
                              
}

- (void)splitDateUsingSlash:(NSString *)date
{
    NSArray *temp = [date componentsSeparatedByString:@"/"];
    resultMonth = [[temp objectAtIndex:0] intValue];
    resultDay = [[temp objectAtIndex:1] intValue];
    resultYear = [[temp objectAtIndex:2] intValue];
}


- (NSInteger)getMonth {
    return resultMonth;
}
- (NSInteger)getDay {
    return resultDay;
}
- (NSInteger)getYear {
    return resultYear;
}



@end
