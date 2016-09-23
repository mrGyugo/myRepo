//
//  DeliveryView.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 19/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "DeliveryView.h"
#import "CustomLabels.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "CustomView.h"

@implementation DeliveryView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64);
        
        NSInteger sizeBigText;
        NSInteger sizeText;
        if (isiPhone4s || isiPhone5) {
            sizeBigText = 14;
            sizeText = 12;
        } else {
            sizeBigText = 16;
            sizeText = 14;
        }
        
        //Лейбл первого заголовка-------------------------------
        CustomLabels * labelTitleOne = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:30 andSizeWidht:self.frame.size.width - 40 andSizeHeight:35 andColor:COLORTEXTORANGE andText:@"Курьерская доставка по Москве и МО осуществляется нашими курьерами."];
        labelTitleOne.numberOfLines = 0;
        labelTitleOne.font = [UIFont fontWithName:FONTREGULAR size:13];
        labelTitleOne.textAlignment = NSTextAlignmentLeft;
        [self addSubview:labelTitleOne];
        
        CustomView * borderOne = [[CustomView alloc] initWithHeight:75 andView:self andColor:@"737373"];
        [self addSubview:borderOne];
        
        //Стоимость доставки-------------------------------
        CustomLabels * labelPrice = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:80 andSizeWidht:self.frame.size.width - 40 andSizeHeight:35 andColor:COLORTEXTORANGE andText:@"Стоимость доставки:"];
        labelPrice.numberOfLines = 0;
        labelPrice.font = [UIFont fontWithName:FONTREGULAR size:sizeBigText];

        labelPrice.textAlignment = NSTextAlignmentLeft;
        [self addSubview:labelPrice];
        
        //Доставка долгопрудный
        CustomLabels * labelDeliweOne = [[CustomLabels alloc] initLabelRegularWithWidht:20 andHeight:120
                                                                               andColor:@"ffffff" andText:@"Долгопрудный" andTextSize:sizeText];
        
        [self addSubview:labelDeliweOne];
        
        //Доставка долгопрудный дествие
        CustomLabels * labelDeliweOneAction = [[CustomLabels alloc] initLabelRegularWithWidht:labelDeliweOne.frame.size.width + 25 andHeight:120
                                                                               andColor:COLORTEXTORANGE andText:@"- БЕСПЛАТНО" andTextSize:sizeText];
        
        [self addSubview:labelDeliweOneAction];
        
        //Остальные при 2000 заказа
        CustomLabels * labelDeliweTwo = [[CustomLabels alloc] initLabelRegularWithWidht:20 andHeight:140
                                                                               andColor:@"ffffff" andText:@"Химки, Левобережная и Северный район г.Москвы:" andTextSize:sizeText];
        [self addSubview:labelDeliweTwo];
        
        //Остальные при 2000 заказа
        CustomLabels * labelDeliweTwoPart = [[CustomLabels alloc] initLabelRegularWithWidht:20 andHeight:160
                                                                               andColor:@"ffffff" andText:@"от 2 000 руб" andTextSize:sizeText];
        [self addSubview:labelDeliweTwoPart];
        
        CustomLabels * labelDeliweTwoPartAction = [[CustomLabels alloc] initLabelRegularWithWidht:labelDeliweTwoPart.frame.size.width + 25 andHeight:160
                                                                                     andColor:COLORTEXTORANGE andText:@"- БЕСПЛАТНО" andTextSize:sizeText];
        
        [self addSubview:labelDeliweTwoPartAction];
        
        CustomLabels * labelDeliweThree = [[CustomLabels alloc] initLabelRegularWithWidht:20 andHeight:200
                                                                               andColor:@"ffffff" andText:@"при стоимости заказа менее 2 000 руб" andTextSize:sizeText];
        [self addSubview:labelDeliweThree];
        
        CustomLabels * labelDeliweThreeAction = [[CustomLabels alloc] initLabelRegularWithWidht:labelDeliweThree.frame.size.width + 25 andHeight:200
                                                                                         andColor:COLORTEXTORANGE andText:@"- 150 руб." andTextSize:sizeText];
        
        [self addSubview:labelDeliweThreeAction];
        
        CustomView * borderTwo = [[CustomView alloc] initWithHeight:230 andView:self andColor:@"737373"];
        [self addSubview:borderTwo];
        
        //Время работы-------------------------------
        CustomLabels * labelTime = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:240 andSizeWidht:self.frame.size.width - 40 andSizeHeight:35 andColor:COLORTEXTORANGE andText:@"Время работы:"];
        labelTime.numberOfLines = 0;
        labelTime.font = [UIFont fontWithName:FONTREGULAR size:sizeBigText];
        labelTime.textAlignment = NSTextAlignmentLeft;
        [self addSubview:labelTime];
        
        CustomLabels * labelTimeOne = [[CustomLabels alloc] initLabelRegularWithWidht:20 andHeight:280
                                                                                   andColor:@"ffffff" andText:@"Доставка осуществялется" andTextSize:sizeText];
        [self addSubview:labelTimeOne];
        
        CustomLabels * labelTimeOneAction = [[CustomLabels alloc] initLabelRegularWithWidht:labelTimeOne.frame.size.width + 25 andHeight:280
                                                                                         andColor:COLORTEXTORANGE andText:@"с 10:00 до 23:00" andTextSize:sizeText];
        
        [self addSubview:labelTimeOneAction];
        
        CustomLabels * labelTimeTwo = [[CustomLabels alloc] initLabelRegularWithWidht:20 andHeight:300
                                                                             andColor:@"ffffff" andText:@"Последний заказ принимается" andTextSize:sizeText];
        [self addSubview:labelTimeTwo];
        
        CustomLabels * labelTimeTwoAction = [[CustomLabels alloc] initLabelRegularWithWidht:labelTimeTwo.frame.size.width + 25 andHeight:300
                                                                                   andColor:COLORTEXTORANGE andText:@"в 22:00" andTextSize:sizeText];
        
        [self addSubview:labelTimeTwoAction];

        
    }
    return self;
}


@end
