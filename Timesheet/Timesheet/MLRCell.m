//
//  MLRCell.m
//  Timesheet
//
//  Created by Andrew Furusawa on 12/3/12.
//
//

#import "MLRCell.h"
#import "AppDelegate.h"

@implementation MLRCell
{
    AppDelegate *d;
}
@synthesize nameLabel, submittedLabel, periodLabel, typeLabel, index, user, date, vc, indexLabel, userLabel, dateLabel;
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

- (IBAction)goNext:(id)sender {
    d = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    d.selectedIndex = indexLabel.text;
    
    //Store transferrable data    
    d.selectedUser = userLabel.text;
    d.selectedDate = dateLabel.text;
    
    //Perform segue
    
    [self.vc performSegueWithIdentifier:@"toLRSummary" sender:self];
}
@end
