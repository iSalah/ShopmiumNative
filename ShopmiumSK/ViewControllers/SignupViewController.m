//
//  SignupViewController.m
//  ShopmiumSK
//
//  Created by Salah on 2015-07-26.
//  Copyright (c) 2015 Salah. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *emailImage = [UIImage imageNamed:@"email_icon"];
    UIImageView *emailIcon = [[UIImageView alloc] initWithImage:emailImage];
    emailIcon.frame = CGRectMake(0.0, 0.0, emailIcon.image.size.width+10.0, emailIcon.image.size.height);
    emailIcon.contentMode = UIViewContentModeCenter;
    
    [self.emailField setLeftViewMode:UITextFieldViewModeAlways];
    [self.emailField setLeftView:emailIcon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)emailFieldChanged:(UITextField *)sender {
    if ([self validateEmail:sender.text]) {
        [self notifyValidEmail];
    }
    else {
        [self notifyInvalidEmail];
    }
}


- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];

    return [emailTest evaluateWithObject:candidate];
}

- (void) notifyInvalidEmail {
    UIImageView *emailIcon = (UIImageView *)self.emailField.leftView;
    emailIcon.image = [emailIcon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    [emailIcon setTintColor:[UIColor redColor]];
    [self.signupButton setEnabled:NO];
}

- (void) notifyValidEmail {
    UIImageView *emailIcon = (UIImageView *)self.emailField.leftView;
    emailIcon.image = [emailIcon.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    [emailIcon setTintColor:[UIColor greenColor]];
    [self.signupButton setEnabled:YES];
}
@end
