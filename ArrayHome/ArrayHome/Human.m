//
//  Human.m
//  ArrayHome
//
//  Created by Виктор Мишустин on 29.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "Human.h"

@implementation Human

- (instancetype)initWithName: (NSString*) name andHeight: (CGFloat) height
                   andWeight: (CGFloat) weight andSex: (BOOL) sex
{
    self = [super init];
    if (self) {
        self.nameHuman = name;
        self.height = height;
        self.weight = weight;
        self.sex = sex;
    }
    return self;
}

- (void) movement
{
    NSLog(@"MoveMent %@", self.nameHuman);
}

@end
