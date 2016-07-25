//
//  Developer.m
//  Protocols
//
//  Created by Виктор Мишустин on 30.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "Developer.h"

@implementation Developer

- (void) work {
    
}

#pragma mark - Patient

- (BOOL) areYouOk {
    
    BOOL ok = arc4random() % 2;
    
    NSLog(@"Is developer %@ ok? %@", self.name, ok ? @"YES" : @"NO ");
    return ok;
}
- (void) takePill {
    NSLog(@"Developer %@, takes a pill", self.name);
}
- (void) makeShot {
    NSLog(@"Developer %@, makes a shot", self.name);
}

- (NSString*) howIsYouJob {
    return @"My job is awesome";
}

@end
