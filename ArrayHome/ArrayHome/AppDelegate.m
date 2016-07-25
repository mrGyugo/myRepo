//
//  AppDelegate.m
//  ArrayHome
//
//  Created by Виктор Мишустин on 29.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AppDelegate.h"
#import "Human.h"
#import "Cyclist.h"
#import "Runner.h"
#import "Swimmer.h"
#import "Superman.h"
#import "Animal.h"
#import "Dog.h"
#import "Cat.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Humans----------------------
    
    Human * human = [[Human alloc] initWithName:@"Vasya" andHeight:167.2f andWeight:80.5f andSex:YES];
    Cyclist * cyclist = [[Cyclist alloc] initWithName:@"Dasha" andHeight:152.7f andWeight:62.4f andSex:NO];
    Runner * runner = [[Runner alloc] initWithName:@"Volodya" andHeight:173.4f andWeight:75.8f andSex:YES];
    Swimmer * swimmer = [[Swimmer alloc] initWithName:@"Gosha" andHeight:163.2f andWeight:64.4f andSex:YES];
    
    Superman * superman = [[Superman alloc] initWithName:@"Viktor" andHeight:173.5f andWeight:75.f andSex:YES];
    superman.force = @"Very strong";
    superman.speed = 100;
    
    //Animals---------------------
    Animal * animal = [[Animal alloc] initWithNickname:@"Pushka" andLongHorns:52];
    Dog * dog = [[Dog alloc] initWithNickname:@"Pochya" andLongHorns:10];
    Cat * cat = [[Cat alloc] initWithNickname:@"Chyucya" andLongHorns:15];
    
    NSArray * arrayHumans = [NSArray arrayWithObjects:
                             animal, cyclist, dog,
                             swimmer, superman, human, runner, cat, nil];
    
    NSArray * sortArray = [arrayHumans sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 isKindOfClass:[Human class]]) {
            return (NSComparisonResult)NSOrderedAscending;
                    }
        if (![obj1 isKindOfClass:[Human class]]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSArray * sortArrayName = [sortArray sortedArrayWithOptions:0 usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 isKindOfClass:[Human class]] && [obj2 isKindOfClass:[Human class]]) {
            Human * human1 = (Human*)obj1;
            Human * human2 = (Human*)obj2;
            return [human1.nameHuman compare:human2.nameHuman options:NSCaseInsensitiveSearch];
        } else if ([obj1 isKindOfClass:[Animal class]] && [obj2 isKindOfClass:[Animal class]]) {
            Animal * animal1 = (Animal*)obj1;
            Animal * animal2 = (Animal*)obj2;
            return [animal1.nickname compare:animal2.nickname options:NSCaseInsensitiveSearch];
        }
        return (NSComparisonResult)NSOrderedSame;
    }];


    

    
    NSString * sexName;
    
    for (NSObject * custOBject in sortArrayName) {
        
        NSString * stringTypeClass = [custOBject description];
        
        NSLog(@"Type - %@", stringTypeClass);
        
        if ([custOBject isKindOfClass:[Human class]]) {
            Human * custHuman = (Human*) custOBject;
            
            if (custHuman.sex) {
                sexName = @"Male";
            } else {
                sexName = @"Female";
            }
            
            NSLog(@"Name - %@", custHuman.nameHuman);
            NSLog(@"Height - %.1f", custHuman.height);
            NSLog(@"Weight - %.1f", custHuman.weight);
            NSLog(@"Sex - %@", sexName);
            
            if ([custHuman isKindOfClass:[Superman class]]) {
                Superman * superman = (Superman*)custHuman;
                NSLog(@"Forse - %@", superman.force);
                NSLog(@"Speed - %ld km/h", (long)superman.speed);
                
            }
            
            [custHuman movement];
            
        } else if ([custOBject isKindOfClass:[Animal class]]) {
            Animal * custAnimal = (Animal*) custOBject;
            
            NSLog(@"Nickname - %@", custAnimal.nickname);
            NSLog(@"Long Horns - %.f", custAnimal.longHorns);
            
            [custAnimal movement];
        }
        
        
        NSLog(@"\n\n* * * * * * * * * * * * *\n\n");
        
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
