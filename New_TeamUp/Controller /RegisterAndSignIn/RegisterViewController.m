//
//  RegisterViewController.m
//  New_TeamUp
//
//  Created by MacOS on 5/30/18.
//  Copyright © 2018 MacOS. All rights reserved.
//

#import "RegisterViewController.h"
#import "TabBarController.h"

@interface RegisterViewController () <FBSDKLoginButtonDelegate>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addFacebookButton];
    [self loadUserFacebookProfile];
    
}

-(void) addFacebookButton{
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.center = self.view.center;
    loginButton.delegate = self;
    loginButton.readPermissions = @[@"public_profile", @"email"];
    [self.view addSubview:loginButton];
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"Register";
}

-(void) loadUserFacebookProfile{
    
    [FBSDKProfile loadCurrentProfileWithCompletion:
     ^(FBSDKProfile *profile, NSError *error) {
         if (profile) {
             NSLog(@"Hello, %@!", profile.name);
             UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
             welcomeLabel.text = [NSString stringWithFormat:@"Hello, %@!",profile.name];
             welcomeLabel.textAlignment = NSTextAlignmentCenter;
             welcomeLabel.center = CGPointMake(self.view.center.x, 350);
             [self.view addSubview:welcomeLabel];
         }
     }];
    
    FBSDKProfilePictureView *profilePictureView = [[FBSDKProfilePictureView alloc] init];
    profilePictureView.frame = CGRectMake(0,0,100,100);
    profilePictureView.center = CGPointMake(self.view.center.x, 200);
    profilePictureView.profileID = [[FBSDKAccessToken currentAccessToken] userID];
    [self.view addSubview:profilePictureView];
    
 
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
                                                     NSLog(@"user signed in-------");
                                                     NSLog(@"get current user is %@",[FIRAuth auth].currentUser.phoneNumber);
                                                     TabBarController *mainTabView = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
                                                     [self.navigationController pushViewController:mainTabView animated:true];

                                                     
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
