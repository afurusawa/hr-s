//
//  UnderlyingView.m
//  HRDirectory
//
//  Created by Alex Chiu on 8/14/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "UnderlyingView.h"

@implementation UnderlyingView

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
        NSLog(@"Keyboard will hide");
        
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
@end
