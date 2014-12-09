//
//  AppDelegate.m
//  TouchIdFix
//
//  Created by Johnil on 14/12/9.
//  Copyright (c) 2014年 Johnil. All rights reserved.
//

#import "AppDelegate.h"
#import "AuthViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface AppDelegate ()
@end

@implementation AppDelegate {
    AuthViewController *authViewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (authViewController==nil) {
        authViewController = [[AuthViewController alloc] init];
        [self.window addSubview:authViewController.view];
        [authViewController showAuth];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        LAContext *context = [[LAContext alloc] init];
        NSError *error;
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            if (authViewController==nil) {
                authViewController = [[AuthViewController alloc] init];
                [self.window addSubview:authViewController.view];
            }
            [authViewController enterBG];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)becomeActive{
    authViewController = nil;
    NSLog(@"active", nil);
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (authViewController==nil) {
        [self becomeActive];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
