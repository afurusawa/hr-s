//
//  iPhoneEmployeeDetailsViewController.m
//  HR_Suite
//
//  Created by Alex Chiu on 9/19/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "iPhoneEmployeeDetailsViewController.h"

@interface iPhoneEmployeeDetailsViewController ()

@end

@implementation iPhoneEmployeeDetailsViewController

@synthesize thisEntry = _thisEntry;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSLog(@"%@ did load", [self class]);
    
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self startLoadingAnimations];
    
    //Setting manager status using login information of app delegate
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    isManager = appDelegate.isManager;
    
    //Sets this guy's manager to the mangaer variable
    managerUsername = self.thisEntry.manager;
    
    //If no manager, only allow edit for his own
    if(!isManager)
    {
        NSString *user = [NSString stringWithString:appDelegate.user];
        self.deleteBtn.hidden = YES;
        
        //If current username is not equal to the display person's username
        if(![user isEqualToString:self.thisEntry.employeeID])
        {   //Disallow editing
            self.editSaveBtn.hidden = YES;
        }
    }
    
    self.scrollView.contentSize = (!isManager) ? CGSizeMake(320, 417) : CGSizeMake(320, 461);
    
    //Keyboard notification listeners *Note has to be in viewDidLoad
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
    
    [self disableEditing];
}

-(void)viewDidAppear:(BOOL)animated
{
    if(!editing)
    {
        [self updateViewWithData];
        
        [self populateManagerLists];
        
        [self stopLoadingAnimations];
    }
}

- (void)viewDidUnload
{
    navbar = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"MapSegue"])
    {
        MapViewController *view = (MapViewController *)[segue destinationViewController];
        
        view.name = self.thisEntry.employeeName;
        view.address = self.thisEntry.address;
        [view fetchCoordinates];
    }
    
    if([[segue identifier] isEqualToString:@"ManagerListSegue"])
    {
        //Removing keyboard from screen
        [self.tfPhoneNumber resignFirstResponder];
        [self.tfEmail resignFirstResponder ];
        [self.tfPosition resignFirstResponder];
        [self.tfDepartment resignFirstResponder];
        [self.tvAddress resignFirstResponder];
        
        [self.tfManager resignFirstResponder];
        
        ManagerListTableViewController *destination = (ManagerListTableViewController *)[segue destinationViewController];
        
        destination.delegate = self;
        destination.managersList = managersList;
        destination.managersUsernameList = managersUsernameList;
    }
}

/** Actions sections ***********************************************************************************/
/* Edit button changes to cancel when pressed and vice versa
 * Enables and disables the text marked for editable
 */
- (IBAction)editEntryOrSave:(id)sender
{
    if(!editing)
        [self enableEditing];
    else if(editing)
    {
        [self saveEdit];
        [self disableEditing];
    }
}

- (IBAction)sendEmail:(id)sender
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setToRecipients:[NSArray arrayWithObject:self.thisEntry.email]];
        [mailViewController setSubject:@""];
        [mailViewController setMessageBody:@"" isHTML:NO];
        
        [self presentModalViewController:mailViewController animated:YES];
    }
    else
    {
        NSLog(@"Unable to send mail for some reason");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Error" message:@"Unable to send email at this time" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    
}

//Makes a call to the person
- (IBAction)makeCall:(id)sender
{
    NSString *phoneNumber = [self stripEverythingButNumbers:self.thisEntry.phone];
    NSString *phoneCommand = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    NSLog(@"%@", phoneCommand);
    NSURL *phoneUrl = [[NSURL alloc] initWithString:phoneCommand];
    [[UIApplication sharedApplication] openURL: phoneUrl];
}

- (IBAction)goBackOrCancel:(id)sender
{
    if(!editing) //Go back
        [self.navigationController popViewControllerAnimated:YES];
    else //Cancel
    {
        [self updateViewWithData];
        [self disableEditing];
    }
}

/* First function called when the "delete" button is pressed
 * Will create the alert and show it
 * The alert is handled with the delegate and the delegate called the "deleteEmployee" method
 */
-(IBAction)beginDeleteEmployee:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Deleting Employee" message:@"Are you sure you want to delete this employee?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
}

/* End Actions *****************************************************************************************/

