//
//  SingleTone.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "SingleTone.h"

@implementation SingleTone

@synthesize dictImage;
@synthesize urlImage;
@synthesize buttonsArray;

#pragma mark Singleton Methods

+ (id)sharedManager{
    static SingleTone *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


@end
