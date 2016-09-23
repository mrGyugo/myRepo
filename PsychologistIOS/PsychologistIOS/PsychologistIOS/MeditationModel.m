//
//  MeditationModel.m
//  PsychologistIOS
//
//  Created by Viktor on 12.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "MeditationModel.h"

@implementation MeditationModel

+ (NSMutableArray *) setArraySubject
{
    NSMutableArray * arrayJury = [[NSMutableArray alloc] init];
    
    NSArray * arrayTitle = [NSArray arrayWithObjects:
                            @"Аудио трек 1", @"Аудио трек 1", @"Аудио трек 1",
                            @"Аудио трек 1", nil];
    
    NSArray * arraySubTitle = [NSArray arrayWithObjects:
                               @"В Сосновом бору", @"В Сосновом бору",
                               @"В Сосновом бору", @"В Сосновом бору", nil];
    
    
    NSArray * arrayText = [NSArray arrayWithObjects:
                           @"Главное правило трек-медитации — гуляем в полной тишине. По маршруту делаем небольшие остановки для медитативных практик. Цель — развитие навыков доверия, внутренней тишины. В конце прогулки чаепитие в",
                           
                           @"Главное правило трек-медитации — гуляем в полной тишине. По маршруту делаем небольшие остановки для медитативных практик. Цель — развитие навыков доверия, внутренней тишины. В конце прогулки чаепитие в",
                           
                           @"Главное правило трек-медитации — гуляем в полной тишине. По маршруту делаем небольшие остановки для медитативных практик. Цель — развитие навыков доверия, внутренней тишины. В конце прогулки чаепитие в",
                           
                           @"Главное правило трек-медитации — гуляем в полной тишине. По маршруту делаем небольшие остановки для медитативных практик. Цель — развитие навыков доверия, внутренней тишины. В конце прогулки чаепитие в", nil];
    
    
    for (int i = 0; i < 4; i++) {
        
        NSDictionary * dictJury = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [arrayTitle objectAtIndex:i], @"title",
                                   [arraySubTitle objectAtIndex:i], @"subTitle",
                                   [arrayText objectAtIndex:i], @"text", nil];
        
        [arrayJury addObject:dictJury];
    }
    
    return arrayJury;
}

@end
