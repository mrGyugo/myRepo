//
//  Student.h
//  ThraedsHome
//
//  Created by Виктор Мишустин on 23/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (strong, nonatomic) NSString * name;

- (instancetype)initWithName: (NSString*) name;

@end
