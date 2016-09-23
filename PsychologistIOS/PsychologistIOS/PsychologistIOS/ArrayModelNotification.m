//
//  ArrayModelNotification.m
//  PsychologistIOS
//
//  Created by Viktor on 16.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "ArrayModelNotification.h"

@implementation ArrayModelNotification

+ (NSMutableArray *) setArrayNotification
{
    NSMutableArray * arrayNotification = [[NSMutableArray alloc] init];
    
    NSArray * arrayName = [NSArray arrayWithObjects:
                            @"jasmin", @"Catrin", @"Oxyjen",
                            @"jasmin", @"jasmin", @"jasmin",
                            @"jasmin", @"jasmin", nil];
    
    NSArray * arrayAction = [NSArray arrayWithObjects:
                               @"добавила комментарий в раздел", @"добавила комментарий в раздел",
                               @"оплатил подписку", @"оплатила подписку на раздел",
                               @"добавила комментарий в раздел", @"добавила комментарий в раздел",
                               @"добавила комментарий в раздел", @"добавила комментарий в раздел", nil];
    
    NSArray * arraThema = [NSArray arrayWithObjects:
                           @"о пользе упражнений.", @"о пользе упражнений.",
                           @"",@"женские секреты.", @"о пользе упражнений.",
                           @"о пользе упражнений.", @"о пользе упражнений.",
                           @"о пользе упражнений.", @"о пользе упражнений.", nil];
    
    NSArray * arrayTime = [NSArray arrayWithObjects:
                           @"1 час назад", @"45 мин назад", @"2 часа назад",
                           @"5 мин назад", @"1 час назад", @"1 час назад",
                           @"1 час назад", @"1 час назад", nil];
    

    

    
    
    for (int i = 0; i < 8; i++) {
        
        NSDictionary * dictNotification = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [arrayName objectAtIndex:i], @"Name",
                                   [arrayAction objectAtIndex:i], @"Action",
                                   [arraThema objectAtIndex:i], @"Thema",
                                   [arrayTime objectAtIndex:i], @"Time", nil];
        
        [arrayNotification addObject:dictNotification];
    }
    
    return arrayNotification;
}


@end
