//
//  SubscriptionModel.m
//  PsychologistIOS
//
//  Created by Viktor on 07.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "SubscriptionModel.h"

@implementation SubscriptionModel

+ (NSMutableArray *) setArraySubscription
{
    NSMutableArray * arrayJury = [[NSMutableArray alloc] init];
    
    NSArray * arrayTitle = [NSArray arrayWithObjects:
                            @"Абсурбация", @"Лунное расписание", @"Полезные контакты",
                            @"Стройная я", @"Деньги", nil];
    
    NSArray * arraySubTitle = [NSArray arrayWithObjects:
                               @"Краткое, полезное описание", @"Краткое, полезное описание",
                               @"Краткое, полезное описание", @"Краткое, полезное описание", @"Краткое, полезное описание", nil];
    
    NSArray * imageJuri = [NSArray arrayWithObjects:@"image04.png", @"image02.png",
                           @"image03.png", @"image04.png", @"image05.png", nil];
    // 0 - бесплатная, 1 - платная оплаченная, 2 - платная закончилась
    NSArray * arrayTrial = [NSArray arrayWithObjects:[NSNumber numberWithInteger:1],
                            [NSNumber numberWithInteger:2], [NSNumber numberWithInteger:1],
                            [NSNumber numberWithInteger:2], [NSNumber numberWithInteger:1], nil];
    
    
    for (int i = 0; i < 5; i++) {
        
        NSDictionary * dictJury = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [arrayTitle objectAtIndex:i], @"title",
                                   [arraySubTitle objectAtIndex:i], @"subTitle",
                                   [imageJuri objectAtIndex:i], @"image",
                                   [arrayTrial objectAtIndex:i], @"trial" , nil];
        
        [arrayJury addObject:dictJury];
    }
    
    return arrayJury;
}

@end
