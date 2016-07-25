//
//  Patient.m
//  DegatesHome
//
//  Created by Виктор Мишустин on 01.07.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "Patient.h"

typedef void (^BlockDoctor)(__weak Patient*);

@interface Patient ()

@end

@implementation Patient

- (instancetype)initWithName: (NSString*) name
              andTemperature: (CGFloat) temperature andBlock: (BlockDoctor) myBlock;
{
    self = [super init];
    if (self) {
        self.name = name;
        self.temperature = temperature;
        
        [self performSelector:@selector(runBlock:) withObject:myBlock afterDelay:arc4random() % 10 + 5];
    }
    return self;
}

- (void) takePill
{
    NSLog(@"Patient %@ take pill", self.name);
}
- (void) makeShot
{
    NSLog(@"Patient %@ make shot", self.name);
}

- (void) runBlock: (BlockDoctor) myBlock {
    myBlock(self);
}

- (void) dealloc {
    NSLog(@"Patient %@ dead", self.name);
}


@end

