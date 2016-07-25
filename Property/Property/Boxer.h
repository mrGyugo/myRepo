//
//  Boxer.h
//  Property
//
//  Created by Виктор Мишустин on 29.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Boxer : NSObject

@property (strong, nonatomic) NSString * name;
@property (assign, nonatomic) NSInteger age;

- (NSInteger) howOldAreYou;

@end
