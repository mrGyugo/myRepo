//
//  Target.h
//  RoboWars
//
//  Created by Виктор Мишустин on 26.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Target : NSObject

@property (assign, nonatomic) CGRect rect;
@property (assign, nonatomic) NSMutableSet * health;

- (id) initWithRect: (CGRect) rect;

@end
