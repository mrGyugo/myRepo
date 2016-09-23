//
//  CustomCellView.h
//  FlowersOnline
//
//  Created by Viktor on 30.04.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

//Создание вью элементов для катоной ячейки------

#import <UIKit/UIKit.h>

@interface CustomCellView : UIView

//Создание вью элементов для основных ячеек---------
- (UIView*) customCellWithTint: (NSString*) tint
                      andImage: (NSString*) image
                       andView: (UIView*) view;
//Создание вью элементов ячейки выйти--------------
- (UIView*) customCellQuitWithView: (UIView*) view;

@end
