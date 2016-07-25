//
//  AnotherDoctor.m
//  DegatesHome
//
//  Created by Виктор Мишустин on 01.07.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AnotherDoctor.h"

@implementation AnotherDoctor

#pragma mark - PatientDelegate

- (void) patientFeelsBad: (Patient*) patient {
    
    if (patient.temperature > 36.6f && patient.temperature <= 39) {
        NSLog(@"Patient %@ need clysterize", patient.name);
    } else if (patient.temperature > 39.f) {
        NSLog(@"Patient %@ make operation", patient.name);
    } else {
        NSLog(@"Patient %@ go away", patient);
    }
}

@end
