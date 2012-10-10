//
//  iPhoneOfflineEmployeeDetailsViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 9/19/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "iPhoneOfflineEmployeeDetailsViewController.h"
#import "AppDelegate.h"
#import "MapViewController.h"

@interface iPhoneOfflineEmployeeDetailsViewController ()

@end

@implementation iPhoneOfflineEmployeeDetailsViewController

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
    
    [self startLoadingAnimations];
    
    //Setting manager status using login information of app delegate
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    isManager = appDelegate.isManager;
    
    //Initially hides the drop down list for selecting managers
    managerTable.hidden = YES;
    managerUsername = [self.thisEntry objectForKey:@"manager"];
    
    //If no manager, only allow edit for his own
    if(!isManager)
    {
        NSString *user = [NSString stringWithString:appDelegate.user];
        self.deleteBtn.hidden = YES;
        
        //If current username is not equal to the display person's username
        if(![user isEqualToString:[self.thisEntry objectForKey:@"employeeID"]])
        {   //Disallow editing
            self.editBtn.hidden = YES;
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(320, 532);
    
    //Keyboard notification listeners *Note has to be in viewDidLoad
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
    
    [self disableEditing];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self updateViewWithData];
    
    [self populateManagerLists];
    [managerTable reloadData];
    
    [self stopLoadingAnimations];
}

- (void)viewDidUnload
{
    managerTable = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
        
        view.name = [self.thisEntry objectForKey:@"employeeName"];
        view.address = [self.thisEntry objectForKey:@"address"];
        [view fetchCoordinates];
    }
}

/** Actions sections ***********************************************************************************/
/* Edit button changes to cancel when pressed and vice versa
 * Enables and disables the text marked for editable
 */
- (IBAction)editEntryOrCancel:(id)sender
{
    managerTable.hidden = YES;
    
    if(!editing)
        [self enableEditing];
    else if(editing)
    {
        [self updateViewWithData];
        [self disableEditing];
    }
}

- (IBAction)sendEmail:(id)sender
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setToRecipients:[NSArray arrayWithObject:[self.thisEntry objectForKey:@"email"]]];
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

- (IBAction)makeCall:(id)sender
{
    NSString *phoneNumber = [self stripEverythingButNumbers:[self.thisEntry objectForKey:@"phone"]];
    NSString *phoneCommand = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    NSLog(@"%@", phoneCommand);
    NSURL *phoneUrl = [[NSURL alloc] initWithString:phoneCommand];
    [[UIApplication sharedApplication] openURL: phoneUrl];
}

- (IBAction)callManager:(id)sender
{
    NSString *phoneNumber = [self stripEverythingButNumbers:[self.tfMngPhone text]];
    NSString *phoneCommand = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    NSLog(@"%@", phoneCommand);
    NSURL *phoneUrl = [[NSURL alloc] initWithString:phoneCommand];
    [[UIApplication sharedApplication] openURL: phoneUrl];
}

- (IBAction)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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


- (IBAction)dropDownManagers:(id)sender
{
    [self.tfEmployeeName resignFirstResponder];
    [self.tfPhoneNumber resignFirstResponder];
    [self.tfEmail resignFirstResponder ];
    [self.tfPosition resignFirstResponder];
    [self.tfDepartment resignFirstResponder];
    [self.tvAddress resignFirstResponder];
    
    [self.tfManager resignFirstResponder];
    [self.tfMngPhone resignFirstResponder];
    
    if(managerTable.hidden)
    {
        self.dropDownBtn.titleLabel.text = @"^";
        managerTable.hidden = NO;
    }
    else
    {
        self.dropDownBtn.titleLabel.text = @"v";
        managerTable.hidden = YES;
    }
}

/* End Actions *****************************************************************************************/

