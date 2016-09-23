//
//  JuryModel.m
//  mykamchatka
//
//  Created by Viktor on 18.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "JuryModel.h"

@implementation JuryModel

- (NSMutableArray *) setArrayJuri
{
    NSMutableArray * arrayJury = [[NSMutableArray alloc] init];
    
    NSArray * arrayTitle = [NSArray arrayWithObjects:
                            @"Яровая", @"Говорухин", @"Фетисов",
                            @"Фадеев", @"Горшков", @"Шпиленок", nil];
    
    NSArray * arraySubTitle = [NSArray arrayWithObjects:
                               @"Ирина Анатольевна", @"Станислав Сергеевич",
                               @"Вечеслав Александрович", @"Михаил Алексеевич", @"Сергей Владимирович",
                               @"Игорь Петрович", nil];
    
    NSArray * textJuriArray = [NSArray arrayWithObjects:
                               @"Заслуженный юрист РФ, депутат Государственной Думы от Камчатского края, председатель комитета Государственной Думы по безопасности и противодействию коррупции",
                               
                               @"Советский и российский кинорежиссёр, сценарист, актёр, народный артист Российской Федерации. Депутат Государственной думы, председатель комитета Государственной думы по культуре. Сопредседатель центрального штаба Общероссийского народного фронта",
                               
                               @"Советский и российский хоккеист, заслуженный мастер спорта СССР, заслуженный тренер России. Председатель правления Российской любительской хоккейной лиги",
                               
                               @"Директор департамента маркетинговых коммуникаций ОАО «Аэрофлот - российские авиалинии»",
                               
                               @"Российский фотограф дикой природы. Учредитель Российского Союза фотографов дикой природы, автор многочисленных фотоальбомов, в том числе «Камчатская одиссея», «Медведь», «Исчезающий мир Камчатки», «След кошки. Леопард»,«Русская Арктика. Остров Врангеля»",
                               
                               @"Фотограф-натуралист, снимает дикую природу и диких животных. Основатель и первый директор заповедника «Брянский лес». Автор фотокниг о дикой природе. Член Международной Лиги природоохранных фотографов.", nil];
    
    NSArray * imageJuri = [NSArray arrayWithObjects:@"yarovaya.png", @"govoryhin.png", @"fetisov.png", @"fandeev.png", @"gorshkov.png", @"shpilyonok.png", nil];
    
    
    for (int i = 0; i < 6; i++) {
        
        NSDictionary * dictJury = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [arrayTitle objectAtIndex:i], @"title",
                                   [arraySubTitle objectAtIndex:i], @"subTitle",
                                   [textJuriArray objectAtIndex:i], @"text",
                                   [imageJuri objectAtIndex:i], @"image", nil];
        
        [arrayJury addObject:dictJury];
    }
    
    return arrayJury;
}

@end
