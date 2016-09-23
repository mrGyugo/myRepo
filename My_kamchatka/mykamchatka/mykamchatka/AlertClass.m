//
//  AlertClass.m
//  mykamchatka
//
//  Created by Viktor on 28.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "AlertClass.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "UIColor+HexColor.h"

@implementation AlertClass

+ (void) showAlertWithMessage: (NSString*) message
{
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    alert.customViewColor = [UIColor colorWithHexString:@"2f8fe7"];
    [alert showSuccess:@"Внимание" subTitle:message closeButtonTitle:@"Ок" duration:0.0f];
}

@end
