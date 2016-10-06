//
//  VMStudent.h
//  NSDate
//
//  Created by Виктор Мишустин on 28.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VMStudent : NSObject

@property (strong, nonatomic) NSDate * dateOfBirth;
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * lastName;

- (instancetype)initWithDateofBirth: (NSDate*) dateOfBirth;


@end
