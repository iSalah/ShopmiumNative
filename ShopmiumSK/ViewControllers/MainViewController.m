//
//  MainViewController.m
//  ShopmiumSK
//
//  Created by Salah on 2015-07-26.
//  Copyright (c) 2015 Salah. All rights reserved.
//

#import "MainViewController.h"
#import "DrawerViewController.h"
#import "HomeViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstTimeViewAppears = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // Auto login if already signup
    if (self.firstTimeViewAppears) {
        self.firstTimeViewAppears = NO;
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString * email = [prefs objectForKey:@"email"];
        NSLog(@"Email: %@", email);
        if (email != nil) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UINavigationController *navigationScreen = [storyboard instantiateViewControllerWithIdentifier:@"navigation_screen"];
        
            DrawerViewController *drawerViewController = [storyboard instantiateViewControllerWithIdentifier:@"drawer_screen"];
        
            // Instantitate and set the center view controller.
            HomeViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"home_screen"];
            [homeViewController view];
            homeViewController.textView.text = [NSString stringWithFormat:@"Login automatique (%@)", email];
            [drawerViewController setCenterViewController: homeViewController];
        
            // Instantiate and set the left drawer controller.
            UIViewController *drawerLeftViewController = [storyboard instantiateViewControllerWithIdentifier:@"drawer_left_screen"];
            [drawerViewController setLeftDrawerViewController: drawerLeftViewController];
        
            // Put drawer on top of navigation view
            NSArray *viewControllers = [[NSArray alloc] initWithObjects:drawerViewController, nil];
            [navigationScreen setViewControllers:viewControllers animated:NO];
        
            [self presentViewController:navigationScreen animated:YES completion:nil];
        }
    }
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

- (IBAction)signupButtonPressed:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navigationScreen = [storyboard instantiateViewControllerWithIdentifier:@"navigation_screen"];
    [self presentViewController:navigationScreen animated:YES completion:nil];
}
@end
