//
//  ResumeViewController.m
//  HRDirectory
//
//  Created by Alex Chiu on 8/20/12.
//  Copyright (c) 2012 Alex Chiu. All rights reserved.
//

#import "ResumeViewController.h"

@interface ResumeViewController ()

@end

@implementation ResumeViewController

@synthesize resumeURL = _resumeURL;
@synthesize webView = _webView;

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
    NSLog(@"%@ did load", self.class);
    
    [super viewDidLoad];
    
    [self startLoadingAnimations];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loadResumeToView];
    
    [self stopLoadingAnimations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)loadResumeToView
{
    [self.webView setScalesPageToFit:YES];
    NSLog(@"%@",self.resumeURL);
    NSURL *url = [NSURL URLWithString:self.resumeURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

@end
