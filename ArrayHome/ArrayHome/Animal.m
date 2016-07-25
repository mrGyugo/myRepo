//
//  Animal.m
//  ArrayHome
//
//  Created by Виктор Мишустин on 30.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "Animal.h"

@implementation Animal

- (instancetype)initWithNickname: (NSString*) nickname andLongHorns: (CGFloat) longHorns
{
    self = [super init];
    if (self) {
        self.nickname = nickname;
        self.longHorns = longHorns;
    }
    return self;
}

- (void) movement
{
    NSLog(@"Animal %@ movement", self.nickname);
}

@end
