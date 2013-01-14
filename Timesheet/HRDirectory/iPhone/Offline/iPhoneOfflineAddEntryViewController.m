//
//  iPhoneOfflineAddEntryViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 9/19/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "iPhoneOfflineAddEntryViewController.h"
#import "AppDelegate.h"

@interface iPhoneOfflineAddEntryViewController ()

@end

@implementation iPhoneOfflineAddEntryViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"%@ did load", [self class]);
    [super viewDidLoad];
    
    //navbar title bg
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.scrollView.contentSize = CGSizeMake(320, 441);
    
    [self populateManagersList];
    
    managerUsername = @"";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
}

- (void)viewDidUnload
{
    navbar = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ManagerListSegue"])
    {
        [self.tfFirstName resignFirstResponder];
        [self.tfLastName resignFirstResponder];
        [self.tfId resignFirstResponder];
        [self.tfPhone resignFirstResponder];
        [self.tfEmail resignFirstResponder ];
        [self.tfPosition resignFirstResponder];
        [self.tfDepartment resignFirstResponder];
        [self.tfAddress resignFirstResponder];
        [self.tfUsername resignFirstResponder];
        
        //Move to new class
        ManagerListTableViewController *destination = (ManagerListTableViewController *)[segue destinationViewController];
        
        destination.delegate = self;
        destination.managersList = managersList;
        destination.managersUsernameList = managersUsernameList;
    }
}

/* Actions **************************************************************************************/

- (IBAction)cancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)done:(id)sender
{
    [self addNewEmployee];
}

/* End Actions **********************************************************************************/

/* Data *************************************************************************************/
-(void)addNewEmployee
{
    BOOL finEmployee = YES;
    
    NSString *firstName = self.tfFirstName.text;
    NSString *lastName = self.tfLastName.text;
    NSString *employeeName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    NSString *position = self.tfPosition.text;
    NSString *department = self.tfDepartment.text;
    NSString *phone = self.tfPhone.text;
    NSString *email = self.tfEmail.text;
    NSString *username = self.tfUsername.text;
    NSString *address = self.tfAddress.text;
    NSString *employeeID = self.tfUsername.text;
    NSString *manager = managerUsername;
    NSString *picture = @"";
    
    
    /************************************************
     * Checking text fields for correct information *
     ************************************************/
    //Checking if the information required in the field has things
    if([firstName length] == 0)
    {
        finEmployee = NO;
        NSLog(@"Illegal: First Name is empty");
    }
    if([lastName length] == 0)
    {
        finEmployee = NO;
        NSLog(@"Illegal: Last Name is empty");
    }
    if([position length] == 0)
    {
        finEmployee = NO;
        NSLog(@"Illegal: Position is empty");
    }
    if([department length] == 0)
    {
        finEmployee = NO;
        NSLog(@"Illegal: Department is empty");
    }
    if([address length] == 0)
    {
        finEmployee = NO;
        NSLog(@"Illegal: Address is empty");
    }
    if([phone length] == 0)
    {
        finEmployee = NO;
        NSLog(@"Illegal: Phone is empty");
    }
    if([username length] == 0)
    {
        finEmployee = NO;
        NSLog(@"Illegal: User is empty");
    }
    
    if(finEmployee)
    {
        [self startLoadingAnimations];
        
        
        /*****************************************************
         * Make new login entry if user name does not exists *
         *****************************************************/
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Creating new user" message:@"User will be created with the default password \"temporary\"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];\
        [alert show];
        NSString *password = @"temporary";
        
        AppDelegate *data = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *newEntry = [NSDictionary dictionaryWithObjectsAndKeys:
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
        
        [data.hr_users addObject:newEntry];
        
        [self stopLoadingAnimations];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    else //If not all required filled in, it will display and error message
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Not all textfields are filled in." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}


//Gets the list of all possible managers
-(void)populateManagersList
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

-(BOOL)managerExists:(NSString *)mgrUsername
{
    AppDelegate *data = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *user = [data findByUsername:mgrUsername];
    return user!=nil;
}

-(NSDictionary *)getManager:(NSString *)mgrUsername
{
    AppDelegate *data = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    return [data findByUsername:mgrUsername];
}

/** End SUP stufff ******************************************************************************/

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if([textField isEqual:self.tfUsername])
    {
        //Check if username exists
        AppDelegate *data = (AppDelegate *)[UIApplication sharedApplication].delegate;;
        NSDictionary *user = [data findByUsername:self.tfUsername.text];
        
        if([textField.text length] == 0)
        {
            [self.lblUserWarning setText:@"Username cannot be empty"];
            [self.lblUserWarning setTextColor:[UIColor redColor]];
            self.lblUserWarning.hidden = NO;
        }
        else if(user == nil)
        {
            [self.lblUserWarning setText:@"Username does not exists"];
            [self.lblUserWarning setTextColor:[UIColor greenColor]];
            self.lblUserWarning.hidden = NO;
        }
        else
        {
            [self.lblUserWarning setText:@"Username already exists"];
            [self.lblUserWarning setTextColor:[UIColor redColor]];
            self.lblUserWarning.hidden = NO;
        }
        
    }
    return YES;
}

#pragma mark - ManagerListTableViewControllerDelegate
-(void)selectedManager:(NSString *)_managerName userName:(NSString *)_managerUsername
{
    self.tfManager.text = _managerName;
    managerUsername = _managerUsername;
}

@end
