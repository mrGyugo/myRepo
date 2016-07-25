//
//  Human.h
//  ArrayHome
//
//  Created by Виктор Мишустин on 29.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//


//половая принадлежность YES - Мужчина, NO - Женьщина

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Human : NSObject

@property (strong, nonatomic) NSString * nameHuman;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat weight;
@property (assign, nonatomic) BOOL sex;

- (void) movement;

//Метод инициализации для прописываняи всех свойств объекта
- (instancetype)initWithName: (NSString*) name andHeight: (CGFloat) height
                   andWeight: (CGFloat) weight andSex: (BOOL) sex;


@end
