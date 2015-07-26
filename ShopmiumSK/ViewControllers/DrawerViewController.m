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

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationItem setHidesBackButton:YES];
    
    UIImage *shopmiumLogo = [UIImage imageNamed:@"shopmium_logo"];
    UIButton *shopmiumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shopmiumButton.bounds = CGRectMake( 0, 0, 174, 33 );
    [shopmiumButton setImage:shopmiumLogo forState:UIControlStateNormal];
    UIBarButtonItem *shopmiumBarButton = [[UIBarButtonItem alloc] initWithCustomView:shopmiumButton];
    self.navigationItem.leftBarButtonItem = shopmiumBarButton;

    self.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
}

@end
