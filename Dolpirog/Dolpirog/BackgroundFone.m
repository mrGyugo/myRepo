//
//  BackgroundFone.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 05/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "BackgroundFone.h"

@implementation BackgroundFone

- (instancetype)initWithView: (UIView*) view andImage: (NSString*) imageName
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        UIImageView * backgroundImage = [[UIImageView alloc] initWithFrame:self.frame];
        backgroundImage.image = [UIImage imageNamed:imageName];
        [self addSubview:backgroundImage];
    }
    return self;
}

@end
