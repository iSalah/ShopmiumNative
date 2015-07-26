//
//  SignupViewController.m
//  ShopmiumSK
//
//  Created by Salah on 2015-07-26.
//  Copyright (c) 2015 Salah. All rights reserved.
//

#import "SignupViewController.h"
#import "DrawerViewController.h"
#import "HomeViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *emailImage = [UIImage imageNamed:@"email_icon"];
    UIImageView *emailIcon = [[UIImageView alloc] initWithImage:emailImage];
    emailIcon.frame = CGRectMake(0.0, 0.0, emailIcon.image.size.width+10.0, emailIcon.image.size.height);
    emailIcon.contentMode = UIViewContentModeCenter;
    
    [self.emailField setLeftViewMode:UITextFieldViewModeAlways];
    [self.emailField setLeftView:emailIcon];
    
    self.serverRespone = @"";
}

#pragma mark - IBAction

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

- (IBAction)signupButtonPressed:(UIBarButtonItem *)sender {
    NSString *email = self.emailField.text;
    if ([self validateEmail:email]) {
        // Initialize post data
        NSDictionary *user = [[NSDictionary alloc] initWithObjectsAndKeys:email, @"email", nil];
        NSString *device = @"{\"app_platform\":\"3\"}";
        NSDictionary *post = [[NSDictionary alloc] initWithObjectsAndKeys:
                              user, @"user",
                              device, @"device",
                              nil];
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:post options:0 error:&error];
        
        // Initialize request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"https://app-staging.shopmium.com/mobileapp/v39/user"]];
        [request setHTTPMethod:@"POST"];
        
        // Set headers
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        // Set body
        [request setHTTPBody:postData];
        
        // Send request
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
         {
             [self handleSignupResponse:response data:data connectionError:connectionError email:email];
         }];
    }
    else {
        [self notifyInvalidEmail];
    }
}

#pragma mark - Segue

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"drawer_segue"]) {
        DrawerViewController *destinationViewController = (DrawerViewController *)segue.destinationViewController;
        
        // Instantitate and set the center view controller.
        HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"home_screen"];
        [homeViewController view];
        NSLog(@"%@", self.serverRespone);
        homeViewController.textView.text = self.serverRespone;
        [destinationViewController setCenterViewController: homeViewController];
        
        // Instantiate and set the left drawer controller.
        UIViewController *drawerLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"drawer_left_screen"];
        [destinationViewController setLeftDrawerViewController: drawerLeftViewController];
    }
}

#pragma mark - SignupValidation

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

- (void) performSuccessAuthentication: (NSString *)email data:(NSData *)data {
    self.serverRespone = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self performSegueWithIdentifier:@"drawer_segue" sender:self];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:email forKey:@"email"];
    [prefs synchronize];
}

- (void) performFailureAuthentication: (NSString *)errorMessage {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:errorMessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

-(void) handleSignupResponse: (NSURLResponse *)response data:(NSData*)data connectionError:(NSError*)connectionError email:(NSString *)email
{
    if (data.length > 0 && connectionError == nil)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSInteger statusCode = [httpResponse statusCode];
        NSLog(@"Status code: %ld", (long)[httpResponse statusCode]);
        if (statusCode == 201) {
            [self performSuccessAuthentication:email data:data];
        }
        else if (statusCode == 422) {
            [self performFailureAuthentication:@"L'adresse email a déjà été utilisée"];
        }
        else {
            [self performFailureAuthentication:@"Une erreur est survenue, veuillez réessayer."];
        }
    }
    else {
        [self performFailureAuthentication:@"Une erreur est survenue, veuillez réessayer."];
    }
}



@end
