//
//  AppDelegate.m
//  String
//
//  Created by Виктор Мишустин on 22/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    

    NSString * string = @"Xcode 8 includes everything you need to create amazing apps for iPhone, iPad, Mac, Apple Watch, and Apple TV. This radically faster version of the IDE features new editor extensions that you can use to completely customize your coding experience. New runtime issues alert you to hidden bugs by pointing out memory leaks, and a new Memory Debugger dives deep into your object graph. Swift 3 includes more natural and consistent API naming, which you can experiment with in the new Swift Playgrounds app for iPad.";
    
    
    

    
    NSRange searchRange = NSMakeRange(0, [string length]);
    
    NSInteger * couter = 0;
    
    while (YES) {
        
        NSRange range = [string rangeOfString:@"This" options:0 range:searchRange];
        
        if (range.location != NSNotFound) {
            NSInteger index = range.location + range.length;
            searchRange.location = index;
            searchRange.length = string.length - index;
            
            NSLog(@"%@", NSStringFromRange(range));
            
            couter += 1;
        } else {
            break;
        }
        
    }
    
    NSLog(@"%d", couter);
    

    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