/* Methods that use SUP data ****************************************************************************/
-(void)updateViewWithData
{
    NSLog(@"Updating view with data...");
    
    HR_SuiteUsers *manager = [self getManager:self.thisEntry.manager]; //Error expected: manager is now the identifier instead of id
    
    /************************
     * Employee information *
     ************************/
    
    //Setting portrait
    NSURL *url;
    if([self.thisEntry.picture length] != 0)
        url = [[NSURL alloc] initWithString:self.thisEntry.picture];
    else
        url = [[NSURL alloc] initWithString:@"http://certifiablygreenblog.com/wp-content/uploads/2010/08/No-Photo-Available.jpg"];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    [self.imagePortrait setImage:image];
    
    //Getting Full Name
    NSString *firstName = self.thisEntry.firstName;
    NSString *lastName = self.thisEntry.lastName;
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    self.lblName.text = fullName;
    
    CGSize nameSize = [self.lblName.text sizeWithFont:self.lblName.font];
    //If the namelabel is not already hidden and if the name is longer than the label, it will split it up
    if(!self.lblName.hidden && nameSize.width > self.lblName.frame.size.width)
    {
        self.lblSplitFirstName.text = firstName;
        self.lblSplitLastName.text = lastName;
        self.lblName.hidden = YES;
    }
        
    self.tfPhoneNumber.text = self.thisEntry.phone;
     
    self.tfEmail.text = (self.thisEntry.email.length != 0) ? [NSString stringWithFormat:@"%@", self.thisEntry.email] : @"None";
    
    self.tfPosition.text = self.thisEntry.position;
    
    self.tfDepartment.text = self.thisEntry.department;
    
    self.lblViewAddress.text = self.thisEntry.address;
    self.tvAddress.text = self.thisEntry.address;
    
    /***********************
     * Manager Information *
     ***********************/
    
    if(manager == nil)
    {
        self.tfManager.text = @"None";
    }
    else
    {
        NSString *mgrFirstName = manager.firstName;
        NSString *mgrLastName = manager.lastName;
        NSString *mgrName = [NSString stringWithFormat:@"%@ %@", mgrFirstName, mgrLastName];
        self.tfManager.text = mgrName;
    }
    
    NSLog(@"Finish updating view");
}

- (void)saveEdit
{
    NSLog(@"Updating entry after the edit");
    
    //Cannot Edit Name.
    //Cannot Edit ID number
    
    self.thisEntry.phone = self.tfPhoneNumber.text;
    
    self.thisEntry.email = self.tfEmail.text;
    
    self.thisEntry.department = self.tfDepartment.text;
    
    self.thisEntry.position = self.tfPosition.text;
    
    self.thisEntry.manager = managerUsername;
    
    self.thisEntry.address = self.tvAddress.text;
    
    [self startLoadingAnimations];
    
    //Updating entry to the SUP database
    [self.thisEntry update];
    [self.thisEntry submitPending];
    
    //Synching database (takes time)
    [HR_SuiteHR_SuiteDB synchronize];
    
    //Updating View
    [self updateViewWithData];
    
    [self disableEditing];
    
    NSLog(@"Finished Editing");
    
    [self stopLoadingAnimations];
}

/* Takes all the employees from the data base and checks if they are managers
 * If they are managers, their names will be put into an array (managersList)
 * Their username (unique identifier) will be put into another (managersUsernameList)
 */
-(void)populateManagerLists
{
    NSLog(@"Populating managers list");
    
    managersList = [[NSMutableArray alloc] init];
    managersUsernameList = [[NSMutableArray alloc] init];
    
    HR_SuiteUsersList *employeeList = [HR_SuiteUsers findAll];
    for(HR_SuiteUsers *person in employeeList)
    {
        for(HR_SuiteUsers *managers in employeeList)
        {
            if([person.employeeID isEqualToString:managers.manager])
            {
                [managersList addObject:person.employeeName];
                [managersUsernameList addObject:person.employeeID];
                break;
            }
        }
    }
    
    //Adds a none option of the manager dropdown list
    [managersList addObject:@"None"];
    [managersUsernameList addObject:@""];
    
    //Simple soft error checking to see if the 2 manager lists are the same size
    if([managersList count] != [managersUsernameList count])
    {
        NSLog(@"The managerList and managerUsernameList have different sizes, error has occured");
    }
}

//Handles the actual deletion of the employee from the SUP database
-(void)deleteEmployee
{
    NSLog(@"Deleting entry...");
    
    [self.thisEntry delete];
    [self.thisEntry submitPending];
    
    [HR_SuiteHR_SuiteDB synchronize];
    
    //Exits goes back to the list view when finished.
    [self.navigationController popViewControllerAnimated:YES];
}

-(HR_SuiteUsers *)getManager:(NSString *)mgrUsername
{
    HR_SuiteUsersList *users = [HR_SuiteUsers findByEmployeeID:mgrUsername];
    
    if([users length]!= 0)
    {
        return [users getObject:0];
    }
    
    return nil;
}
/* End SUP Section ********************************************************************************/

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView.title isEqualToString:@"Deleting Employee"])
    {
        if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"])
        {
            [self deleteEmployee];
        }
    }
}

#pragma mark - ManagerListTableViewControllerDelegate
-(void)selectedManager:(NSString *)_managerName userName:(NSString *)_managerUsername
{
    self.tfManager.text = _managerName;
    managerUsername = _managerUsername;
}

#pragma mark - MFMailComposeDelegate
-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

@end
