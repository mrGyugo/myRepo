//
//  ButtonMenu.m
//  FlowersOnline
//
//  Created by Viktor on 30.04.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "ButtonMenu.h"

@implementation ButtonMenu

+ (UIButton*) createButtonMenu
{
    UIImage *imageBarButton = [UIImage imageNamed:@"IconButtonMenu.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 17, 14);
    CGRect rect = button.frame;
    rect.origin.y += 16;
    button.frame = rect;
    [button setImage:imageBarButton forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton*) createButtonBasket
{
    UIImage *imageBarButton = [UIImage imageNamed:@"iconBasket.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 20, 16);
    CGRect rect = button.frame;
    rect.origin.y += 16;
    button.frame = rect;
    [button setImage:imageBarButton forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton*) createButtonBack
{
    UIImage *imageBarButton = [UIImage imageNamed:@"arrowBackImage.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 20, 20);
    CGRect rect = button.frame;
    rect.origin.y += 16;
    button.frame = rect;
    [button setImage:imageBarButton forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton*) createButtonRegistrationWithName: (NSString*) title
                                andColor: (NSString*) color
                               andPointY: (CGFloat) pointY
                                 andView: (UIView*) view
{
    UIButton * buttonRegistration = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonRegistration.frame = CGRectMake(20, pointY, view.frame.size.width - 40, 60);
//    buttonRegistration.layer.borderColor = [UIColor colorWithHexString:COLORBROWN].CGColor;
//    buttonRegistration.layer.borderWidth = 1.f;
    buttonRegistration.layer.cornerRadius = 30;
    buttonRegistration.backgroundColor = [[UIColor colorWithHexString:color] colorWithAlphaComponent:0.5];
    [buttonRegistration setTitle:title forState:UIControlStateNormal];
    [buttonRegistration setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonRegistration.titleLabel.font = [UIFont fontWithName:FONTBOND size:17];
    if (isiPhone5 || isiPhone4s) {
        buttonRegistration.frame = CGRectMake(20, pointY, view.frame.size.width - 40, 50);
        buttonRegistration.layer.cornerRadius = 25;
        buttonRegistration.titleLabel.font = [UIFont fontWithName:FONTBOND size:15];
    }
    
    return buttonRegistration;
}

+ (UIButton*) createButtonTextWithName: (NSString*) name
                              andFrame: (CGRect) rect
                              fontName: (NSString*) font
{
    UIButton * textButton = [UIButton buttonWithType:UIButtonTypeSystem];
    textButton.frame = rect;
    [textButton setTitle:name forState:UIControlStateNormal];
    [textButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    textButton.titleLabel.font = [UIFont fontWithName:font size:13];
    
    return textButton;
}

@end
