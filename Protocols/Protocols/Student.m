//
//  Student.m
//  Protocols
//
//  Created by Виктор Мишустин on 30.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "Student.h"

@implementation Student


- (void) study {
    
}

#pragma mark - Patient

- (BOOL) areYouOk {
    
    BOOL ok = arc4random() % 2;
    
    NSLog(@"Is student %@ ok? %@l", self.name, ok ? @"YES" : @"NO ");
    return ok;
}
- (void) takePill {
    NSLog(@"Student %@, takes a pill", self.name);
}
- (void) makeShot {
    NSLog(@"Student %@, makes a shot", self.name);
}

- (NSString*) howIsYouFamily {
    return @"My family is doing well!";
}


@end
