//
//  TranslationCountry.h
//  MapOfEurope
//
//  Created by Виктор Мишустин on 09.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//


//Класс переводит название страны с английского на русский

#import <Foundation/Foundation.h>

@interface TranslationCountry : NSObject

+ (NSString*) translationCountryWithNameCountry: (NSString*) nameCountry;

@end
