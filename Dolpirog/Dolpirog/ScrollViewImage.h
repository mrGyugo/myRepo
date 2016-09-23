//
//  ScrollViewImage.h
//  Dolpirog
//
//  Created by Виктор Мишустин on 18/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewImage : UIView


//Скролл вью для создания каталога
- (instancetype)initScrollCatalogWithView: (UIView*) view   //Вью для привязки
                             andArrayDate: (NSArray*) arrayDate //Массив данных каталога (обязательно изображение и текст заголовка)
                                 maxCount: (NSInteger) maxCount //Колличество стобцов
                          andButtonActive: (BOOL) buttonActive; //Активые ячейки или нет

@end
