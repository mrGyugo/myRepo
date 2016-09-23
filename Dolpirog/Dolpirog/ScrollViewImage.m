//
//  ScrollViewImage.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 18/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ScrollViewImage.h"
#import "Macros.h"
#import "UIColor+HexColor.h"
#import "SingleTone.h"


@interface ScrollViewImage ()

@property (strong, nonatomic) UIScrollView * mainScrollView;
@property (strong, nonnull) NSArray * mainArray;

@end

@implementation ScrollViewImage

- (instancetype)initScrollCatalogWithView: (UIView*) view
                             andArrayDate: (NSArray*) arrayDate
                                 maxCount: (NSInteger) maxCount
                          andButtonActive: (BOOL) buttonActive
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 54, view.frame.size.width, view.frame.size.height - 54);
        
        NSInteger step = 0;
        NSInteger lineCount = 0;
        _mainArray = arrayDate;
        
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 30, self.frame.size.width - 60, self.frame.size.height - 30)];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_mainScrollView];
        
        for (int i = 0; i < arrayDate.count; i++) {
            //Достаем библиотеку из каждой ячейки
            NSDictionary * dictMain = [arrayDate objectAtIndex:i];
            
            //Загружаем фото---------------------------------------------
            UIButton * buttonTakeCake = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonTakeCake.frame = CGRectMake
            ((5 + _mainScrollView.frame.size.width / maxCount) * step,
             ((_mainScrollView.frame.size.width / maxCount) + 30) * lineCount,
             _mainScrollView.frame.size.width / maxCount - 10,
             _mainScrollView.frame.size.width / maxCount - 10);
            UIImage * buttonImage = [UIImage imageNamed:[dictMain objectForKey:@"imageName"]];
            [buttonTakeCake setImage:buttonImage forState:UIControlStateNormal];
            buttonTakeCake.tag = i;
            if (!buttonActive) {
                buttonTakeCake.userInteractionEnabled = NO;
            }
            [buttonTakeCake addTarget:self action:@selector(buttonTakeCakeAction:) forControlEvents:UIControlEventTouchUpInside];
            [_mainScrollView addSubview:buttonTakeCake];

            
            //Загружаем наименование--------------------------------------
            UILabel * tintLabel = [[UILabel alloc] initWithFrame:CGRectMake((5 + _mainScrollView.frame.size.width / maxCount) * step,
                                                                            (((_mainScrollView.frame.size.width / maxCount) + 30) * lineCount) + _mainScrollView.frame.size.width / maxCount - 10,
                                                                            _mainScrollView.frame.size.width / maxCount - 10, 20)];
            tintLabel.text = [dictMain objectForKey:@"name"];
            tintLabel.textColor = [UIColor colorWithHexString:COLORTEXTORANGE];
            tintLabel.font = [UIFont fontWithName:FONTREGULAR size:15];
            tintLabel.textAlignment = NSTextAlignmentCenter;
            [_mainScrollView addSubview:tintLabel];
            
            //Создание табличного варианта
            step += 1;
            if (step >= maxCount) {
                step = 0;
                lineCount += 1;
                

            }
            
            _mainScrollView.contentSize = CGSizeMake(0, lineCount * ((_mainScrollView.frame.size.width / maxCount) + 30) + 160);
            
        }
    }
    return self;
}

- (void) buttonTakeCakeAction: (UIButton*) button
{
    for (int i = 0; i < _mainArray.count; i++) {
        if (button.tag == i) {
            NSDictionary* mainDict = [_mainArray objectAtIndex:i];
            [[SingleTone sharedManager] setDictOrder:mainDict];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SCROLL_VIEW_IMAGE_PUSH_ORDER_CONTROLLER object:nil];
        }
    }
}

@end
