//
//  EmployeeDetailsViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 8/8/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "EmployeeDetailsViewController.h"
#import "ResumeViewController.h"

@interface EmployeeDetailsViewController ()

@end

@implementation EmployeeDetailsViewController

@synthesize editBtn = _editBtn;
@synthesize saveBtn = _saveBtn;
@synthesize scrollView = _scrollView;
@synthesize deleteBtn = _deleteBtn;
@synthesize dropDownBtn = _dropDownBtn;
@synthesize thisEntry = _thisEntry;
@synthesize imagePortrait = _imagePortrait;

//TextFields for Employee Information
@synthesize tfEmployeeName = _tfEmployeeName;
@synthesize tfId = _tfId;
@synthesize tfPhoneNumber = _tfPhoneNumber;
@synthesize tfEmail = _tfEmail;
@synthesize tfPosition = _tfPosition;
@synthesize tfDepartment = _tfDepartment;
@synthesize tvAddress = _tvAddress;

//TextField for Manager Information
@synthesize tfManager = _tfManager;
@synthesize tfMngPhone = _tfMngPhone;
@synthesize tfMngFax = _tfMngFax;


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
    managerUsername = self.thisEntry.manager;
    
    //If no manager, only allow edit for his own
    if(!isManager)
    {
        NSString *user = [NSString stringWithString:appDelegate.user];
        self.deleteBtn.hidden = YES;
        
        //If current username is not equal to the display person's username
        if(![user isEqualToString:self.thisEntry.employeeID])
        {   //Disallow editing
            self.editBtn.hidden = YES;
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(768, 960);
    
    //Keyboard notification listeners *Note has to be in viewDidLoad
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self disableEditing];
    
    [self updateViewWithData];
    
    [self populateManagerLists];
    [managerTable reloadData];
    
    [self stopLoadingAnimations];
}

