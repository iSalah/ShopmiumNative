//
//  DrawerLeftViewController.m
//  ShopmiumSK
//
//  Created by Salah on 2015-07-26.
//  Copyright (c) 2015 Salah. All rights reserved.
//

#import "DrawerLeftViewController.h"

@interface DrawerLeftViewController ()

@end

@implementation DrawerLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.data = [[NSArray alloc] initWithObjects:@"Offres", @"Magasins", @"Avis", @"Parrainer un ami",  @"Mes achats",  @"Déconnexion", @"Aide", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [cell.textLabel setText:[self.data objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Disconnect button
    if (indexPath.row == 5) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
