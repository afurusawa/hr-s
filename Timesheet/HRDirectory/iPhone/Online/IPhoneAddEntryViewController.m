//
//  iPhoneAddEntryViewController.m
//  HR_Suite
//
//  Created by Alex Chiu on 9/19/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "iPhoneAddEntryViewController.h"
#import "AppDelegate.h"

@interface iPhoneAddEntryViewController ()

@end

@implementation iPhoneAddEntryViewController


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
    
    [navbar setBackgroundImage:[UIImage imageNamed:@"ts.topappbar-bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.scrollView.contentSize = CGSizeMake(320, 441);
    
    [self populateManagersList];
    
    managerUsername = @"";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
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

/* SUP Data *************************************************************************************/
-(void)addNewEmployee
{
    BOOL finEmployee = YES;
    
    NSString *firstName = self.tfFirstName.text;
    NSString *lastName = self.tfLastName.text;
    NSString *ID = self.tfId.text;
    NSString *position = self.tfPosition.text;
    NSString *department = self.tfDepartment.text;
    NSString *phone = self.tfPhone.text;
    NSString *email = self.tfEmail.text;
    NSString *username = self.tfUsername.text;
    NSString *address = self.tfAddress.text;
    
    //NSString *manager = self.tfManager.text;
    
    
    //Database operations here
    HR_SuiteUsers *newEmployee = [[HR_SuiteUsers alloc] init];
    
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
    if([ID length] == 0)
    {
        finEmployee = NO;
        NSLog(@"Illegal: ID is empty");
    }
    if([self employeeExists:ID.intValue])
    {
        finEmployee = NO;
        NSLog(@"Illegal: ID already exists");
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
        
        /***************************************
         * Makin new employee
         ***************************************/
        newEmployee.employeeName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        newEmployee.firstName = firstName;
        newEmployee.lastName = lastName;
        newEmployee.id_ = [ID intValue];
        newEmployee.position = position;
        newEmployee.department = department;
        newEmployee.address = address;  //ERROR EXPECTED
        newEmployee.phone = phone;
        
        newEmployee.email = email;
        newEmployee.manager = managerUsername; //ERROR EXPECTED
        
        /*****************************************************
         * Make new login entry if user name does not exists *
         *****************************************************/
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Creating new user" message:@"User will be created with the default password \"temporary\"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];\
        [alert show];
        
        newEmployee.employeeID = username;
        newEmployee.employeePassword = @"temporary";
        
        //Calling create function on SUP
        [newEmployee create];
        [newEmployee submitPending];
        
        //Synchronizing (takes time)
        [HR_SuiteHR_SuiteDB synchronize];
        
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
    NSLog(@"Populating managers list...");
    
    managersList = [[NSMutableArray alloc] init];
    managersUsernameList = [[NSMutableArray alloc] init];
    
    HR_SuiteUsersList *list = [HR_SuiteUsers findAll];
    
    for (HR_SuiteUsers *person in list)
    {
        for(HR_SuiteUsers *managers in list)
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

-(BOOL)managerExists:(NSString *)mgrUsername
{
    HR_SuiteUsersList *mgr = [HR_SuiteUsers findByEmployeeID:mgrUsername];
    return ([mgr length] != 0);
}

-(HR_SuiteUsers *)getManager:(NSString *)mgrUsername
{
    HR_SuiteUsersList *users = [HR_SuiteUsers findByEmployeeID:mgrUsername];
    
    if([users length] == 1)
    {
        return [users getObject:0];
    }
    return nil;
}

-(BOOL)employeeExists:(int32_t)ID
{
    HR_SuiteUsers *emp = [HR_SuiteUsers findByPrimaryKey:ID];
    return (emp != nil);
}

/** End SUP stufff ******************************************************************************/
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if([textField isEqual:self.tfUsername])
    {
        //Check if username exists
        HR_SuiteUsersList *users = [HR_SuiteUsers findByEmployeeID:self.tfUsername.text];
        if([textField.text length] == 0)
        {
            [self.lblUserWarning setText:@"Username cannot be empty"];
            [self.lblUserWarning setTextColor:[UIColor redColor]];
            self.lblUserWarning.hidden = NO;
        }
        else if(users.length == 0)
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
- (void)viewDidUnload {
    navbar = nil;
    [super viewDidUnload];
}
@end