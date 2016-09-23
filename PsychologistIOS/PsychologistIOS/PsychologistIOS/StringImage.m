//
//  StringImage.m
//  PsychologistIOS
//
//  Created by Viktor on 03.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "StringImage.h"

@implementation StringImage

+ (NSString*) createStringImageURLWithString: (NSString*) string
{
    NSString * stringImage = [NSString stringWithFormat:@"http://psy.kivilab.ru%@", string];    
    return stringImage;
}

@end