/* Methods that use data ****************************************************************************/
-(void)updateViewWithData
{
    NSLog(@"Updating view with data...");
    
    NSDictionary *manager = [self getManager:[self.thisEntry objectForKey:@"manager"]];
    NSLog(@"Manager name: %@", [manager objectForKey:@"employeeName"]);
    
    /************************
     * Employee information *
     ************************/
    
    //Setting portrait
    NSURL *url;
    UIImage *image;
    //They don't want the application to take pictures from online so commented out.
    /*
     if([[self.thisEntry objectForKey:@"picture"] length] != 0)
     {
     url = [[NSURL alloc] initWithString:[self.thisEntry objectForKey:@"picture"]];
     NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
     image = [[UIImage alloc] initWithData:imageData];
     }
     */
    image = [UIImage imageNamed:@"user_group.png"];
    [self.imagePortrait setImage:image];
    
    //Getting Full Name
    NSString *firstName = [self.thisEntry objectForKey:@"firstName"];
    NSString *lastName = [self.thisEntry objectForKey:@"lastName"];
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    self.tfEmployeeName.text = fullName;
    
    //self.tfId.text = [NSString stringWithFormat:@"%d", self.thisEntry.id_];
    
    NSString *phone = [self.thisEntry objectForKey:@"phone"];
    self.tfPhoneNumber.text = (phone != nil) ? [NSString stringWithFormat:@"%@", phone] : @"Not available";
    
    self.tfEmail.text = [NSString stringWithFormat:@"%@", [self.thisEntry objectForKey:@"email"]];
    
    self.tfPosition.text = [self.thisEntry objectForKey:@"position"];
    
    self.tfDepartment.text = [self.thisEntry objectForKey:@"department"];
    
    self.tvAddress.text = [self.thisEntry objectForKey:@"address"];
    
    /***********************
     * Manager Information *
     ***********************/
    if(manager == nil)
    {
        self.tfManager.text = @"None";
        self.tfMngPhone.text = @"";
    }
    else
    {
        NSString *mgrFirstName = [manager objectForKey:@"firstName"];
        NSString *mgrLastName = [manager objectForKey:@"lastName"];
        NSString *mgrName = [NSString stringWithFormat:@"%@ %@", mgrFirstName, mgrLastName];
        self.tfManager.text = mgrName;
        
        self.tfMngPhone.text = [NSString stringWithFormat:@"%@",[manager objectForKey:@"phone"]];
    }
    
    NSLog(@"Finish updating view");
}

- (IBAction)saveEdit:(id)sender
{
    NSLog(@"Updating entry after the edit");
    
    [self startLoadingAnimations];
    
    NSString *firstName = [self.thisEntry objectForKey:@"firstName"];
    NSString *lastName = [self.thisEntry objectForKey:@"lastName"];
    NSString *employeeName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    NSString *employeeID = [self.thisEntry objectForKey:@"employeeID"];
    NSString *password = [self.thisEntry objectForKey:@"password"];
    NSString *picture = [self.thisEntry objectForKey:@"picture"];
    NSString *phone =  self.tfPhoneNumber.text;
    NSString *email = self.tfEmail.text;
    NSString *department = self.tfDepartment.text;
    NSString *position = self.tfPosition.text;
    NSString *manager = managerUsername;
    NSString *address = self.tvAddress.text;
    
    //Deleting entry in offline MSMutable Array
    AppDelegate *data = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [data.hr_users removeObjectIdenticalTo:self.thisEntry];
    
    
    //Creating new dictionary
    self.thisEntry = [NSDictionary dictionaryWithObjectsAndKeys:
                      employeeName, @"employeeName",
                      employeeID, @"employeeID",
                      password, @"password",
                      department, @"department",
                      position, @"position",
                      manager, @"manager",
                      address, @"address",
                      email, @"email",
                      phone, @"phone",
                      firstName, @"firstName",
                      firstName, @"lastName",
                      picture, @"picture",
                      nil];
    [data.hr_users addObject:self.thisEntry];
    
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
    
    AppDelegate *data = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableArray *employeeList = data.hr_users;
    
    for(NSDictionary *person1 in employeeList)
    {
        for(NSDictionary *person2 in employeeList)
        {
            NSString *person1ID = [person1 objectForKey:@"employeeID"];
            NSString *person2ID = [person2 objectForKey:@"manager"];
            
            if([person1ID isEqualToString:person2ID]) //If a username is within the managers column
            {
                [managersList addObject:[person1 objectForKey:@"employeeName"]];
                [managersUsernameList addObject:[person1 objectForKey:@"employeeID"]];
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
    
    AppDelegate *data = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [data.hr_users removeObjectIdenticalTo:self.thisEntry];
    
    //Exits goes back to the list view when finished.
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSDictionary *)getManager:(NSString *)mgrUsername
{
    AppDelegate *data = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    return [data findByUsername:mgrUsername];
}
/* End Data Section ********************************************************************************/

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

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [managersList count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"ManagerCell";
    UITableViewCell *cell = [managerTable dequeueReusableCellWithIdentifier:cellIndentifier];
    
    cell.textLabel.text = [managersList objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Change textfield to the value selected
    self.tfManager.text = [managersList objectAtIndex:indexPath.row];
    
    //Changing the subsequent textfields to fit the currently selected manager man
    NSDictionary *manager = [self getManager:[managersUsernameList objectAtIndex:indexPath.row]];
    self.tfMngPhone.text = [manager objectForKey:@"phone"];
    
    //Change the selected manager login (their unique identifier) to the manager selected
    managerUsername = [managersUsernameList objectAtIndex:indexPath.row];
    
    //Hide the drop down table
    managerTable.hidden = YES;
}

#pragma mark - MFMailComposeDelegate
-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

@end
