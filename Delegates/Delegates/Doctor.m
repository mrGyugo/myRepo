//
//  Doctor.m
//  Delegates
//
//  Created by Виктор Мишустин on 30.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "Doctor.h"

@implementation Doctor


#pragma mark - PatientDelegate

- (void) patient: (Patient*) patient hasQuestion: (NSString*) question {
    
    NSLog(@"Patient %@ has a question: %@", patient.name, question);    
}
- (void) patientFeelsBad: (Patient*) patient {

    NSLog(@"Patient %@ fells bad", patient.name);
    
    if (patient.temperature > 37.f && patient.temperature <= 39.f) {
        [patient takePill];
    } else if (patient.temperature > 39.f) {
        [patient makeShot];
    } else {
        NSLog(@"patient %@ should rest", patient.name);
    }
}

@end
