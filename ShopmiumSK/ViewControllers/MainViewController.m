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

#pragma mark - UIViewController

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
            homeViewController.textView.text = [NSString stringWithFormat:NSLocalizedString(@"Auto login (%@)", @"Email as parameter"), email];
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

#pragma mark - IBAction

- (IBAction)signupButtonPressed:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navigationScreen = [storyboard instantiateViewControllerWithIdentifier:@"navigation_screen"];
    [self presentViewController:navigationScreen animated:YES completion:nil];
}
@end
