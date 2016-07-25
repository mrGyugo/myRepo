//
//  AppDelegate.m
//  DegatesHome
//
//  Created by Виктор Мишустин on 01.07.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AppDelegate.h"
#import "Patient.h"
#import "Doctor.h"
#import "Patient.h"
#import "Doctor.h"
#import "AnotherDoctor.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    Patient * patient1 = [[Patient alloc] initWithName:@"Vasya" andTemperature:36.8f];
    Patient * patient2 = [[Patient alloc] initWithName:@"Dima" andTemperature:41.2f];
    Patient * patient3 = [[Patient alloc] initWithName:@"Petya" andTemperature:37.2f];
    Patient * patient4 = [[Patient alloc] initWithName:@"Olya" andTemperature:40.5f];
    Patient * patient5 = [[Patient alloc] initWithName:@"Danila" andTemperature:38.8f];
    Patient * patient6 = [[Patient alloc] initWithName:@"Olesya" andTemperature:36.9f];
    Patient * patient7 = [[Patient alloc] initWithName:@"Katya" andTemperature:39.5f];
    Patient * patient8 = [[Patient alloc] initWithName:@"Vitya" andTemperature:37.3f];
    Patient * patient9 = [[Patient alloc] initWithName:@"Borya" andTemperature:36.7f];
    Patient * patient10 = [[Patient alloc] initWithName:@"Lena" andTemperature:42.0f ];
    

    
    Doctor * doctor = [[Doctor alloc] init];
    AnotherDoctor * anotherDoctor = [[AnotherDoctor alloc] init];
    
    patient1.delegate = doctor;
    patient2.delegate = doctor;
    patient3.delegate = doctor;
    patient4.delegate = doctor;
    patient5.delegate = doctor;
    patient6.delegate = anotherDoctor;
    patient7.delegate = anotherDoctor;
    patient8.delegate = anotherDoctor;
    patient9.delegate = anotherDoctor;
    patient10.delegate = anotherDoctor;
    
    
    NSArray * arrayPatient = [NSArray arrayWithObjects:patient1, patient2, patient3, patient4,
                              patient5, patient6, patient7, patient8, patient9, patient10, nil];
    
//    AnotherDoctor * anotherDoctor1 = [[AnotherDoctor alloc] init];
//    AnotherDoctor * anotherDoctor2 = [[AnotherDoctor alloc] init];
    
    for (Patient * patient in arrayPatient) {
        
        NSLog(@"patient %@ feel %@", patient.name, [patient iFeelBad] ? @"Bad" : @"Good");
        if ([patient.delegate isEqual:doctor]) {
            NSLog(@"Doctor");
        } else {
            NSLog(@"AnoterDoctor");
        }
        NSLog(@"\n\n\n");
        patient.badDoctor = arc4random() % 2;
        if (patient.badDoctor) {
            NSLog(@"Patient %@ have badDoctor", patient.name);
            if ([patient.delegate isEqual:doctor]) {
                patient.delegate = anotherDoctor;
            } else if ([patient.delegate isEqual:anotherDoctor]) {
                patient.delegate = doctor;
            }
        }
    }
    NSLog(@"* * * * * * * * * * * * * * * * * * * *");
    NSLog(@"New day");
    NSLog(@"* * * * * * * * * * * * * * * * * * * *");
    
    for (Patient * patient in arrayPatient) {
        NSLog(@"patient %@ feel %@", patient.name, [patient iFeelBad] ? @"Bad" : @"Good");
        if ([patient.delegate isEqual:doctor]) {
            NSLog(@"Doctor");
        } else {
            NSLog(@"AnoterDoctor");
        }
        NSLog(@"\n\n\n");
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
