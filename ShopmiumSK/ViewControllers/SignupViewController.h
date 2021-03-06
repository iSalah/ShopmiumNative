//
//  SignupViewController.h
//  ShopmiumSK
//
//  Created by Salah on 2015-07-26.
//  Copyright (c) 2015 Salah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *signupButton;

@property (strong, nonatomic) NSString *serverRespone;

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)emailFieldChanged:(UITextField *)sender;
- (IBAction)signupButtonPressed:(UIBarButtonItem *)sender;

@end
