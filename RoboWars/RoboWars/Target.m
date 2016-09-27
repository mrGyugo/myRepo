//
//  Target.m
//  RoboWars
//
//  Created by Виктор Мишустин on 26.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "Target.h"

@implementation Target

- (id) initWithRect: (CGRect) rect {
    self = [super init];
    if (self) {
        self.rect = rect;
        self.health = [NSMutableSet set];
        for (int i = CGRectGetMinX(self.rect); i < CGRectGetMaxX(self.rect); i++) {
            for (int j = CGRectGetMinY(self.rect); j < CGRectGetMaxY(self.rect); j++) {
                CGPoint pointTarget = CGPointMake(i, j);
                [self.health addObject:NSStringFromCGPoint(pointTarget)];
            }
        }
    }
    
    NSLog(@"%@", self.health);
    
    return self;
}

@end
