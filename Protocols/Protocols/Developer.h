//
//  Developer.h
//  Protocols
//
//  Created by Виктор Мишустин on 30.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

#import "Patient.h"

@interface Developer : NSObject <Patient>

@property (assign, nonatomic) CGFloat experiance;
@property (strong, nonatomic) NSString * name;


- (void) work;

@end
