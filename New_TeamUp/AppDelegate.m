//
//  AppDelegate.m
//  New_TeamUp
//
//  Created by MacOS on 5/30/18.
//  Copyright © 2018 MacOS. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "ViewController.h"
#import "TabBarController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate



//  AppDelegate.m
#import <FBSDKCoreKit/FBSDKCoreKit.h>

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    // Add any custom logic here.
    
    // Use Firebase library to configure APIs
    [FIRApp configure];
    [self checkUserSignIn];
    [self registerCustomForm];
    return YES;
}

-(void)registerCustomForm{
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:@"ImageCustomCell" forKey:@"XLFormRowDescriptorYourCustomType"];
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:@"UserImageCell" forKey:@"XLFormRowDescriptorYourCustomType"];
    [XLFormViewController.cellClassesForRowDescriptorTypes setObject:@"SelectLocationCell" forKey:@"XLFormRowDescriptorYourCustomType"];

}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    // Add any custom logic here.
    return handled;
}

-(void) checkUserSignIn
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if ([FIRAuth auth].currentUser) {
        // User is signed in.
        // ...
        NSLog(@"user signed in-------");
        NSLog(@"get current user is %@",[FIRAuth auth].currentUser.phoneNumber);
        TabBarController *mainTabView = [storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainTabView];
        self.window.rootViewController  = nav;
        
        
    } else {
        // No user is signed in.
        // ...
        NSLog(@"no user signed in");
        ViewController *welcomeView = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:welcomeView];
        self.window.rootViewController = nav;
    }
    [self.window makeKeyAndVisible];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
