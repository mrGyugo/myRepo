//
//  DictaphoneView.m
//  PsychologistIOS
//
//  Created by Viktor on 09.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "DictaphoneView.h"

@implementation DictaphoneView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, view.frame.size.height, view.frame.size.width, 150);
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

@end
