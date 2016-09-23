//
//  TitleClass.m
//  Sadovod
//
//  Created by Viktor on 20.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "TitleClass.h"
#import "Macros.h"

@implementation TitleClass

- (id)initWithTitle: (NSString*) title
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.font = [UIFont fontWithName:FONTBOND size:19];
        if (isiPhone5) {
            self.font = [UIFont fontWithName:FONTBOND size:15];
        } else if (isiPhone6) {
            self.font = [UIFont fontWithName:FONTBOND size:15];
        }
        self.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
        self.text = title;
        [self sizeToFit];
    }
    return self;
}


- (id)initWithLiteTitle: (NSString*) title
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.font = [UIFont fontWithName:FONTLITE size:15];
        if (isiPhone5) {
            self.font = [UIFont fontWithName:FONTLITE size:12];
        }
        self.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor blackColor];
        self.text = title;
        [self sizeToFit];
    }
    return self;
}



@end
