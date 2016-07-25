//
//  Patient.h
//  DegatesHome
//
//  Created by Виктор Мишустин on 01.07.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    
    VMDoctorPartOfTheBodyLeg,
    VMDoctorPartOfTheBodyFoot,
    VMDoctorPartOfTheBodyHead,
    VMDoctorPartOfTheBodyHand
    
} VMDoctorPartOfTheBody;

@interface Patient : NSObject

@property (strong, nonatomic) NSString * name;
@property (assign, nonatomic) CGFloat temperature;
@property (assign, nonatomic) VMDoctorPartOfTheBody partOfTheBody;
@property (assign, nonatomic) BOOL badDoctor;

- (void) takePill;
- (void) makeShot;

- (instancetype)initWithName: (NSString*) name
              andTemperature: (CGFloat) temperature
                    andBlock: (void(^)(Patient *)) myBlock;



@end

