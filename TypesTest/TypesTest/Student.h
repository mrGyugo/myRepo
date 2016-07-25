//
//  Student.h
//  TypesTest
//
//  Created by Виктор Мишустин on 30.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    genderMax,
    genderMin
} Gender;




@interface Student : NSObject

@property (strong, nonatomic) NSString * name;

@property (assign, nonatomic) Gender gender;

@end
