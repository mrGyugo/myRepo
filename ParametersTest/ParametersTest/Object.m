//
//  Object.m
//  ParametersTest
//
//  Created by Виктор Мишустин on 29.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "Object.h"

@implementation Object


- (void) dealloc
{
    NSLog(@"object is deallocated");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"object reated");
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    return [[Object alloc] init];
}

@end
