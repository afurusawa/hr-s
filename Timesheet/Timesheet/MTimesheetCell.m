//
//  MTimesheetCell.m
//  Timesheet
//
//  Created by Andrew Furusawa on 11/28/12.
//
//

#import "MTimesheetCell.h"
#import "AppDelegate.h"

@implementation MTimesheetCell
{
    AppDelegate *d;
}
@synthesize nameLabel, timestampLabel, weekLabel, hoursLabel;
@synthesize user, date, index, vc;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)goNext:(UIButton *)sender {
    
    //Store transferrable data
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    d.selectedIndex = index.text;
    
    d.selectedUser = user.text;
    d.selectedDate = date.text;
    
    //Perform segue
    
    [self.vc performSegueWithIdentifier:@"toTSSummary" sender:self];
}
@end
