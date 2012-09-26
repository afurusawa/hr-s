//
//  OfflineDHomeViewController.h
//  Timesheet
//
//  Created by Alex Chiu on 9/19/12.
//
//

#import <UIKit/UIKit.h>

@interface OfflineDHomeViewController : UIViewController
{
    BOOL isManager;
}

@property (weak, nonatomic) IBOutlet UIButton *browseButton;
@property (weak, nonatomic) IBOutlet UIButton *btnAddEmployee;

@end
