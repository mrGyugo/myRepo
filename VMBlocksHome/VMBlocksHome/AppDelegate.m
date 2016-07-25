//
//  AppDelegate.m
//  VMBlocksHome
//
//  Created by Виктор Мишустин on 23/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AppDelegate.h"
#import "Patient.h"

typedef void (^BlockDoctor) (__weak Patient*);

@interface AppDelegate ()

@property (strong, nonatomic) NSArray * arrayPatient;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    BlockDoctor doctorBlock = ^(Patient * patientBlock) {
        if (patientBlock.temperature > 37 && patientBlock.temperature < 39) {
            [patientBlock takePill];
        } else if (patientBlock.temperature > 39) {
            [patientBlock makeShot];
        } else {
            NSLog(@"%@ relax", patientBlock.name);
        }
    };
    
    Patient * patient1 = [[Patient alloc] initWithName:@"Vasya" andTemperature:36.8f andBlock:doctorBlock];
    Patient * patient2 = [[Patient alloc] initWithName:@"Dima" andTemperature:41.2f andBlock:doctorBlock];
    Patient * patient3 = [[Patient alloc] initWithName:@"Petya" andTemperature:37.2f andBlock:doctorBlock];
    Patient * patient4 = [[Patient alloc] initWithName:@"Olya" andTemperature:40.5f andBlock:doctorBlock];
    Patient * patient5 = [[Patient alloc] initWithName:@"Danila" andTemperature:38.8f andBlock:doctorBlock];
    Patient * patient6 = [[Patient alloc] initWithName:@"Olesya" andTemperature:36.9f andBlock:doctorBlock];
    Patient * patient7 = [[Patient alloc] initWithName:@"Katya" andTemperature:39.5f andBlock:doctorBlock];
    Patient * patient8 = [[Patient alloc] initWithName:@"Vitya" andTemperature:37.3f andBlock:doctorBlock];
    Patient * patient9 = [[Patient alloc] initWithName:@"Borya" andTemperature:36.7f andBlock:doctorBlock];
    Patient * patient10 = [[Patient alloc] initWithName:@"Lena" andTemperature:42.0f andBlock:doctorBlock];

    _arrayPatient = [NSArray arrayWithObjects:patient1, patient2, patient3, patient4,
                              patient5, patient6, patient7, patient8, patient9, patient10, nil];

    

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
