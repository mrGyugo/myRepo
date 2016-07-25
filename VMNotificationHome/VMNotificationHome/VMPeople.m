//
//  VMPeople.m
//  VMNotificationHome
//
//  Created by Виктор Мишустин on 23/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "VMPeople.h"
#import "AppDelegate.h"

@implementation VMPeople

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appdeleg1) name:UIApplicationWillResignActiveNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appdeleg2) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appdeleg3) name:UIApplicationWillEnterForegroundNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appdeleg4) name:UIApplicationDidBecomeActiveNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appdeleg5) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}

- (void) appdeleg1 {
    NSLog(@"UIApplicationWillResignActiveNotification");
}

- (void) appdeleg2 {
    NSLog(@"UIApplicationDidEnterBackgroundNotification");
}

- (void) appdeleg3 {
    NSLog(@"UIApplicationWillEnterForegroundNotification");
}

- (void) appdeleg4 {
    NSLog(@"UIApplicationDidBecomeActiveNotification");
}

- (void) appdeleg5 {
    NSLog(@"UIApplicationWillTerminateNotification");
}

@end
