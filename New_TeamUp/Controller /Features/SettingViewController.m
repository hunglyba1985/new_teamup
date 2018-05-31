//
//  SettingViewController.m
//  New_TeamUp
//
//  Created by MacOS on 5/31/18.
//  Copyright © 2018 MacOS. All rights reserved.
//

#import "SettingViewController.h"
#import "ViewController.h"


@interface SettingViewController ()  <FBSDKLoginButtonDelegate>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self addFacebookButton];
}

- (IBAction)signOutClick:(id)sender {
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
    else
    {
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logOut];
        NSLog(@"sign out success");
        ViewController *welcomeView = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [self.navigationController pushViewController:welcomeView animated:YES];
        
    }
}



-(void) addFacebookButton{
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.center = self.view.center;
    loginButton.delegate = self;
    loginButton.readPermissions = @[@"public_profile", @"email"];
    [self.view addSubview:loginButton];
}


#pragma mark - FBSDKLoginButtonDelegate
- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error {
    if (error == nil) {
        // ...
        FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                         credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
        [[FIRAuth auth] signInAndRetrieveDataWithCredential:credential
                                                 completion:^(FIRAuthDataResult * _Nullable authResult,
                                                              NSError * _Nullable error) {
                                                     if (error) {
                                                         // ...
                                                         return;
                                                     }
                                                     // User successfully signed in. Get user data from the FIRUser object
                                                     // ...
                                                     NSLog(@"register with facebook success");
                                                 }];
    } else {
        NSLog(@"error when login facebook");
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
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
