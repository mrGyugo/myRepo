//
//  CatalogDetailView.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 18/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogDetailView.h"
#import "ScrollViewImage.h"
#import "Macros.h"

@interface CatalogDetailView ()

@end

@implementation CatalogDetailView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        NSInteger countLineForScrollView;
        if (isiPhone6 || isiPhone5 || isiPhone4s) {
            countLineForScrollView = 2;
        } else {
            countLineForScrollView = 3;
        }
        ScrollViewImage * mainScrollView = [[ScrollViewImage alloc] initScrollCatalogWithView:self
                                                                                 andArrayDate:[self arrayData]
                                                                                     maxCount:countLineForScrollView
                                                                              andButtonActive:YES];
        [self addSubview:mainScrollView];
    }
    return self;
}

//Тестовый массив для отображения каталога
- (NSMutableArray*) arrayData
{
    NSMutableArray * arrayData = [NSMutableArray new];
    NSArray * arrayName = [NSArray arrayWithObjects:
                           @"Мясные", @"С картошкой", @"С капустой",
                           @"С сыром", @"Рыбные", @"С фасолью",
                           @"С курицей", @"Тыквенные", @"Сладкие", nil];
    NSArray * arrayImagesName = [NSArray arrayWithObjects:
                                 @"meat.png", @"withPotato.png", @"cabbage.png",
                                 @"withCheese.png", @"fishery.png", @"withBeans.png",
                                 @"withChicken.png", @"pumpkin.png", @"sweet.png", nil];
    for (int i = 0; i < arrayName.count; i++) {
        NSDictionary * dictDate = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [arrayName objectAtIndex:i], @"name",
                                   [arrayImagesName objectAtIndex:i], @"imageName", nil];
        [arrayData addObject:dictDate];
    }
    
    return arrayData;
}



@end
