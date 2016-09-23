//
//  AlertClass.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "AlertClass.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "UIColor+HexColor.h"


@implementation AlertClass
//Создание AlertView---------------------------------------------------------

+ (void)showAlertViewWithMessage:(NSString*)message
{
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert showSuccess:@"Внимание" subTitle:message closeButtonTitle:@"Ок" duration:0.0f];
}


@end
