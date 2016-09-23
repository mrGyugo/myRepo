//
//  OrderView.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 18/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "OrderView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "StyledPageControl.h"
#import "CustomLabels.h"
#import "CustomButton.h"

typedef enum {
    smallCake,
    averageCake,
    bigCake
} TypeCake;

@interface OrderView () <UIScrollViewDelegate>
//ScrollImage---
@property (strong, nonatomic) UIScrollView * mainScrollView;
@property (strong, nonatomic) UIScrollView * scrollImages;
@property (strong, nonatomic) StyledPageControl * pageControl;
//Change objects--
@property (strong, nonatomic) UILabel * countOrdersLabel;
@property (assign, nonatomic) NSInteger countOrder; //Колличество заказа
@property (assign, nonatomic) NSInteger costOrder; //Цена заказа
@property (strong, nonatomic) CustomLabels * costLabelAction;

@property (strong, nonatomic) NSDictionary * dictCakeCount; //Колличество пирогов;
@property (assign, nonatomic) TypeCake typeCake;

@end

@implementation OrderView

- (instancetype)initWithView: (UIView*) view
                     andDate: (NSArray*) arrayDate
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64)];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_mainScrollView];
        
        _countOrder = 0;
        _costOrder = 0;
        _typeCake = averageCake;
        
        //Создаем три массива для хранения колличества весовых объектов
        NSMutableArray * smallCakeArray = [[NSMutableArray alloc] init]; //маленькие пироги
        NSMutableArray * averageCakeArray = [[NSMutableArray alloc] init]; //средние пироги
        NSMutableArray * bigCakeArray = [[NSMutableArray alloc] init]; //большие пироги
        
        _dictCakeCount = [NSDictionary dictionaryWithObjectsAndKeys:smallCakeArray, @"small", averageCakeArray, @"average", bigCakeArray, @"big", nil];
        
#pragma mark - ScrollImage
        //Скрол для пролистывания картинок--------------------------
        _scrollImages = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 30, self.frame.size.width - 60, 263)];
        if (isiPhone5 || isiPhone4s) {
            _scrollImages.frame = CGRectMake(30, 30, self.frame.size.width - 60, 217);
        }
        [_scrollImages setDelegate:self];
        [_scrollImages setPagingEnabled:YES];
        [_scrollImages setContentSize:CGSizeMake((self.frame.size.width- 60) * 3, 0)]; // задаем количество слайдов
        _scrollImages.showsHorizontalScrollIndicator = NO;
        _scrollImages.showsVerticalScrollIndicator = NO;
        [_scrollImages setBackgroundColor:[UIColor whiteColor]]; // цвет фона скролвью
        [_mainScrollView addSubview:_scrollImages];
        
        //Инициализация pageControl-------------------------------------------
        _pageControl = [[StyledPageControl alloc] init];
        _pageControl.frame = CGRectMake((self.frame.size.width / 2) - 60, _scrollImages.frame.size.height + 5, 120, 20);
        [_pageControl setPageControlStyle:PageControlStyleStrokedCircle];
        [_pageControl setNumberOfPages:3];
        [_pageControl setCurrentPage:0];
        [_pageControl setDiameter:15];
        [_pageControl setCoreSelectedColor:[UIColor colorWithHexString:@"fee682"]];
        [_pageControl setStrokeSelectedColor:[UIColor colorWithHexString:@"fee682"]];
        [_pageControl setStrokeNormalColor:[UIColor colorWithHexString:@"fee682"]];
        [_mainScrollView addSubview:_pageControl];
        
        UIImageView * view1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 60, 263)];
        if (isiPhone5 || isiPhone4s) {
            view1.frame = CGRectMake(0, 0, self.frame.size.width - 60, 217);
        }
        view1.image = [UIImage imageNamed:@"imageOrder1.png"];
        [_scrollImages addSubview:view1];
        
        UIImageView * view2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 0,
                                                                            self.frame.size.width - 60,
                                                                            263)];
        if (isiPhone5 || isiPhone4s) {
            view2.frame = CGRectMake(self.frame.size.width - 60, 0,
                                     self.frame.size.width - 60, 217);
        }
        view2.image = [UIImage imageNamed:@"imageCakeTwo.png"];
        [_scrollImages addSubview:view2];
        
        UIImageView * view3 = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 60) * 2, 0,
                                                                            self.frame.size.width - 60,
                                                                            263)];
        if (isiPhone5 || isiPhone4s) {
            view3.frame = CGRectMake((self.frame.size.width - 60) * 2, 0,
                                     self.frame.size.width - 60, 217);
        }
        view3.image = [UIImage imageNamed:@"imageCakeThree.jpg"];;
        [_scrollImages addSubview:view3];
        
