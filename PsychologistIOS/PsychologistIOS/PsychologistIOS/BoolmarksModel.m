//
//  BoolmarksModel.m
//  PsychologistIOS
//
//  Created by Viktor on 12.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "BoolmarksModel.h"

@implementation BoolmarksModel

+ (NSMutableArray *) setArrayJuri
{
    NSMutableArray * arrayJury = [[NSMutableArray alloc] init];
    
    NSArray * arrayTitle = [NSArray arrayWithObjects:
                            @"Медитации", @"Лунное расписание", @"Полезные контакты",
                            @"Стройная я", @"Деньги", nil];
    
    NSArray * arraySubTitle = [NSArray arrayWithObjects:
                               @"Краткое, полезное описание", @"Краткое, полезное описание",
                               @"Краткое, полезное описание", @"Краткое, полезное описание", @"Краткое, полезное описание", nil];
    
    NSArray * imageJuri = [NSArray arrayWithObjects:@"image01.png", @"image02.png",
                           @"image03.png", @"image04.png", @"image05.png", nil];
    // 0 - бесплатная, 1 - платная оплаченная, 2 - платная закончилась
    NSArray * arrayTrial = [NSArray arrayWithObjects:[NSNumber numberWithInteger:1],
                            [NSNumber numberWithInteger:0], [NSNumber numberWithInteger:1],
                            [NSNumber numberWithInteger:2], [NSNumber numberWithInteger:0], nil];
    //нотификации 0 - отсутствуют
    NSArray * arrayNotification = [NSArray arrayWithObjects:[NSNumber numberWithInteger:5],
                                   [NSNumber numberWithInteger:0], [NSNumber numberWithInteger:0],
                                   [NSNumber numberWithInteger:3], [NSNumber numberWithInteger:0], nil];
    
    
    for (int i = 0; i < 5; i++) {
        
        NSDictionary * dictJury = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [arrayTitle objectAtIndex:i], @"title",
                                   [arraySubTitle objectAtIndex:i], @"subTitle",
                                   [imageJuri objectAtIndex:i], @"image",
                                   [arrayTrial objectAtIndex:i], @"trial",
                                   [arrayNotification objectAtIndex:i], @"notification", nil];
        
        [arrayJury addObject:dictJury];
    }
    
    return arrayJury;
}

@end
