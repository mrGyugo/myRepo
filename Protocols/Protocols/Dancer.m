//
//  Dancer.m
//  Protocols
//
//  Created by Виктор Мишустин on 30.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "Dancer.h"

@implementation Dancer

- (void) dance {
    
}

#pragma mark - Patient

- (BOOL) areYouOk {
    
    BOOL ok = arc4random() % 2;
    
    NSLog(@"Is Dancer %@ ok? %@", self.name, ok ? @"YES" : @"NO ");
    return ok;
}
- (void) takePill {
    NSLog(@"Dancer %@, takes a pill", self.name);
}
- (void) makeShot {
    NSLog(@"Dancer %@, makes a shot", self.name);
}

@end
