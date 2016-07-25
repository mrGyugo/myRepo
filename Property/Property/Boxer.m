//
//  Boxer.m
//  Property
//
//  Created by Виктор Мишустин on 29.06.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "Boxer.h"

//создаем метод категории---------------------------------
//инкапсулируем проперти----------------------------------
//желательно инициализация--------------------------------
@interface Boxer ()

@property (assign, nonatomic) NSInteger nameCount;

@end

@implementation Boxer
//Важно для того что бы задать одновлеменно сеттер и геттер надо сдлеать синтесайз
@synthesize name = _name;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nameCount = 0;
    }
    return self;
}

- (void) setName:(NSString *)name
{
    NSLog(@"Проверка сеттера");
    _name = name;
}

- (NSString*) name
{
    return _name;
}

- (NSInteger) age
{
    
    NSLog(@"геттер");
    
    
    return _age;
}


- (NSInteger) howOldAreYou
{
    return self.age;
}

@end
