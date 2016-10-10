//
//  AlertView.m
//  MapOfEurope
//
//  Created by Виктор Мишустин on 09.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "AlertView.h"
#import <SCLAlertView.h>
#import "TranslationCountry.h"

@implementation AlertView

+ (void) showAlertViewWithCountry: (NSString*) country andColor: (UIColor*) color
{

    
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    alert.customViewColor = color;
    
    NSString * rusNameCountry = [TranslationCountry translationCountryWithNameCountry:country];
    
    [alert showNotice:@"Добро пожаловать"
                  subTitle:[NSString stringWithFormat:@"Мы рады приветствовать вас %@", rusNameCountry] closeButtonTitle:@"Ок"
                  duration:0.0f];

}



@end
