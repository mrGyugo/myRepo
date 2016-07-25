//
//  AppDelegate.m
//  Protocols
//
//  Created by Виктор Мишустин on 30.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AppDelegate.h"
#import "Patient.h"
#import "Developer.h"
#import "Student.h"
#import "Dancer.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    Dancer * dancer1 = [[Dancer alloc] init];
    Dancer * dancer2 = [[Dancer alloc] init];
    
    Student * student1 = [[Student alloc] init];
    Student * student2 = [[Student alloc] init];
    Student * student3 = [[Student alloc] init];
    
    Developer * developer = [[Developer alloc] init];
    Developer * developer2 = [[Developer alloc] init];
    Developer * developer3 = [[Developer alloc] init];
    Developer * developer4 = [[Developer alloc] init];
    
    dancer1.name = @"Vasya";
    dancer2.name = @"Petya";
    
    student1.name = @"student1";
    student2.name = @"student2";
    student3.name = @"student3";
    
    developer.name = @"developer";
    developer2.name = @"developer2";
    developer3.name = @"developer3";
    developer4.name = @"developer4";
    
    NSObject * fake = [NSObject new];
    
    NSArray * arrayPationts = [NSArray arrayWithObjects:
                               fake, dancer1, dancer2, student1, student2, student3,
                               developer, developer2, developer3,developer4, nil];
    
    
    for (NSObject <Patient> * object in arrayPationts) {
        
        if ([object conformsToProtocol:@protocol(Patient) ]) {
            NSLog(@"Patient name = %@", object.name);
            if ([object respondsToSelector:@selector(howIsYouFamily)]) {
                NSLog(@"How is you family? \n%@", [object howIsYouFamily]);
            }
            if ([object respondsToSelector:@selector(howIsYouJob)]) {
                NSLog(@"How is you job? \n%@", [object howIsYouJob]);
            }
            
            if (![object areYouOk]) {
                [object takePill];
                if (![object areYouOk]) {
                    [object makeShot];
                }
            }
            if (![object isEqual:[arrayPationts lastObject]]) {
                NSLog(@"\n");
            }
        } else {
            NSLog(@"FAKE!!!!");
        }
        


    }

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
