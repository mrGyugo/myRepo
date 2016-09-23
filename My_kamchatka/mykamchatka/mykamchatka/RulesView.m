//
//  RulesView.m
//  mykamchatka
//
//  Created by Viktor on 15.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "RulesView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "CustomButton.h"

@interface RulesView () <UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray * viewsArray;

@end

@implementation RulesView
{
    UIScrollView * mainScrolView;
    CGFloat floatSizeScroll;
    CGFloat floatSize;
}

- (instancetype)initWithView: (UIView*) view
                andArrayName: (NSArray*) arrayName
                andArrayData: (NSArray*) arrayData
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        floatSizeScroll = 0;
        //Инициализация массива-----------------------------------------------------------
        self.viewsArray = [[NSMutableArray alloc] init];
        
        //Массив имен---------------------------------------------------------------------
        NSArray * nameArray = arrayName;
        
        //Массив данных-------------------------------------------------------------------
        NSArray * nameData = arrayData;
        
        //Создаем фон из двух частей фонофого затемнения и изображения--------------------
        UIView * secondView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        secondView.backgroundColor = [UIColor colorWithHexString:@"eceff3"];
        [self addSubview:secondView];
        UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        mainImageView.image = [UIImage imageNamed:@"fonRules.png"];
        mainImageView.alpha = 0.4f;
        [secondView addSubview:mainImageView];
        
        //Создаем рабочий скрол вью-------------------------------------------------------
        mainScrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mainImageView.frame.size.width, mainImageView.frame.size.height)];
        mainScrolView.delegate = self;
        [self addSubview:mainScrolView];
        
        for (int i = 0; i < 8; i++) {
            
            //Основной фон----------
            UIView * viewHead = [[UIView alloc] initWithFrame:CGRectMake(40, 100 + 60 * i, self.frame.size.width - 80, 40)];
            if (isiPhone5) {
                viewHead.frame = CGRectMake(40, 40 + 40 * i, self.frame.size.width - 80, 30);
            }
            viewHead.backgroundColor = [UIColor colorWithHexString:@"4f7694"];
            viewHead.layer.cornerRadius = 5.f;
            viewHead.tag = 20 + i;
            [mainScrolView addSubview:viewHead];
            
            //Текст заголовка---------
            UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, viewHead.frame.size.width - 80, 40)];
            labelTitle.text = [nameArray objectAtIndex:i];
            labelTitle.textColor = [UIColor whiteColor];
            labelTitle.font = [UIFont fontWithName:FONTREGULAR size:16];
            if (isiPhone5) {
                labelTitle.font = [UIFont fontWithName:FONTREGULAR size:12];
                labelTitle.frame = CGRectMake(20, 0, viewHead.frame.size.width - 80, 30);
            }
            [viewHead addSubview:labelTitle];
            
            //Кнопка раскрытия темы----
            CustomButton * buttonConfirm = [CustomButton buttonWithType:UIButtonTypeCustom];
            buttonConfirm.frame = CGRectMake(viewHead.frame.size.width - 60, 5, 30, 30);
            if (isiPhone5) {
                buttonConfirm.frame = CGRectMake(viewHead.frame.size.width - 40, 5, 20, 20);
            }
            UIImage * buttonConfirmImage = [UIImage imageNamed:@"buttonConfirm.png"];
            [buttonConfirm setImage:buttonConfirmImage forState:UIControlStateNormal];
            buttonConfirm.tag = i;
            buttonConfirm.change = YES;
            [buttonConfirm addTarget:self action:@selector(buttonConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
            [viewHead addSubview:buttonConfirm];
            
            //Раскрывающейся лейбл------
            UIView * hidenView = [[UIView alloc] initWithFrame:CGRectMake(40, viewHead.frame.origin.y + viewHead.frame.size.height + 5, self.frame.size.width - 80, 0)];
            hidenView.backgroundColor = [UIColor colorWithHexString:@"4f7694"];
            hidenView.tag = 10 + i;
            [mainScrolView addSubview: hidenView];
            
            UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, hidenView.frame.size.width - 40, 0)];
            labelData.numberOfLines = 0;
            labelData.text = [nameData objectAtIndex:i];
            labelData.tag = 100 + i;
            labelData.textColor = [UIColor whiteColor];
            labelData.font = [UIFont fontWithName:FONTLITE size:16];
            if (isiPhone5) {
                labelData.font = [UIFont fontWithName:FONTLITE size:10];
                labelData.frame = CGRectMake(20, 10, hidenView.frame.size.width - 40, 0);
            }
            labelData.clipsToBounds=YES;
