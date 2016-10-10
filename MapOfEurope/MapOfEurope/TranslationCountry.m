//
//  TranslationCountry.m
//  MapOfEurope
//
//  Created by Виктор Мишустин on 09.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//



#import "TranslationCountry.h"

@implementation TranslationCountry

+ (NSString*) translationCountryWithNameCountry: (NSString*) nameCountry {
    
    NSArray * arrayCountriesEurope = [NSArray arrayWithObjects:
                                      @"Russia", @"Albania", @"Armenia", @"Austria", @"Azerbaijan",
                                      @"Belarus", @"Belgium", @"Bosnia and Herzegovina", @"Bulgaria", @"Croatia",
                                      @"Cyprus", @"Czech Republic", @"Denmark", @"Estonia", @"Finland",
                                      @"France", @"Georgia", @"Germany", @"Greece", @"Hungary",
                                      @"Iceland", @"Ireland", @"Italy", @"Kazakhstan", @"Kosovo",
                                      @"Latvia", @"Lithuania", @"Luxembourg", @"Macedonia",
                                      @"Malta", @"Moldova", @"Montenegro", @"Netherlands",
                                      @"Norway", @"Poland", @"Portugal", @"Romania",
                                      @"Republic of Serbia", @"Slovakia", @"Slovenia", @"Spain",
                                      @"Sweden", @"Switzerland", @"Turkey", @"Ukraine",
                                      @"United Kingdom", nil];
    NSArray * arrayCountriesEuropeRus = [NSArray arrayWithObjects:
                                      @"в России", @"в Албании", @"в Армении", @"в Австрии", @"в Азербайджане",
                                      @"в Белорусии", @"в Бельгии", @"в Боснии", @"в Болгарии", @"в Хорватии",
                                      @"на Кипре", @"в Чехии", @"в Дании", @"в Эстонии", @"в Финляндии",
                                      @"во Франции", @"в Грузии", @"в Германии", @"в Греции", @"в Венгии",
                                      @"в Исландии", @"в Ирландии", @"в Италии", @"в Казахстане", @"в Косово",
                                      @"в Латвии", @"в Литве", @"в Люксенбурге", @"в Македонии",
                                      @"на Мальте", @"в Молдове", @"в Черногории", @"в Нидерландах",
                                      @"в Норвегии", @"в Польше", @"в Португалии", @"в Румынии",
                                      @"в Сербии", @"в Словакии", @"в Словении", @"в Испании",
                                      @"в Швеции", @"в Швейцарии", @"в Турции", @"на Украине",
                                      @"в Англии", nil];
    NSString * rusName;
    for (int i = 0; i < arrayCountriesEurope.count; i++) {
        if ([nameCountry isEqualToString:[arrayCountriesEurope objectAtIndex:i]]) {
            rusName = [arrayCountriesEuropeRus objectAtIndex:i];
        }
    }
    
    
    return rusName;
    

    
}


@end
