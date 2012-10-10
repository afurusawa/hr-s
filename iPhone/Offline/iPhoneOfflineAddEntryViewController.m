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

@synthesize scrollView = _scrollView;
@synthesize lblUserWarning = _lblUserWarning;

@synthesize tfFirstName = _tfFirstName;
@synthesize tfLastName = _tfLastName;
@synthesize tfId = _tfId;
@synthesize tfPosition = _tfPosition;
@synthesize tfPhone = _tfPhone;
@synthesize tfEmail = _tfEmail;
@synthesize tfDepartment = _tfDepartment;
@synthesize tfUsername = _tfUsername;
@synthesize tfAddress = _tfAddress;
@synthesize tfManager = _tfManager;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(IBAction)backgroundTouchedHideKeyboard:(id)sender
{
    NSLog(@"Hide Keyboard");
    [[self view] endEditing:YES];
}

- (void)viewDidLoad
{
    NSLog(@"%@ did load", [self class]);
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(320, 501);
    
    self.lblUserWarning.hidden = YES;
    self.tfManager.enabled = NO;
    
    [self populateManagersList];
    [managersTable reloadData];
    managersTable.hidden = YES;
    
    self.tfManager.text = @"None";
    managerUsername = @"";
    
    [self setTFDelegates];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
}

- (void)viewDidUnload
{
    [self setTfFirstName:nil];
    [self setTfLastName:nil];
    [self setTfPosition:nil];
    [self setTfPhone:nil];
    [self setTfEmail:nil];
    [self setTfId:nil];
    [self setScrollView:nil];
    [self setTfUsername:nil];
    [self setLblUserWarning:nil];
    [self setTfAddress:nil];
    managersTable = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)setTFDelegates
{
    self.tfFirstName.delegate = self;
    self.tfLastName.delegate = self;
    self.tfId.delegate = self;
    self.tfId.keyboardType = UIKeyboardTypeNumberPad;
    self.tfDepartment.delegate = self;
    self.tfPosition.delegate = self;
    self.tfPhone.delegate = self;
    self.tfPhone.keyboardType = UIKeyboardTypePhonePad;
    self.tfEmail.delegate = self;
    self.tfEmail.keyboardType = UIKeyboardTypeEmailAddress;
    self.tfUsername.delegate = self;
    //self.tfAddress.delegate = self;
    
    self.tfManager.delegate = self;
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

- (IBAction)dropDownList:(id)sender
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
    
    if(managersTable.hidden)
    {
        managersTable.hidden = NO;
    }
    else
    {
        managersTable.hidden = YES;
    }
}

/* End Actions **********************************************************************************/

/* SUP Data *************************************************************************************/
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
    NSLog(@"Finished populating manager's list");
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
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //[textField selectAll:self];
    return YES;
}

//Setting it to go to the next text field if return is pressed.
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if(textField.tag != 9)
    {
        int newTag = textField.tag +1;
        UITextField *tf = (UITextField *)[self.view viewWithTag:newTag];
        [tf becomeFirstResponder];
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //Handles Delete
    if([string length] == 0)
        return YES;
    
    if([textField isEqual:[self tfPhone]])
    {
        NSString *rawDigits = [self stripEverythingButNumbers:textField.text];
        int length = [rawDigits length];
        
        //Only allows characters and 10 digits
        if(![self characterIsDigit:[string characterAtIndex:0]] || length >=10)
            return NO;
        else
            textField.text = [self formatPhoneNumber:rawDigits];
        
        
    }
    if([textField isEqual:self.tfId])
    {
        if(![self characterIsDigit:[string characterAtIndex:0]])
            return NO;
    }
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if([textField isEqual:self.tfUsername])
    {
        //Check if username exists
        AppDelegate *data = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *user = [data findByUsername:self.tfUsername.text];
        
        if(user == nil)
        {
            self.lblUserWarning.hidden = YES;
        }
        else
            self.lblUserWarning.hidden = NO;
        
    }
    return YES;
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
    UITableViewCell *cell =  [managersTable dequeueReusableCellWithIdentifier:cellIndentifier];
    
    cell.textLabel.text = [managersList objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Change textfield to the value selected
    self.tfManager.text = [managersList objectAtIndex:indexPath.row];
    
    //Change the selected manager login (their unique identifier) to the manager selected
    managerUsername = [managersUsernameList objectAtIndex:indexPath.row];
    
    //Hide the drop down table
    managersTable.hidden = YES;
}

@end
