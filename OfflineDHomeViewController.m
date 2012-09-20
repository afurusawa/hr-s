//
//  OfflineDHomeViewController.m
//  Timesheet
//
//  Created by Alex Chiu on 9/19/12.
//
//

#import "OfflineDHomeViewController.h"
#import "AppDelegate.h"

@interface OfflineDHomeViewController ()

@end

@implementation OfflineDHomeViewController

@synthesize browseButton;
@synthesize btnAddEmployee;

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDel.isManager = [self isAManager];
    isManager = appDel.isManager;
    //self.btnAddEmployee.enabled = NO;
    
    if(!isManager)
    {
        //[self.btnAddEmployee titleLabel].textColor = [UIColor blackColor];
        NSLog(@"Here");
        self.btnAddEmployee.enabled = NO;
        [self.btnAddEmployee setAlpha:.50];
    }
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setBrowseButton:nil];
    [self setBtnAddEmployee:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)isAManager
{
    AppDelegate *data = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *employee = data.user;
    
    for(NSDictionary *user in data.hr_users)
    {
        if([[user objectForKey:@"manager"] isEqualToString:employee])
        {
            return YES;
        }
    }
    return NO;
}

@end
