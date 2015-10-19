//
//  AppDelegate.m
//  WinkTest
//
//  Created by Aginova on 15/04/15.
//  Copyright (c) 2015 Aginova. All rights reserved.
//

#import "AppDelegate.h"
#import <WinkAPI/WinkAPI.h>
#import "Crittercism.h"
#import "WinkAPIHandler.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSArray *centralManagerIdentifiers =
    launchOptions[UIApplicationLaunchOptionsBluetoothCentralsKey];
    NSLog(@"App launched with central identifiers: %@",centralManagerIdentifiers);
    if (centralManagerIdentifiers.count > 0) {
        NSLog(@"App launched with ability to restore CBCentralManager");
        [__WINKAPI setBluetoothDelegate:__WinkAPIHandler];
        [__WINKAPI restoreCentralWithIdentifier:centralManagerIdentifiers[0]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"WinkTest" message:@"App launched with ability to restore CBCentralManager" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
    }
    else {
        [__WINKAPI setBluetoothDelegate:__WinkAPIHandler];
        [__WINKAPI startBluetoothListening:10.0];
    }
    // Override point for customization after application launch.
    [Crittercism enableWithAppID:@"556d9b8267a3707e4fe35eac"];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"inside applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //[__WINKAPI restoreDeviceWithIdentifier:@"winkCentralManagerIdentifier"];
    NSLog(@"inside applicationWillEnterForeground");

    [__WINKAPI setBluetoothDelegate:__WinkAPIHandler];
    [__WINKAPI startBluetoothListening:10.0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"inside applicationDidBecomeActive");
    [__WINKAPI setBluetoothDelegate:__WinkAPIHandler];
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [__WINKAPI startListeningForBLEDevice];
    });
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"inside applicationWillTerminate");
    //[__WINKAPI stopBluetoothListening];
}

@end
