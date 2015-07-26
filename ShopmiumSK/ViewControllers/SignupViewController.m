//
//  SignupViewController.m
//  ShopmiumSK
//
//  Created by Salah on 2015-07-26.
//  Copyright (c) 2015 Salah. All rights reserved.
//

#import "SignupViewController.h"
#import "DrawerViewController.h"

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
        //NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                 NSInteger statusCode = [httpResponse statusCode];
                 NSLog(@"Status code: %ld", (long)[httpResponse statusCode]);
                 if (statusCode == 201) {
                     [self performSegueWithIdentifier:@"drawer_segue" sender:self];
                 }
                 else if (statusCode == 422) {
                     NSString *msg = @"L'adresse email a déjà été utilisée";
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                     [alert show];
                 }
                 else {
                     NSString *msg = @"Une erreur est survenue, veuillez réessayer.";
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erreur" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                     [alert show];
                 }
             }
         }];
    }
    else {
        [self notifyInvalidEmail];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"drawer_segue"]) {
        DrawerViewController *destinationViewController = (DrawerViewController *)segue.destinationViewController;
        
        // Instantitate and set the center view controller.
        UIViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"home_screen"];
        [destinationViewController setCenterViewController: homeViewController];
        
        // Instantiate and set the left drawer controller.
        UIViewController *drawerLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"drawer_left_screen"];
        [destinationViewController setLeftDrawerViewController: drawerLeftViewController];
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
