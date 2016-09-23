//
//  InstructionsModel.m
//  PsychologistIOS
//
//  Created by Viktor on 13.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "InstructionsModel.h"

@implementation InstructionsModel

+ (NSMutableArray *) setArrayJuri
{
    NSMutableArray * arrayJury = [[NSMutableArray alloc] init];
    
    NSArray * arrayTitle = [NSArray arrayWithObjects:
                            @"АВТОРИЗАЦИЯ", @"РЕГИСТРАЦИЯ", @"РАЗДЕЛЫ",
                            @"ЗАКЛАДКИ", @"О КСЕНИИ", @"ВЕБИНАРЫ",  @"ЛИЧНЫЙ КАБИНЕТ", nil];
    
    
    for (int i = 0; i < 7; i++) {
        
        NSDictionary * dictJury = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [arrayTitle objectAtIndex:i], @"title", nil];
        
        [arrayJury addObject:dictJury];
    }
    
    return arrayJury;
}


@end
