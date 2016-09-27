//
//  VMSmart.h
//  RoboWars
//
//  Created by Виктор Мишустин on 26.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSpilotProtocol.h"

@interface VMSmart : NSObject <VSPilotProtocol>

@property (assign, nonatomic, readwrite) CGRect robotRect;
@property (assign, nonatomic, readwrite) CGSize fieldSize;

@end