- (void)viewDidUnload
{
    [self setTfEmployeeName:nil];
    [self setTfPosition:nil];
    [self setTfPhoneNumber:nil];
    [self setTfEmail:nil];
    [self setTfDepartment:nil];
    [self setTfManager:nil];
    [self setImagePortrait:nil];
    [self setTfId:nil];
    [self setTfMngPhone:nil];
    [self setTfMngFax:nil];
    [self setEditBtn:nil];
    [self setSaveBtn:nil];
    [self setScrollView:nil];
    [self setDeleteBtn:nil];
    [self setTvAddress:nil];
    managerTable = nil;
    [self setDropDownBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//Disables the textfields to disallow editing
-(void)disableEditing
{
    self.tfEmployeeName.enabled = NO;
    self.tfId.enabled = NO;
    self.tfPhoneNumber.enabled = NO;
    self.tfEmail.enabled = NO;
    self.tfPosition.enabled = NO;
    self.tfDepartment.enabled = NO;
    self.tvAddress.editable = NO;
    
    self.tfManager.enabled = NO;
    self.tfMngPhone.enabled = NO;
    self.tfMngFax.enabled = NO;
    
    [self disableBorders];
    
    self.saveBtn.hidden = YES;
    self.dropDownBtn.hidden = YES;
    
    //When disabling edit, change edit button back to the edit icon
    [self.editBtn setImage:[UIImage imageNamed:@"rm_edit_button_up.png"] forState:UIControlStateNormal];
    editing = NO;
}

//Enables the textfields to enable editing
-(void)enableEditing
{
    self.tfPhoneNumber.enabled = YES;
    self.tfEmail.enabled = YES;
    
    self.tfPosition.enabled = YES;
    self.tfDepartment.enabled = YES;
    self.tvAddress.editable = YES;
    
    [self enableBorders];
    
    self.dropDownBtn.hidden = NO;
    self.saveBtn.hidden = NO;
    
    //When enabling edit, change edit button to the cancel icon
    [self.editBtn setImage:[UIImage imageNamed:@"rm_cancel_button_up.png"] forState:UIControlStateNormal];
    editing = YES;
}

-(void)enableBorders
{
    UIColor *color = [UIColor colorWithRed:(229.0/255.0) green:(229.0/255.0) blue:(229.0/255.0) alpha:1.0];
    self.tfPhoneNumber.backgroundColor = color;
    self.tfEmail.backgroundColor = color;
    self.tfPosition.backgroundColor = color;
    self.tfDepartment.backgroundColor = color;
    self.tvAddress.backgroundColor = color;
    self.tfManager.backgroundColor = color;
}

//Called when disabling editing
-(void)disableBorders
{
    self.tfPhoneNumber.backgroundColor = [UIColor clearColor];
    self.tfEmail.backgroundColor = [UIColor clearColor];
    self.tfPosition.backgroundColor = [UIColor clearColor];
    self.tfDepartment.backgroundColor = [UIColor clearColor];
    self.tvAddress.backgroundColor = [UIColor clearColor];
    self.tfManager.backgroundColor = [UIColor clearColor];
}

//Sets the delegates of all the textfields
-(void)setTFDelegates
{
    self.tfEmployeeName.delegate = self;
    self.tfId.delegate = self;
    self.tfPhoneNumber.delegate = self;
    self.tfEmail.delegate = self;
    self.tfPosition.delegate = self;
    self.tfDepartment.delegate = self;
    
    self.tfManager.delegate = self;
    self.tfMngPhone.delegate = self;
    self.tfMngFax.delegate = self;
}

/** Actions sections ***********************************************************************************/
/* Edit button changes to cancel when pressed and vice versa
 * Enables and disables the text marked for editable
 */
- (IBAction)editEntryOrCancel:(id)sender
{
    managerTable.hidden = YES;
    
    if(!editing)
    {
        [self enableEditing];
    }
    else if(editing)
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


- (IBAction)dropDownManagers:(id)sender
{
    [self.tfEmployeeName resignFirstResponder];
    [self.tfId resignFirstResponder];
    [self.tfPhoneNumber resignFirstResponder];
    [self.tfEmail resignFirstResponder ];
    [self.tfPosition resignFirstResponder];
    [self.tfDepartment resignFirstResponder];
    [self.tvAddress resignFirstResponder];
    
    [self.tfManager resignFirstResponder];
    [self.tfMngPhone resignFirstResponder];
    [self.tfMngFax resignFirstResponder];
    
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

/* Methods that use SUP data ****************************************************************************/
-(void)updateViewWithData
{
    NSLog(@"Updating view with data...");
    
    HR_SuiteUsers *manager = [self getManager:self.thisEntry.manager]; //Error expected: manager is now the identifier instead of id
    
    /************************
     * Employee information *
     ************************/
    
    //Setting portrait
    if([self.thisEntry.picture length] != 0)
    {
        NSURL *url = [[NSURL alloc] initWithString:self.thisEntry.picture];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        [self.imagePortrait setImage:image];
    }
    
    //Getting Full Name
    NSString *firstName = self.thisEntry.firstName;
    NSString *lastName = self.thisEntry.lastName;
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    self.tfEmployeeName.text = fullName;
    
    self.tfId.text = [NSString stringWithFormat:@"%d", self.thisEntry.id_];
    
    self.tfPhoneNumber.text = (self.thisEntry.phone != nil) ? [NSString stringWithFormat:@"%@", self.thisEntry.phone] : @"Not available";
    
    self.tfEmail.text = [NSString stringWithFormat:@"%@", self.thisEntry.email];
    
    self.tfPosition.text = self.thisEntry.position;
    
    self.tfDepartment.text = self.thisEntry.department;
    
    self.tvAddress.text = self.thisEntry.address;
    
    /***********************
     * Manager Information *
     ***********************/
    if(manager == nil)
    {
        self.tfManager.text = @"None";
        self.tfMngPhone.text = @" ";
    }
    else
    {
        NSString *mgrFirstName = manager.firstName;
        NSString *mgrLastName = manager.lastName;
        NSString *mgrName = [NSString stringWithFormat:@"%@ %@", mgrFirstName, mgrLastName];
        self.tfManager.text = mgrName;
        
        self.tfMngPhone.text = [NSString stringWithFormat:@"%@",manager.phone];
    }
    
    NSLog(@"Finish updating view");
}

- (IBAction)saveEdit:(id)sender
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

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //[textField selectAll:self];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"Return pressed");
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

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
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",[self getManager:[managersList objectAtIndex:indexPath.row]].id_];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Change textfield to the value selected
    self.tfManager.text = [managersList objectAtIndex:indexPath.row];
    
    //Changing the subsequent textfields to fit the currently selected manager man
    //HR_SuiteUsers *manager = [self getManager:[managersUsernameList objectAtIndex:indexPath.row]];
    //self.tfMngPhone.text = manager.phone;
    
    //Change the selected manager login (their unique identifier) to the manager selected
    managerUsername = [managersUsernameList objectAtIndex:indexPath.row];
    
    //Hide the drop down table
    managerTable.hidden = YES;
}

@end
