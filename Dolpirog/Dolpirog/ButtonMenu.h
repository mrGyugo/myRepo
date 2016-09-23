//
//  ButtonMenu.h
//  FlowersOnline
//
//  Created by Viktor on 30.04.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

//Класс включает в себя все визаульное отображение всех кнопок в приложении

#import <UIKit/UIKit.h>
#import "UIColor+HexColor.h"
#import "Macros.h"

@interface ButtonMenu : UIButton

//Кнопка корзины
+ (UIButton*) createButtonBasket;
//Кнопка меню в приложении
+ (UIButton*) createButtonMenu;
//Кнопка в регистрационных окнах
+ (UIButton*) createButtonRegistrationWithName: (NSString*) title
                                      andColor: (NSString*) color
                                     andPointY: (CGFloat) pointY
                                       andView: (UIView*) view;
//Текстовая кнопка
+ (UIButton*) createButtonTextWithName: (NSString*) name
                              andFrame: (CGRect) rect
                              fontName: (NSString*) font;

//Кнопка назад
+ (UIButton*) createButtonBack;



@end
