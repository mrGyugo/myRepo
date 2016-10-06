//
//  AppDelegate.m
//  BitwiseOperations
//
//  Created by Виктор Мишустин on 27.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AppDelegate.h"
#import "VMStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
//    NSMutableArray * arrayStudents = [NSMutableArray array];
//    
//    for (int i = 0; i < 10; i++) {
//        VMStudent * student = [[VMStudent alloc] init];
//        for (int j = 0; j < 7; j++) {
//            if (arc4random()%2) {
//                student.subjectType = student.subjectType | [self returnType:j];
//            }
//            
//        }
//        [arrayStudents addObject:student];
//    }
//    
//    for (VMStudent * student in arrayStudents) {
//        if (student.subjectType & VMStudentSubjectTypeBiology) {
//            student.subjectType = student.subjectType & ~VMStudentSubjectTypeBiology;
//        }
//    }
    
 
    
    NSInteger count = arc4random() %NSNotFound;
    
    
    NSLog(@"%d", count);
    
    NSMutableString * string = [[NSMutableString alloc] init];
    
    
    for (NSInteger i = 31; i >= 0; i--) {
        NSInteger maskBit = 1 << i;
        
        if ((count & maskBit) == 0) {
            [string appendString:@"0"];
        } else {
            [string appendString:@"1"];
        }
    }

    
    NSLog(@"%@", string);
    

    
    



    

    
    return YES;
}

- (void) arrayPtint: (NSMutableArray*) array {
    for (VMStudent * student in array) {
        NSLog(@"%@", student);
    }
}

- (VMStudentSubjectType) returnType: (NSInteger) count {
    
    VMStudentSubjectType subjectType = 0;
    
    switch (count) {
        case 0:
            subjectType = VMStudentSubjectTypeBiology;
            break;
        case 2:
            subjectType = VMStudentSubjectTypeAnatomy;
            break;
        case 3:
            subjectType = VMStudentSubjectTypePhycology;
            break;
        case 4:
            subjectType = VMStudentSubjectTypeArt;
            break;
        case 5:
            subjectType = VMStudentSubjectTypeEngineering;
            break;
        case 6:
            subjectType = VMStudentSubjectTypeDevelopment;
            break;
        case 7:
            subjectType = VMStudentSubjectTypeMath;
            break;
    }
    
    return subjectType;
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
