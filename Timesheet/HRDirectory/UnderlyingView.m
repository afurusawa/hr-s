//
//  UnderlyingView.m
//  HRDirectory
//
//  Created by Alex Chiu on 8/14/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "UnderlyingView.h"

@implementation UnderlyingView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

//Begins the loading animations
-(void)startLoadingAnimations
{
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    loadingView = [[UIView alloc] initWithFrame:[[self view] bounds]];
    
    //Loading View Asthetics
    [loadingView setBackgroundColor:[UIColor blackColor]];
    [loadingView setAlpha:0.2];
    
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(250,250, 325, 325);
    [[self view] addSubview:loadingView];
    [loadingView addSubview:indicator];
    
    [[self view] addSubview:indicator];
    
    [indicator startAnimating];
}

-(void)stopLoadingAnimations
{
    [indicator stopAnimating];
    [loadingView removeFromSuperview];
}

/* Selector for when the keyboard appears
 * Will shrink the view size so user can scroll to look at their data on the shrunken view
 */
-(void)keyboardWillShow:(NSNotification *)n
{
    if(!keyboardShown)
    {
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
        
        [self.view setFrame:viewFrame];
        
        [UIView commitAnimations];
        
        keyboardShown = YES;
    }
}

/* Selector for when the keyboard hides
 * Will enlarge the view to normal when the keyboard is no longer taking up part of the screen
 */
-(void)keyboardWillHide:(NSNotification *)n
{
    if(keyboardShown)
    {        
        NSDictionary *userInfo = [n userInfo];
        
        //Getting size of the keyboard
        CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        
        //Getting new frame
        CGRect newFrameSize = self.view.frame;
        newFrameSize.size.height += keyboardSize.height;
        
        //Animations
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:.3];
        
        //Setting the new frame size
        [self.view setFrame:newFrameSize];
        
        [UIView commitAnimations];
        
        keyboardShown = NO;
    }
}

//Receives a string and strips it down to only numbers
-(NSString *)stripEverythingButNumbers:(NSString *)phoneNumber
{
    NSCharacterSet *digits = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSScanner *scanner = [NSScanner scannerWithString:phoneNumber];
    
    NSMutableString *resultString = [NSMutableString stringWithCapacity:phoneNumber.length];
    
    //Scanner will loop through the string
    while(![scanner isAtEnd])
    {
        NSString *buffer;
        if([scanner scanCharactersFromSet:digits intoString:&buffer])
        {
            [resultString appendString:buffer];
        }
        else
            [scanner setScanLocation:([scanner scanLocation]+1)];
    }
    return resultString;
}

//Simple method to see if a character is a digit
-(BOOL)characterIsDigit:(char)ch
{
    NSCharacterSet *digits = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    return [digits characterIsMember:ch];
}

//Takes a raw input of numbers only!
-(NSString *)formatPhoneNumber:(NSString *)phoneNumber
{
    NSMutableString *resultPhoneNumber;
    
    NSString *currentString = [self stripEverythingButNumbers:phoneNumber];
    int length = [currentString length];
    
    //If the length of the input is greater than the standard 10 digits,
    // it will drop the digits after it.
    if(length >= 10)
    {
        currentString = [phoneNumber substringToIndex:10];
        length = 10;
    }
    
    if(length >= 6)
    {
        NSRange range = NSMakeRange(3, 3);
        
        NSString *first3 = [currentString substringToIndex:3];
        NSString *next3 = [currentString substringWithRange:range];
        NSString *last4 = [currentString substringFromIndex:6];
        
        resultPhoneNumber = [NSString stringWithFormat:@"(%@)-%@-%@", first3, next3, last4];
    }
    else if(length >= 3) //If 6>length>3
    {
        NSString *first3 = [currentString substringToIndex:3];
        NSString *next3 = [currentString substringFromIndex:3];
        
        resultPhoneNumber = [NSString stringWithFormat:@"(%@)-%@", first3, next3];
    }
    
    else if(length >= 0)// 3 > length > 0
    {
        resultPhoneNumber = [NSString stringWithFormat:@"(%@", currentString];
    }
    
    return resultPhoneNumber;
}



@end
