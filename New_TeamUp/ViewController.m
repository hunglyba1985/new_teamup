//
//  ViewController.m
//  New_TeamUp
//
//  Created by MacOS on 5/30/18.
//  Copyright © 2018 MacOS. All rights reserved.
//

#import "ViewController.h"
#import "RegisterViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)openRegister:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RegisterViewController *registerView = [mainStoryboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self.navigationController pushViewController:registerView animated:YES];
}

- (IBAction)openSignIn:(id)sender {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
