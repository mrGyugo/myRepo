//
//  Patient.m
//  Delegates
//
//  Created by Виктор Мишустин on 30.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "Patient.h"

@implementation Patient

- (BOOL) howAreYou {
    
    BOOL iFeel = arc4random() % 2;
    
    if (!iFeel) {
        [self.delegate patientFeelsBad:self];
    }
    
    return iFeel;
}
- (void) takePill {
    NSLog(@"%@ takes a pill", self.name);
}
- (void) makeShot {
    NSLog(@"%@ make a shot", self.name);
}

@end
