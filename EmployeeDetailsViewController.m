//
//  EmployeeDetailsViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 8/8/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "EmployeeDetailsViewController.h"
#import "ResumeViewController.h"
#import "HR_SuiteUsers.h"
#import "HR_SuiteHR_SuiteDB.h"
#import "AppDelegate.h"

@implementation EmployeeDetailsViewController
{
    AppDelegate *appDelegate;
    NSMutableArray *managersList;
    NSMutableArray *managersUsernameList;
}

@synthesize delegate;
@synthesize editBtn = _editBtn;
@synthesize saveBtn = _saveBtn;
@synthesize scrollView = _scrollView;
@synthesize deleteBtn = _deleteBtn;
@synthesize dropDownBtn = _dropDownBtn;
//@synthesize thisEntry = _thisEntry;
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
@synthesize managerTable;
@synthesize tfMngPhone = _tfMngPhone;
@synthesize tfMngFax = _tfMngFax;



- (void)viewDidLoad
{
    [super viewDidLoad];	
    [self startLoadingAnimations];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managerTable.hidden = YES;

    //If no manager, only allow edit for his own
    if(!appDelegate.manager)
    {
        
        // demo
        if (appDelegate.isSUPConnection) {

            self.deleteBtn.hidden = YES; // Hide delete button because only managers can delete
            
            // If current username is not equal to the display person's username
            HR_SuiteUsersList *thisEntry = [HR_SuiteUsers findByEmployeeID:appDelegate.user];
            if ([thisEntry length] > 0) {
                self.editBtn.hidden = NO;
            }
            else {
                self.editBtn.hidden = YES;
            }
            
            HR_SuiteUsersList *list = [HR_SuiteUsers findAll];
            for (HR_SuiteUsers *item in list) {
                if ([item.employeeID isEqualToString:appDelegate.selectedUser]) {
                    //Getting Full Name
                    self.tfEmployeeName.text = item.employeeName;
                    
                    // Contact Information
                    self.tfPhoneNumber.text = item.phone; //phone
                    self.tfEmail.text = item.email; //email
                    
                    self.tfPosition.text = item.position; //position
                    self.tfDepartment.text = item.department; //department
                    self.tvAddress.text = item.address; //address
                }
            }

        }
        
        // user
        else {
            self.deleteBtn.hidden = YES;
            self.editBtn.hidden = NO;
            
            for (NSDictionary *item in appDelegate.hr_users) {
                if ([[item objectForKey:@"employeeID"] isEqualToString:appDelegate.selectedUser]) {
                    //Getting Full Name
                    self.tfEmployeeName.text = [item objectForKey:@"employeeName"];
                    
                    // Contact Information
                    self.tfPhoneNumber.text = [item objectForKey:@"phone"]; //phone
                    self.tfEmail.text = [item objectForKey:@"email"]; //email
                    
                    self.tfPosition.text = [item objectForKey:@"position"]; //position
                    self.tfDepartment.text = [item objectForKey:@"department"]; //department
                    self.tvAddress.text = [item objectForKey:@"address"]; //address
                }
            }
        }
        
        
        
        //Setting portrait
        //    if([self.thisEntry.picture length] != 0)
        //    {
        //        NSURL *url = [[NSURL alloc] initWithString:self.thisEntry.picture];
        //        NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
        //        UIImage *image = [[UIImage alloc] initWithData:imageData];
        //        [self.imagePortrait setImage:image];
        //    }
        
        
        //    /***********************
        //     * Manager Information *
        //     ***********************/
        //    
        //    NSString *mgrFirstName = manager.firstname;
        //    NSString *mgrLastName = manager.lastname;
        //    NSString *mgrName = [NSString stringWithFormat:@"%@ %@", mgrFirstName, mgrLastName];
        //    self.tfManager.text = mgrName;
        //    
        //    self.tfMngPhone.text = [NSString stringWithFormat:@"%@",manager.workphone];
        //    
        //    self.tfMngFax.text = [NSString stringWithFormat:@"%@", (![manager.workphone isEqualToNumber:0]) ? manager.workphone : @"Not available"]; //self.thisEntry.managers.fax;
        //    
        //    NSLog(@"Finish updating view");
    }
    
    self.scrollView.contentSize = CGSizeMake(768, 960);
    
    //Keyboard notification listeners *Note has to be in viewDidLoad
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
}


