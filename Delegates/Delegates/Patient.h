//
//  Patient.h
//  Delegates
//
//  Created by Виктор Мишустин on 30.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PatientDelegate;

@interface Patient : NSObject

@property (strong, nonatomic) NSString * name;
@property (assign, nonatomic) CGFloat temperature;
@property (weak, nonatomic) id <PatientDelegate> delegate;

- (BOOL) howAreYou;
- (void) takePill;
- (void) makeShot;

@end

@protocol PatientDelegate <NSObject>

- (void) patient: (Patient*) patient hasQuestion: (NSString*) question;
- (void) patientFeelsBad: (Patient*) patient;

@end
