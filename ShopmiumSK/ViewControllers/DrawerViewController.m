//
//  DrawerViewController.m
//  ShopmiumSK
//
//  Created by Salah on 2015-07-26.
//  Copyright (c) 2015 Salah. All rights reserved.
//

#import "DrawerViewController.h"

@interface DrawerViewController ()

@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setHidesBackButton:YES];
    
    UIImage *shopmiumLogo = [UIImage imageNamed:@"shopmium_logo"];
    UIButton *shopmiumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shopmiumButton.bounds = CGRectMake( 0, 0, 174, 33 );
    [shopmiumButton setImage:shopmiumLogo forState:UIControlStateNormal];
    UIBarButtonItem *shopmiumBarButton = [[UIBarButtonItem alloc] initWithCustomView:shopmiumButton];
    self.navigationItem.leftBarButtonItem = shopmiumBarButton;
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
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

@end
