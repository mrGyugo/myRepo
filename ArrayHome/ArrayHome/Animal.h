//
//  Animal.h
//  ArrayHome
//
//  Created by Виктор Мишустин on 30.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Animal : NSObject

@property (strong, nonatomic) NSString * nickname;
@property (assign, nonatomic) CGFloat longHorns;

- (void) movement;

//Кастомный метод инициализации для упращения создания объекта

- (instancetype)initWithNickname: (NSString*) nickname andLongHorns: (CGFloat) longHorns;

@end
