//
//  OpenSubjectModel.m
//  PsychologistIOS
//
//  Created by Viktor on 06.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "OpenSubjectModel.h"

@implementation OpenSubjectModel

+ (NSMutableArray *) setArrayChat
{
    NSMutableArray * arrayJury = [[NSMutableArray alloc] init];
    
    NSArray * arrayUsers = [NSArray arrayWithObjects:
                            @"Пользователь 1", @"Пользователь 2", @"Пользователь 1",
                            @"Пользователь 2", @"Пользователь 1", nil];
    
    NSArray * arrayMessage = [NSArray arrayWithObjects:
                               @"Привет", @"Привет, хороший вебинар",
                               @"Отлично", @"А тебе самой как ?", @"Понравилось))  Но я не нашла ответы по своей проблеме. Нужно поискать в других категориях.", nil];
    
    
    NSArray * arrayData = [NSArray arrayWithObjects:@"1 час назад", @"2 часа назад",
                           @"вчера", @"вчера", @"вчера", nil];
    
    NSArray * arrayType = [NSArray arrayWithObjects:@"1", @"1", @"1", @"1", @"1", nil];
    
    
    for (int i = 0; i < 5; i++) {
        
        NSDictionary * dictJury = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [arrayUsers objectAtIndex:i], @"Users",
                                   [arrayMessage objectAtIndex:i], @"Message",
                                   [arrayData objectAtIndex:i], @"Data",
                                   [arrayType objectAtIndex:i], @"Type", nil];
        
        [arrayJury addObject:dictJury];
    }
    
    return arrayJury;
}

@end