#pragma mark - Other View
        //Заголовок--------------------------------------------------
        CustomLabels * labelTitle = [[CustomLabels alloc] initLabelBondWithWidht:30
                                                                       andHeight:_scrollImages.frame.origin.y + _scrollImages.frame.size.height + 10
                                                                        andColor:COLORBROWN
                                                                         andText:@"Пирог с “капустой тушеной”"
                                                                     andTextSize: 16];
        if (isiPhone5 || isiPhone4s) {
            labelTitle.font = [UIFont fontWithName:FONTBOND size:14];
        }
        [_mainScrollView addSubview:labelTitle];
        
        //Описательный текст----------------------------------------
        CustomLabels * textLabel = [[CustomLabels alloc] initLabelTableWithWidht:30
                                                                       andHeight:labelTitle.frame.origin.y + labelTitle.frame.size.height + 10
                                                                    andSizeWidht:_mainScrollView.frame.size.width - 60
                                                                   andSizeHeight:40
                                                                        andColor:@"000000"
                                                                         andText:@"Полностью раскрыть свои вкусовые качества капуста может именно в осетинском пироге. Посыпанная ароматными специями начинка пирога поразит своими вкусовыми качествами и позволит утолить голод."];
        textLabel.numberOfLines = 0;
        textLabel.font = [UIFont fontWithName:FONTREGULAR size:16];
        if (isiPhone4s || isiPhone5) {
            textLabel.frame = CGRectMake(30, labelTitle.frame.origin.y + labelTitle.frame.size.height, _mainScrollView.frame.size.width - 60, 40);
            textLabel.font = [UIFont fontWithName:FONTREGULAR size:14];
        }
        textLabel.textAlignment = NSTextAlignmentLeft;
        [textLabel sizeToFit];
        [_mainScrollView addSubview:textLabel];
        
        //Вью разделения----------------------------------------------
        UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(30, textLabel.frame.origin.y + textLabel.frame.size.height + 10, _mainScrollView.frame.size.width - 60, 0.5)];
        borderView.backgroundColor = [UIColor colorWithHexString:@"c0c0c0"];
        [_mainScrollView addSubview:borderView];
        
        //Состав заголовок------------------------------------------
        CustomLabels * labelTitleComposition = [[CustomLabels alloc] initLabelRegularWithWidht:30
                                                                       andHeight:borderView.frame.origin.y + 10
                                                                        andColor:COLORBROWN
                                                                         andText:@"Состав пирога:"
                                                                     andTextSize: 16];
        if (isiPhone5 || isiPhone4s) {
            labelTitleComposition.font = [UIFont fontWithName:FONTBOND size:14];
        }
        [_mainScrollView addSubview:labelTitleComposition];
        
        //Состав основной текст-------------------------------------
        CustomLabels * textLabelComposition = [[CustomLabels alloc] initLabelTableWithWidht:30
                                                                       andHeight:labelTitleComposition.frame.origin.y + labelTitleComposition.frame.size.height + 10
                                                                    andSizeWidht:_mainScrollView.frame.size.width - 60
                                                                   andSizeHeight:40
                                                                        andColor:@"898988"
                                                                         andText:@"Лук жаренный, Сливочное масло, Капуста, Осетинский сыр."];
        textLabelComposition.numberOfLines = 0;
        textLabelComposition.font = [UIFont fontWithName:FONTREGULAR size:16];
        if (isiPhone5 || isiPhone4s) {
            textLabelComposition.frame = CGRectMake(30, labelTitleComposition.frame.origin.y + labelTitleComposition.frame.size.height, _mainScrollView.frame.size.width - 60, 40);
            textLabelComposition.font = [UIFont fontWithName:FONTREGULAR size:14];
        }
        textLabelComposition.textAlignment = NSTextAlignmentLeft;
        [textLabelComposition sizeToFit];
        [_mainScrollView addSubview:textLabelComposition];
        
