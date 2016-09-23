//
//  CustomView.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 19/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CustomView.h"
#import "UIColor+HexColor.h"

@implementation CustomView

- (instancetype)initWithHeight: (CGFloat) height
                       andView: (UIView*) view
                      andColor: (NSString*) color
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, height, view.frame.size.width, 0.5);
        self.backgroundColor = [UIColor colorWithHexString:color];
    }
    return self;
}

@end
