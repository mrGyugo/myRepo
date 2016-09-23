//
//  CatalogModel.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 05/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogModel.h"

@implementation CatalogModel

+ (NSMutableArray*) arrayData
{
    NSMutableArray * arrayData = [NSMutableArray new];
    NSArray * arrayName = [NSArray arrayWithObjects:
                           @"ОСЕТИНСКИЕ ПИРОГИ", @"ШАШЛЫК", @"ГАРНИР",
                           @"САЛАТЫ", @"СОУСЫ", @"НАПИТКИ", nil];
    NSArray * arrayImagesName = [NSArray arrayWithObjects:
                                 @"imagePie.png", @"imageBarbecue.png", @"imageGarnish.png",
                                 @"imageSalad.png", @"imageSauce.png", @"imageDrink.png",nil];
    for (int i = 0; i < arrayName.count; i++) {
        NSDictionary * dictDate = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [arrayName objectAtIndex:i], @"name",
                                   [arrayImagesName objectAtIndex:i], @"imageName", nil];
        [arrayData addObject:dictDate];
    }
    
    return arrayData;
}

@end
