//
//  RegisterView.h
//  Registration
//
//  Created by Isamu Iida on 2012/11/28.
//  Copyright (c) 2012年 Isamu Iida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationBar *navbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBack;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
- (IBAction)goBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *bottomBar;

@end