-(void)viewDidAppear:(BOOL)animated
{
    [self disableEditing];    
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
    [self setTfTopCompName:nil];
    [self setScrollView:nil];
    [self setDeleteBtn:nil];
    [self setTvAddress:nil];
    [self setDropDownBtn:nil];
    [self setManagerTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

-(void)keyboardWillShow:(NSNotification *)n
{
    NSLog(@"Keyboard will show");
    
    NSDictionary *userInfo = [n userInfo];
    
    //Get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //Resize the view
    CGRect viewFrame = self.view.frame; //I used View instead of ScrollView
    viewFrame.size.height -= keyboardSize.height;
    
    //Animations
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:.3];
    
    [self.scrollView setFrame:viewFrame];
    
    [UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification *)n
{
    NSLog(@"Keyboard will hide");
    
    NSDictionary *userInfo = [n userInfo];
    
    //Getting size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    //Getting new frame
    CGRect newFrameSize = self.scrollView.frame;
    newFrameSize.size.height += keyboardSize.height;
    
    //Animations
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:.3];
    
    //Setting the new frame size
    [self.scrollView setFrame:newFrameSize];
    
    [UIView commitAnimations];
}


/** Actions sections ***********************************************************************************/
/* Edit button changes to cancel when pressed and vice versa
 * Enables and disables the text marked for editable
 */


/* First function called when the "delete" button is pressed
 * Will create the alert and show it
 * The alert is handled with the delegate and the delegate called the "deleteEmployee" method
 */
-(IBAction)beginDeleteEmployee
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Deleting Employee" message:@"Are you sure you want to delete this employee?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
}


- (IBAction)dropDownManagers:(id)sender
{
    self.managerTable.hidden = !self.managerTable.hidden;
    [self.managerTable reloadData];
}

/* End Actions *****************************************************************************************/



- (IBAction)saveEdit:(id)sender
{
    //Updating entry to the SUP database
    //[self.thisEntry update];
    //[self.thisEntry submitPending];
    
    //Synching database (takes time)
    //[HR_SuiteHR_SuiteDB synchronize];  
    
    //Updating View
    //[self updateViewWithData];
    
    [self disableEditing];
    [self stopLoadingAnimations];
}



////Handles the actual deletion of the employee from the SUP database
//-(void)deleteEmployee
//{
//    [self.thisEntry delete];
//    [self.thisEntry submitPending];
//    
//    [HRDirectoryHRDirectoryDB synchronize];
//    
//    //Exits goes back to the list view when finished.
//    [self.navigationController popViewControllerAnimated:YES];
//}

//-(HR_SuiteUsers *)getManager:(NSString *)mgrUsername
//{
//    //return [HR_SuiteUsers findByUsername:mgrUsername]; //ERROR EXPECTED: NEED MBO
//}
/* End SUP Section ********************************************************************************/



#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView.title isEqualToString:@"Deleting Employee"])
    {
        if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"])
        {
           // [self deleteEmployee];
        }
    }
}







