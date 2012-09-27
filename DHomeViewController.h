//
//  DHomeViewController.h
//  Timesheet
//
//  Created by Rapid Consulting on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHomeViewController : UIViewController
{
    BOOL isManager;
}
@property (weak, nonatomic) IBOutlet UIButton *browseButton;
@property (weak, nonatomic) IBOutlet UIButton *btnAddEmployee;

@end