#pragma mark - Change objects
        
        //Базовый вью элемнт для управления колличеством товара----
        UIView * mainViewCountOrder = [[UIView alloc] initWithFrame:CGRectMake(30, textLabelComposition.frame.origin.y + textLabelComposition.frame.size.height + 10, 140, 35)];
        if (isiPhone6Plus) {
            mainViewCountOrder.frame = CGRectMake(30, textLabelComposition.frame.origin.y + textLabelComposition.frame.size.height + 50, 140, 35);
        } else if (isiPhone5 || isiPhone4s) {
            mainViewCountOrder.frame = CGRectMake(30, textLabelComposition.frame.origin.y + textLabelComposition.frame.size.height + 10, 100, 30);
        }
        mainViewCountOrder.layer.borderColor = [UIColor colorWithHexString:@"9c490f"].CGColor;
        mainViewCountOrder.layer.borderWidth = 2.f;
        mainViewCountOrder.layer.cornerRadius = 6;
        [_mainScrollView addSubview:mainViewCountOrder];
        
        //Вью для отображения колличества-------------------------
        UIView * viewForCount = [[UIView alloc] initWithFrame:CGRectMake(mainViewCountOrder.frame.size.width / 2 - 25, 0, 50, 35)];
        if (isiPhone4s || isiPhone5) {
            viewForCount.frame = CGRectMake(mainViewCountOrder.frame.size.width / 2 - 15, 0, 30, 30);
        }
        viewForCount.backgroundColor = [UIColor colorWithHexString:@"9c490f"];
        [mainViewCountOrder addSubview:viewForCount];
        
        //Колличество товара--------------------------------------
        _countOrdersLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
        _countOrdersLabel.text = [NSString stringWithFormat:@"%ld", (long)_countOrder];
        _countOrdersLabel.textColor = [UIColor whiteColor];
        _countOrdersLabel.textAlignment = NSTextAlignmentCenter;
        _countOrdersLabel.font = [UIFont fontWithName:FONTBOND size:16];
        if (isiPhone4s || isiPhone5) {
            _countOrdersLabel.frame = CGRectMake(0, 0, 30, 30);
            _countOrdersLabel.font = [UIFont fontWithName:FONTBOND size:14];
        }
        [viewForCount addSubview:_countOrdersLabel];
        
        //Кнопка увеличивающая колличества товара на еденицу------
        UIButton * downCountButton = [UIButton buttonWithType:UIButtonTypeSystem];
        downCountButton.frame = CGRectMake(10, 0, 30, 35);
        [downCountButton setTitle:@"-" forState:UIControlStateNormal];
        [downCountButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        downCountButton.titleLabel.font = [UIFont fontWithName:FONTBOND size:18];
        if (isiPhone4s || isiPhone5) {
            downCountButton.frame = CGRectMake(5, 0, 30, 30);
            downCountButton.titleLabel.font = [UIFont fontWithName:FONTBOND size:16];
        }
        [downCountButton addTarget:self action:@selector(downCountButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [mainViewCountOrder addSubview:downCountButton];
        
        //Кнопка уменьшения колличества товара на еденицу------
        UIButton * upCountButton = [UIButton buttonWithType:UIButtonTypeSystem];
        upCountButton.frame = CGRectMake(mainViewCountOrder.frame.size.width - 40, 0, 30, 35);
        [upCountButton setTitle:@"+" forState:UIControlStateNormal];
        [upCountButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        upCountButton.titleLabel.font = [UIFont fontWithName:FONTBOND size:18];
        if (isiPhone4s || isiPhone5) {
            upCountButton.frame = CGRectMake(mainViewCountOrder.frame.size.width - 35, 0, 30, 30);
            upCountButton.titleLabel.font = [UIFont fontWithName:FONTBOND size:16];
        }
        [upCountButton addTarget:self action:@selector(upCountButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [mainViewCountOrder addSubview:upCountButton];
        
        //Мноки выбора веса объекта----------------------------
        //Массив отображения имен------------------------------
        NSArray * arrayNames = [NSArray arrayWithObjects:@"800 гр", @"1000 гр", @"1200 гр", nil];
        
        for (int i = 0; i < 3; i ++) {
            CustomButton * buttonWeight = [CustomButton buttonWithType:UIButtonTypeCustom];
            buttonWeight.frame = CGRectMake((mainViewCountOrder.frame.size.width + 45) + 55 * i, mainViewCountOrder.frame.origin.y, 50, 35);
            buttonWeight.backgroundColor = [UIColor colorWithHexString:COLORBROWN];
            buttonWeight.layer.cornerRadius = 6.f;
            buttonWeight.tag = 10 + i;
            [buttonWeight setTitle:[arrayNames objectAtIndex:i] forState:UIControlStateNormal];
            buttonWeight.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:13];
            if (isiPhone6Plus) {
                buttonWeight.frame = CGRectMake((mainViewCountOrder.frame.size.width + 85) + 55 * i, mainViewCountOrder.frame.origin.y, 50, 35);
            } else if (isiPhone4s || isiPhone5) {
                buttonWeight.frame = CGRectMake((mainViewCountOrder.frame.size.width + 45) + 50 * i, mainViewCountOrder.frame.origin.y, 45, 30);
                buttonWeight.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:11];
            }
            buttonWeight.alpha = 0.4;
            
            if (i == 1) {
                buttonWeight.userInteractionEnabled = NO;
                buttonWeight.alpha = 1.f;
            }
            [buttonWeight addTarget:self action:@selector(buttonWeightAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            [_mainScrollView addSubview:buttonWeight];
            
        }
        
        //Стоимость------------------------------------------
        CustomLabels * costLabel = [[CustomLabels alloc] initLabelRegularWithWidht:30
                                                                         andHeight:mainViewCountOrder.frame.origin.y + mainViewCountOrder.frame.size.height + 20
                                                                          andColor:COLORBROWN
                                                                           andText:@"Стоимость:"
                                                                       andTextSize:16];
        if (isiPhone5 || isiPhone4s) {
            costLabel.font = [UIFont fontWithName:FONTREGULAR size:14];
            [costLabel sizeToFit];
        }
        
        [_mainScrollView addSubview:costLabel];
        
        //Стоимость активный---------------------------------
        _costLabelAction = [[CustomLabels alloc] initLabelBondWithWidht:costLabel.frame.size.width + 35
                                                                            andHeight:costLabel.frame.origin.y
                                                                             andColor:COLORBROWN
                                                                              andText:@"0 р"
                                                                          andTextSize:16];
        _costLabelAction.font = [UIFont fontWithName:FONTBOND size:14];
        [_costLabelAction sizeToFit];
        [_mainScrollView addSubview:_costLabelAction];
        
        //кнопка корзина------------------------------------
        UIButton * buttonBasket = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonBasket.frame = CGRectMake(mainViewCountOrder.frame.size.width + 45, costLabel.frame.origin.y - 10, 160, 35);
        buttonBasket.backgroundColor = [UIColor colorWithHexString:COLORORANGE];
        [buttonBasket setTitle:@"В корзину" forState:UIControlStateNormal];
        [buttonBasket setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonBasket.titleLabel.font = [UIFont fontWithName:FONTBOND size:18];
        buttonBasket.layer.cornerRadius = 6.f;
        if (isiPhone4s || isiPhone5) {
            buttonBasket.frame = CGRectMake(mainViewCountOrder.frame.size.width + 65, costLabel.frame.origin.y - 10, 125, 30);
            buttonBasket.titleLabel.font = [UIFont fontWithName:FONTBOND size:16];
            buttonBasket.layer.cornerRadius = 5.f;
        } else if (isiPhone6Plus) {
            buttonBasket.frame = CGRectMake(mainViewCountOrder.frame.size.width + 85, costLabel.frame.origin.y - 10, 160, 35);
        }
        [buttonBasket addTarget:self action:@selector(buttonBasketAction) forControlEvents:UIControlEventTouchUpInside];
        [_mainScrollView addSubview:buttonBasket];
        
        _mainScrollView.contentSize = CGSizeMake(0, buttonBasket.frame.origin.y + 35);
        
        
        

    }
    return self;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        if ([scrollView isEqual:_scrollImages]) {
            CGFloat pageWidth = CGRectGetWidth(self.bounds);
            CGFloat pageFraction = _scrollImages.contentOffset.x / pageWidth;
            _pageControl.currentPage = roundf(pageFraction);
        }
}

#pragma mark - Action Methods
//Повышает колличество товара на еденицу
- (void) upCountButtonAction
{
    if (_countOrder < 99) {
        _countOrder += 1;
        _countOrdersLabel.text = [NSString stringWithFormat:@"%ld", (long)_countOrder];
        
        if (_typeCake == smallCake) {
            NSMutableArray * mArray = [_dictCakeCount objectForKey:@"small"];
            [mArray addObject:[NSNumber numberWithInteger:400]];
            _costOrder += 400;
            
        } else if (_typeCake == averageCake) {
            NSMutableArray * mArray = [_dictCakeCount objectForKey:@"average"];
            [mArray addObject:[NSNumber numberWithInteger:550]];
            _costOrder += 550;

        } else if (_typeCake == bigCake) {
            NSMutableArray * mArray = [_dictCakeCount objectForKey:@"big"];
            [mArray addObject:[NSNumber numberWithInteger:600]];
            _costOrder += 600;
        }
         _costLabelAction.text = [NSString stringWithFormat:@"%ld р", (long)_costOrder];
        [_costLabelAction sizeToFit];
    }
}
//Уменьшает колличество товара на еденицу
- (void) downCountButtonAction
{
    if (_countOrder > 0) {
        if (_typeCake == smallCake) {
            NSMutableArray * mArray = [_dictCakeCount objectForKey:@"small"];
            if (mArray.count > 0) {
                [mArray removeLastObject];
                _countOrder -= 1;
                _costOrder -= 400;
                _countOrdersLabel.text = [NSString stringWithFormat:@"%ld", (long)_countOrder];
                _costLabelAction.text = [NSString stringWithFormat:@"%ld р", (long)_costOrder];
                [_costLabelAction sizeToFit];
                
            }
        } else if (_typeCake == averageCake) {
            NSMutableArray * mArray = [_dictCakeCount objectForKey:@"average"];
            if (mArray.count > 0) {
                [mArray removeLastObject];
                _countOrder -= 1;
                _costOrder -= 550;
                _countOrdersLabel.text = [NSString stringWithFormat:@"%ld", (long)_countOrder];
                _costLabelAction.text = [NSString stringWithFormat:@"%ld р", (long)_costOrder];
                [_costLabelAction sizeToFit];
            }
        } else if (_typeCake == bigCake) {
            NSMutableArray * mArray = [_dictCakeCount objectForKey:@"big"];
            if (mArray.count > 0) {
                [mArray removeLastObject];
                _countOrder -= 1;
                _costOrder -= 600;
                _countOrdersLabel.text = [NSString stringWithFormat:@"%ld", (long)_countOrder];
                _costLabelAction.text = [NSString stringWithFormat:@"%ld р", (long)_costOrder];
                [_costLabelAction sizeToFit];
            }
            
        }

    }
}
//Выбор веса товара-----------------------
- (void) buttonWeightAction: (CustomButton*) button
{
    for (int i = 0; i < 3; i++) {
        UIButton * otherButton = (UIButton*)[self viewWithTag:10 + i];
        if (button.tag == 10 + i) {
            button.alpha = 1;
            button.userInteractionEnabled = NO;
            if (i == 0) {
                _typeCake = smallCake;
            } else if (i == 1) {
                _typeCake = averageCake;
            } else if (i == 2) {
                _typeCake = bigCake;
            }
            
        } else {
            otherButton.alpha = 0.4f;
            otherButton.userInteractionEnabled = YES;
        }
    }
    
}

- (void) buttonBasketAction
{
    NSLog(@"Добавить товар в корзину");
}

@end