//
//
//
//
////for manager dropdown
//
///* Takes all the employees from the data base and checks if they are managers
// * If they are managers, their names will be put into an array (managersList)
// * Their username (unique identifier) will be put into another (managersUsernameList)
// */
-(void)populateManagerLists
{
    managersList = [[NSMutableArray alloc] init];
    managersUsernameList = [[NSMutableArray alloc] init];
    
    // sup
    if (appDelegate.isSUPConnection) {
        HR_SuiteUsersList *employeeList = [HR_SuiteUsers findAll];
        for (HR_SuiteUsers *person in employeeList)
        {
            // add manager employeeID
            if (![person.manager isEqualToString:@""]) {
                
                //check if name is already in the list
                BOOL found = NO;
                for (NSString *mgr in managersList) {
                    if ([mgr isEqualToString:person.manager]) {
                        found = YES;
                    }
                }
                // if not found, add it
                if (!found) {
                    [managersList addObject:person.manager];
                    NSLog(@"adding manager: %@", person.manager);
                }
            }
        }
        
        // Add managers name
        for (NSString *item2 in managersList) {

            // Add name of manager
            HR_SuiteUsersList *list = [HR_SuiteUsers findByEmployeeID:item2.];
            
            if ([list length] > 0) {
                for (HR_SuiteUsers *item in list) {
                    [managersUsernameList addObject:item.employeeName];
                }
            }
        }
    }
    
    // demo
    else {
        for (NSDictionary *item in appDelegate.hr_users) {
            if (item objectForKey:@"manager"
        }
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [managersList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"ManagerCell";
    UITableViewCell *cell = [managerTable dequeueReusableCellWithIdentifier:cellIndentifier];
    
    cell.textLabel.text = [managersUsernameList objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{}
//    //Change textfield to the value selected
//    self.tfManager.text = [managersList objectAtIndex:indexPath.row];
//    
//    //Changing the subsequent textfields to fit the currently selected manager man
//    HR_SuiteUsers *manager = [self getManager:self.tfManager.text];
//    self.tfMngPhone.text = [manager.phone stringValue];
//    self.tfMngFax.text = [manager.fax stringValue];
//    
//    //Change the selected manager login (their unique identifier) to the manager selected
//    managerUsername = [managersUsernameList objectAtIndex:indexPath.row];
//    
//    //Hide the drop down table
//    managerTable.hidden = YES;
//}
//
//





// ui stuff

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //[textField selectAll:self];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}


// when done is pressed, modify database with new values
- (IBAction)editEntry:(id)sender {
    NSLog(@"True or False: %@", (editing) ? @"Yes" : @"No");
    if(!editing)
        [self enableEditing];
    else if(editing)
        [self disableEditing];
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
    
    //self.tfManager.enabled = NO;
    //self.tfMngPhone.enabled = NO;
    //self.tfMngFax.enabled = NO;
    
    [self disableBorders];
    
    self.saveBtn.hidden = YES;
    self.dropDownBtn.hidden = YES;
    
    
    [self.editBtn setTitle:@"Edit" forState:UIControlStateNormal];
    editing = NO;
}

//Enables the textfields to enable editing
-(void)enableEditing
{
    // Phone
    self.tfPhoneNumber.enabled = YES;
    self.tfPhoneNumber.borderStyle = UITextBorderStyleRoundedRect;
    
    // Email
    self.tfEmail.enabled = YES;
    self.tfEmail.borderStyle = UITextBorderStyleRoundedRect;
    
    // Position
    self.tfPosition.enabled = YES;
    self.tfPosition.borderStyle = UITextBorderStyleRoundedRect;
    
    // Department
    self.tfDepartment.enabled = YES;
    self.tfDepartment.borderStyle = UITextBorderStyleRoundedRect;
    
    // Address
    self.tvAddress.editable = YES;
    
    // Manager
    self.dropDownBtn.hidden = NO;
    self.saveBtn.hidden = NO;
    
    //When enabling edit, change edit button to the cancel icon
    [self.editBtn setTitle:@"Done" forState:UIControlStateNormal];
    editing = YES;
}

//Called when disabling editing
-(void)disableBorders
{
    self.tfPhoneNumber.borderStyle = UITextBorderStyleNone;
    self.tfEmail.borderStyle = UITextBorderStyleNone;
    self.tfPosition.borderStyle = UITextBorderStyleNone;
    self.tfDepartment.borderStyle = UITextBorderStyleNone;
}

@end