//            [labelData sizeToFit];
            [hidenView addSubview:labelData];
            [self.viewsArray addObject:viewHead];
            [self.viewsArray addObject:hidenView];
        }
    }
    return self;
}

#pragma mark - Buttons Methods

//Действие кнопок заголовков-----------------
- (void) buttonConfirmAction: (CustomButton*) button
{
    
    for (int i = 0; i < 8; i++) {
        if (button.tag == i) {
            UIView * hidenViewChange = (UIView*)[self viewWithTag:10 + i];
            UILabel * labelData = (UILabel *)[self viewWithTag:100+i];
            
            //Размер поля максимальное
            CGRect textRectMax = [labelData.text boundingRectWithSize:CGSizeMake(hidenViewChange.frame.size.width - 40, MAXFLOAT)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[UIFont fontWithName:FONTLITE size:16]}
                                                 context:nil];
            
            //Размер поля минимальное
            CGRect textRectMin = [labelData.text boundingRectWithSize:CGSizeMake(hidenViewChange.frame.size.width - 40, 0)
                                                              options:NSStringDrawingTruncatesLastVisibleLine
                                                           attributes:@{NSFontAttributeName:[UIFont fontWithName:FONTLITE size:16]}
                                                              context:nil];
            
            if (isiPhone5) {
                //Размер поля максимальное
                textRectMax = [labelData.text boundingRectWithSize:CGSizeMake(hidenViewChange.frame.size.width - 40, MAXFLOAT)
                                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                                               attributes:@{NSFontAttributeName:[UIFont fontWithName:FONTLITE size:10]}
                                                                  context:nil];
                
                //Размер поля минимальное
                textRectMin = [labelData.text boundingRectWithSize:CGSizeMake(hidenViewChange.frame.size.width - 40, 0)
                                                                  options:NSStringDrawingTruncatesLastVisibleLine
                                                               attributes:@{NSFontAttributeName:[UIFont fontWithName:FONTLITE size:10]}
                                                                  context:nil];
            }
            
            CGSize sizeMax = textRectMax.size;
            CGSize sizeMin = textRectMin.size;
            
            if (button.change) {
            
                floatSizeScroll = floatSizeScroll + sizeMax.height+20;
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    //Движение доп лейбла----------
                    CGRect customRest = hidenViewChange.frame;
                    CGRect myLabelFrame = [labelData frame];
                    //Изменения высоты
                    myLabelFrame.size.height = sizeMax.height;
                    //Новая высата view
                    customRest.size.height = customRest.size.height + sizeMax.height+20;
                    //Установка новой высоты view
                    hidenViewChange.frame = customRest;
                    [labelData setFrame:myLabelFrame];
                    
                    //Вращение кнопки-------------
                    [button setTransform:CGAffineTransformRotate(button.transform, 4.7)];
                    for (NSInteger j = (button.tag + 1) * 2; j < self.viewsArray.count; j++) {
                        UIView * testView = [self.viewsArray objectAtIndex:j];
                        CGRect rectMove = testView.frame;
                        rectMove.origin.y += sizeMax.height+20;
                        testView.frame = rectMove;
                    }
                }completion:^(BOOL finished){
                    if (finished) {
                        mainScrolView.contentSize = CGSizeMake(0, mainScrolView.frame.size.height + floatSizeScroll);
                    }
                }];
                button.change = NO;
            } else {
              
                floatSizeScroll = floatSizeScroll - sizeMax.height-20;
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    //Движение доп лейбла-----------
                    CGRect customRest2 = hidenViewChange.frame;
                    customRest2.size.height = customRest2.size.height - sizeMax.height-20;
                    hidenViewChange.frame = customRest2;
                    CGRect myLabelFrame = [labelData frame];
                    myLabelFrame.size.height = 0;
                    [labelData setFrame:myLabelFrame];
                    
                    //Вращение кнопки-------------
                    [button setTransform:CGAffineTransformRotate(button.transform, -4.7)];
                    for (NSInteger j = (button.tag + 1) * 2; j < self.viewsArray.count; j++) {
                        UIView * testView = [self.viewsArray objectAtIndex:j];
                        CGRect rectMove = testView.frame;
                        rectMove.origin.y -= sizeMax.height+20;
                        testView.frame = rectMove;
                    }
                }completion:^(BOOL finished){
                    if (finished) {
                        [UIView animateWithDuration:0.3 animations:^{
                                                    mainScrolView.contentSize = CGSizeMake(0, mainScrolView.frame.size.height + floatSizeScroll);
                        }];

                    }
                }];
                button.change = YES;
            }
        }
    }
}

@end
