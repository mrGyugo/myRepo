//
//  Student.h
//  Protocols
//
//  Created by Виктор Мишустин on 30.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@interface Student : NSObject <Patient>

@property (strong, nonatomic) NSString * universityName;
@property (strong, nonatomic) NSString * name;


- (void) study;

@end
