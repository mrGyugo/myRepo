//
//  Dancer.h
//  Protocols
//
//  Created by Виктор Мишустин on 30.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@interface Dancer : NSObject <Patient>

@property (strong, nonatomic) NSString * fovoriteDance;
@property (strong, nonatomic) NSString * name;

- (void) dance;

@end
