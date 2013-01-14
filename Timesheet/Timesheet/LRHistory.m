//
//  LRHistory.m
//  Timesheet
//
//  Created by Andrew Furusawa on 11/27/12.
//
//

#import "LRHistory.h"
#import "LRHistoryCell.h"
#import "AppDelegate.h"

#import "HR_SuiteLeaveRequests.h"

@implementation LRHistory
{
    AppDelegate *d;
    NSMutableArray *lrmList;
    NSArray *lrList;
}
@synthesize lrhtable, sup;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Initializations
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //bg
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];

    //bg for table
    [lrhtable setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ts-bg-bg.png"]]];
    
    lrmList = [[NSMutableArray alloc] init];
    
    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        // Populate leave request array
        HR_SuiteLeaveRequestsList *list = [HR_SuiteLeaveRequests findAll];
        for (HR_SuiteLeaveRequests *item in list) {
            if ([item.employeeID isEqualToString:d.user]) {
                [lrmList addObject:item];
            }
        }
        lrList = [[lrmList reverseObjectEnumerator] allObjects]; //reverse order
    } //end sup
    
    /**********************/
    /*   Demo             */
    /**********************/
    else {
        for (NSDictionary *item in d.hr_leaverequests) {
            if ([[item objectForKey:@"employeeID"] isEqualToString:@"user"]) {
                [lrmList addObject:item];
            }
        }
        lrList = [[lrmList reverseObjectEnumerator] allObjects]; //reverse order
    } //end demo
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    if ([lrList count] != 0) {
        NSLog(@"count => %i", [lrList count]);
        return [lrList count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LRHistoryCell";
    LRHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    //set fonts
    [cell.periodLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:15]];
    [cell.submittedLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:15]];
    [cell.reasonLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:14]];
    [cell.typeLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    
    [cell.periodTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];
    [cell.submittedTextLabel setFont:[UIFont fontWithName:@"ProximaNova-Bold" size:10]];

    /**********************/
    /*   SUP Connection   */
    /**********************/
    if (d.isSUPConnection) {
        if ([lrList count] > 0) {
            HR_SuiteLeaveRequests *item = [lrList objectAtIndex:indexPath.row];
            
            // Set period
            NSString *sd = item.startDate;
            NSString *ed = item.endDate;
            NSArray *temp = [sd componentsSeparatedByString:@"/"];
            NSArray *temp2 = [ed componentsSeparatedByString:@"/"];
            sd = [NSString stringWithFormat:@"%@/%@", [temp objectAtIndex:0], [temp objectAtIndex:1]];
            ed = [NSString stringWithFormat:@"%@/%@", [temp2 objectAtIndex:0], [temp2 objectAtIndex:1]];
            cell.periodLabel.text = [NSString stringWithFormat:@"%@-%@", sd,ed];
            
            // Set leave type
            cell.typeLabel.text = [NSString stringWithFormat:@"%@", item.leaveType];
            
            // Set reason
            cell.reasonLabel.text = [NSString stringWithFormat:@"%@", item.reason];
            
            //Set the status
            NSInteger signCode = [item.signCode intValue];
            if(signCode == 99) {
                [cell.statusImage setImage:[UIImage imageNamed:@"ts-history-status-denied.png"]];
            }
            else if(signCode == 0) {
                [cell.statusImage setImage:[UIImage imageNamed:@"ts-history-status-waiting.png"]];
            }
            else if(signCode == 100) {
                [cell.statusImage setImage:[UIImage imageNamed:@"ts-history-status-approved.png"]];
            }
            
            //set timestamp
            //get timestamp
            NSString *timestamp = item.timestamp;
            NSArray *a = [timestamp componentsSeparatedByString:@"/"];
            cell.submittedLabel.text = [NSString stringWithFormat:@"%@/%@", [a objectAtIndex:0], [a objectAtIndex:1]];
            
        }
    } //end sup
    
    
    /**********************/
    /*   Demo             */
    /**********************/
    else {
        //NSLog(@"size of lrlist: %i", [lrList count]);
//        cell.date.text = [NSString stringWithFormat:@"%@ to %@", [[lrList objectAtIndex:indexPath.row] objectForKey:@"startDate"], [[lrList objectAtIndex:indexPath.row] objectForKey:@"endDate"]];
//        cell.reason.text = [[lrList objectAtIndex:indexPath.row] objectForKey:@"reason"];
//        cell.leaveType.text = [[lrList objectAtIndex:indexPath.row] objectForKey:@"leaveType"];
//        
//        //Set the sign code
//        NSInteger signCode = [[[lrList objectAtIndex:indexPath.row] objectForKey:@"signCode"] intValue];
//        if(signCode == 99) {
//            cell.status.text = [NSString stringWithFormat:@"Status: Rejected"];
//            cell.managersNote.text = [[lrList objectAtIndex:indexPath.row] objectForKey:@"managerNotes"];
//        }
//        else if(signCode == 0) {
//            cell.status.text = @"Status: Waiting for approval";
//            cell.status.textColor = [UIColor orangeColor];
//        }
//        else if(signCode == 100) {
//            cell.status.text = @"Status: Approved";
//            cell.status.textColor = [UIColor colorWithRed:8.0f/255.0f green:190.0f/255.0f blue:45.0f/255.0f alpha:1.0f];
//        }
        
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (void)viewDidUnload {
    [self setLrhtable:nil];
    [super viewDidUnload];
}
@end
