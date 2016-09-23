//
//  SubCategoryView.m
//  PsychologistIOS
//
//  Created by Viktor on 04.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "SubCategoryView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SingleTone.h"
#import "StringImage.h"
#import "ViewSectionTable.h"

@interface SubCategoryView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation SubCategoryView
{
    UITableView * mainTableView;
    NSArray * mainArray;
    
    UIImageView * alertView;
    UIView * darkView;
    UIImageView * mainMoneyImage;
    UILabel * alertTitleLabel;
    UILabel * mainAlertText;
    
    UIButton * buttonToFavorites;
    UIButton * buttonBuy;
    UIButton * buttonOpenCategory;
    
    NSDictionary * dictBookMark;
    
    UIActivityIndicatorView * activitiInd;
}

- (instancetype)initWithBackgroundView: (UIView*) view
{
    self = [super init];
    if (self) {
        //Фоновая картинка--------------------
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:self.frame];
        backgroundView.image = [UIImage imageNamed:@"fonSubImage.png"];
        [self addSubview:backgroundView];
    }
    return self;
}


- (instancetype)initWithContent: (UIView*) view andArray: (NSArray*) array
{
    self = [super init];
    if (self) {
        
        //Основной контент---------------------
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        mainArray = array;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationAlertView) name:@"animationSubCatregoryAlertView" object:nil];
        
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        //Убираем полосы разделяющие ячейки------------------------------
        //        mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        mainTableView.backgroundColor = [UIColor clearColor];
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.showsVerticalScrollIndicator = NO;
        [self addSubview:mainTableView];
        
        //Затемнение-----------------------------------------------------
        darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height + 65)];
        darkView.backgroundColor = [UIColor blackColor];
        darkView.alpha = 0.0;
        [self addSubview:darkView];
        
        activitiInd = [[UIActivityIndicatorView alloc] initWithFrame:darkView.frame];
        activitiInd.backgroundColor = [UIColor clearColor];
        activitiInd.alpha = 0.f;
        [self addSubview:activitiInd];
        
#pragma mark - Create Alert
        
        //Создаем алерт---------------------------------------------------
        alertView = [[UIImageView alloc] initWithFrame:CGRectMake(24, -600, self.frame.size.width - 48, 408)];
        if (isiPhone5) {
            alertView.frame = CGRectMake(24, -600, self.frame.size.width - 48, 310);
        }
        alertView.image = [UIImage imageNamed:@"alertViewImage.png"];
        alertView.userInteractionEnabled = YES;
        [self addSubview:alertView];
        
        //Кнопка отмены--------------------------------------------------
        UIButton * buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonCancel.frame = CGRectMake(24, 56, 32, 32);
        if (isiPhone5) {
            buttonCancel.frame = CGRectMake(10, 40, 25, 25);
        }
        UIImage *btnImage = [UIImage imageNamed:@"imageCancel.png"];
        [buttonCancel setImage:btnImage forState:UIControlStateNormal];
        [buttonCancel addTarget:self action:@selector(buttonCancelAction) forControlEvents:UIControlEventTouchUpInside];
        [alertView addSubview:buttonCancel];
        
        //Значек денег----------------------------------------------------
        mainMoneyImage = [[UIImageView alloc] initWithFrame:CGRectMake(alertView.frame.size.width / 2 - 20, 16, 40, 40)];
        if (isiPhone5) {
            mainMoneyImage.frame = CGRectMake(alertView.frame.size.width / 2 - 20, 10, 40, 40);
        }
        mainMoneyImage.layer.cornerRadius = 20;
        mainMoneyImage.layer.masksToBounds = YES;
        [alertView addSubview:mainMoneyImage];
        
        //Заголовок алерта-----------------------------------------------
        alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(64, 65, alertView.frame.size.width - 128, 40)];
        alertTitleLabel.numberOfLines = 0;
        alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        alertTitleLabel.textColor = [UIColor colorWithHexString:@"c0c0c0"];
        alertTitleLabel.font = [UIFont fontWithName:FONTREGULAR size:16];
        if (isiPhone5) {
            alertTitleLabel.frame = CGRectMake(64, 55, alertView.frame.size.width - 128, 32);
            alertTitleLabel.font = [UIFont fontWithName:FONTREGULAR size:13];
        }
        //        [alertTitleLabel sizeToFit];
        [alertView addSubview:alertTitleLabel];
        
        //Основной текст--------------------------------------------------
        mainAlertText = [[UILabel alloc] initWithFrame:CGRectMake(30, alertTitleLabel.frame.origin.y + alertTitleLabel.frame.size.height + 4, alertView.frame.size.width - 60, 120)];
        mainAlertText.numberOfLines = 0;
        mainAlertText.textAlignment = NSTextAlignmentCenter;
        mainAlertText.textColor = [UIColor colorWithHexString:@"c0c0c0"];
        mainAlertText.font = [UIFont fontWithName:FONTLITE size:13];
        if (isiPhone5) {
            mainAlertText.frame = CGRectMake(30, alertTitleLabel.frame.origin.y + alertTitleLabel.frame.size.height + 4, alertView.frame.size.width - 60, 100);
            mainAlertText.font = [UIFont fontWithName:FONTLITE size:10];
        }
        [alertView addSubview:mainAlertText];
        
        //Кнопка открыть категорию--------------------------------------
        buttonOpenCategory = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonOpenCategory.frame = CGRectMake(24, 230, alertView.frame.size.width - 48, 48);
        buttonOpenCategory.backgroundColor = nil;
        buttonOpenCategory.tag = 382;
        buttonOpenCategory.layer.cornerRadius = 25;
        buttonOpenCategory.layer.borderColor = [UIColor colorWithHexString:@"36b34c"].CGColor;
        buttonOpenCategory.layer.borderWidth = 1.f;
        [buttonOpenCategory setTitle:@"ОТКРЫТЬ" forState:UIControlStateNormal];
        [buttonOpenCategory setTitleColor:[UIColor colorWithHexString:@"36b34c"] forState:UIControlStateNormal];
        buttonOpenCategory.titleLabel.font = [UIFont fontWithName:FONTLITE size:16];
        if (isiPhone5) {
            buttonOpenCategory.frame = CGRectMake(25, 180, alertView.frame.size.width - 50, 36);
            buttonOpenCategory.layer.cornerRadius = 18;
            buttonOpenCategory.titleLabel.font = [UIFont fontWithName:FONTLITE size:12];
        }
        [buttonOpenCategory addTarget:self action:@selector(buttonOpenCategoryAction) forControlEvents:UIControlEventTouchUpInside];
        [alertView addSubview:buttonOpenCategory];
        
        //Кнопка добавить в игранное--------------------------------------
        buttonToFavorites = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonToFavorites.frame = CGRectMake(24, 286, alertView.frame.size.width - 48, 48);
        buttonToFavorites.backgroundColor = nil;
        buttonToFavorites.tag = 246;
        buttonToFavorites.layer.cornerRadius = 25;
        buttonToFavorites.layer.borderColor = [UIColor colorWithHexString:@"147ab4"].CGColor;
        buttonToFavorites.layer.borderWidth = 1.f;
        [buttonToFavorites setTitle:@"ДОБАВИТЬ В ЗАКЛАДКИ" forState:UIControlStateNormal];
        [buttonToFavorites setTitleColor:[UIColor colorWithHexString:@"147ab4"] forState:UIControlStateNormal];
        buttonToFavorites.titleLabel.font = [UIFont fontWithName:FONTLITE size:16];
        if (isiPhone5) {
            buttonToFavorites.frame = CGRectMake(25, 222, alertView.frame.size.width - 50, 36);
            buttonToFavorites.layer.cornerRadius = 18;
            buttonToFavorites.titleLabel.font = [UIFont fontWithName:FONTLITE size:12];
        }
        [alertView addSubview:buttonToFavorites];
        
        //Купить тему----------------------------------------------
        buttonBuy = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonBuy.frame = CGRectMake(24, 342, alertView.frame.size.width - 48, 48);
        buttonBuy.backgroundColor = [UIColor colorWithHexString:@"ee5a59"];
        buttonBuy.tag = 1265;
        buttonBuy.layer.cornerRadius = 25;
        buttonBuy.layer.borderColor = [UIColor colorWithHexString:@"ee5a59"].CGColor;
        buttonBuy.layer.borderWidth = 1.f;
        [buttonBuy setTitle:@"ПОДПИСАТЬСЯ НА ТЕМУ" forState:UIControlStateNormal];
        [buttonBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonBuy.titleLabel.font = [UIFont fontWithName:FONTLITE size:16];
        if (isiPhone5) {
            buttonBuy.frame = CGRectMake(25, 264, alertView.frame.size.width - 50, 36);
            buttonBuy.layer.cornerRadius = 18;
            buttonBuy.titleLabel.font = [UIFont fontWithName:FONTLITE size:12];
        }
        [buttonBuy addTarget:self action:@selector(buttonBuyAction) forControlEvents:UIControlEventTouchUpInside];
        [alertView addSubview:buttonBuy];
        
        
        
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    for (UIView * view in cell.contentView.subviews) {
        
        [view removeFromSuperview];
    }
    
    cell.backgroundColor = nil;
    
    NSDictionary * dictCell = [mainArray objectAtIndex:indexPath.row];
    
    if (mainArray.count != 0) {
        NSString * stringURL = [StringImage createStringImageURLWithString:[dictCell objectForKey:@"media_path"]];
        [cell.contentView addSubview:[self setTableCellWithTitle:[dictCell objectForKey:@"title"]
                                                     andSubTitle:[dictCell objectForKey:@"description"]
                                                        andMoney:[[dictCell objectForKey:@"paid"] boolValue]
                                                        andImage:nil andURL:stringURL]];
    } else {
        NSLog(@"Нет категорий");
    }
    
    
    return cell;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * dictMainArray = [mainArray objectAtIndex:indexPath.row];
    [[SingleTone sharedManager] setIdentifierSubCategory:[dictMainArray objectForKey:@"id"]];
    [[SingleTone sharedManager] setTariffID:[dictMainArray objectForKey:@"id"]];
    
    
    //    if (indexPath.row == 4) {
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"customNotification" object:nil];
    //        [self performSelector:@selector(buttonCancelAction) withObject:nil afterDelay:0.5];
    //    }
    
    NSDictionary * dictCell = [mainArray objectAtIndex:indexPath.row];
    dictBookMark = dictCell;
    alertTitleLabel.text = [dictCell objectForKey:@"title"];
    mainAlertText.text = [dictCell objectForKey:@"text"];
    
    if ([[dictCell objectForKey:@"paid"] boolValue]) {
        buttonBuy.alpha = 1.f;
    } else {
        buttonBuy.alpha = 0.f;
    }
    
//    NSLog(@"%@", dictCell);
    
    NSString * stringURL = [StringImage createStringImageURLWithString:[dictCell objectForKey:@"media_path"]];
    mainMoneyImage.image = [ViewSectionTable createWithImageAlertURL:stringURL andView:alertView andContentMode:UIViewContentModeScaleAspectFill andBoolMoney:[[dictCell objectForKey:@"paid"] boolValue]].image;    
    
    [[SingleTone sharedManager] setTitleSubCategory:[dictCell objectForKey:@"title"]];
    [[SingleTone sharedManager] setRules:[dictCell objectForKey:@"rules"]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationChekBookMarkSubcategory" object:[dictCell objectForKey:@"paid"]];
    
    [UIView animateWithDuration:0.1 animations:^{
        darkView.alpha = 0.4f;
        activitiInd.alpha = 1.f;
        [activitiInd startAnimating];
    }];
    

    
}

- (void) animationAlertView
{
    //Анимация алерта---------------------------------------------
    [UIView animateWithDuration:0.1 animations:^{
        activitiInd.alpha = 0.f;
        [activitiInd stopAnimating];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rectAlert = alertView.frame;
            if (isiPhone6) {
                rectAlert.origin.y += 680;
            } else if (isiPhone5) {
                rectAlert.origin.y += 650;
            } else {
                rectAlert.origin.y += 760;
            }
            alertView.frame = rectAlert;
        }];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isiPhone6) {
        return 112;
    } else if (isiPhone5) {
        return 100;
    } else {
        return 120;
    }
}

#pragma mark - CustomCell

//Кастомная ячейка---------------------------------------
- (UIView*) setTableCellWithTitle: (NSString*) string
                      andSubTitle: (NSString*) subTitle
                         andMoney: (BOOL) money
                         andImage: (NSString*) image
                           andURL: (NSString*) url
{
    //Основное окно ячейки--------------------------------
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 120)];
    if (isiPhone6) {
        cellView.frame = CGRectMake(0, 0, self.frame.size.width, 112);
    } else if (isiPhone5) {
        cellView.frame = CGRectMake(0, 0, self.frame.size.width, 100);
    }
    cellView.backgroundColor = nil;
    
    //Создаем картинку------------------------------------
    UIView * imageViewCategory = [[UIView alloc] initWithFrame:CGRectMake(16, 10, 96, 96)];
    imageViewCategory.layer.cornerRadius = 0.5;
    if (isiPhone6) {
        imageViewCategory.frame = CGRectMake(12, 11, 88, 88);
    } else if (isiPhone5) {
        imageViewCategory.frame = CGRectMake(12, 11, 80, 80);
    }
    
    ViewSectionTable * viewSectionTable = [[ViewSectionTable alloc] initWithImageURL:url andView:nil andContentMode:UIViewContentModeScaleAspectFill];
    [imageViewCategory addSubview:viewSectionTable];
    
    
    [cellView addSubview:imageViewCategory];
    
    
    
    
    
    //Заголовок-------------------------------------------
    UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(136, 10, 216, 24)];
    NSString * myString = string;
    labelTitle.text = myString;
    labelTitle.numberOfLines = 2;
    labelTitle.textColor = [UIColor colorWithHexString:@"d46458"];
    labelTitle.font = [UIFont fontWithName:FONTLITE size:21];
    if (isiPhone6) {
        labelTitle.frame = CGRectMake(120, 10, 200, 24);
        labelTitle.font = [UIFont fontWithName:FONTLITE size:20];
    } else if (isiPhone5) {
        labelTitle.frame = CGRectMake(100, 8, 175, 24);
        labelTitle.font = [UIFont fontWithName:FONTLITE size:16];
    }
    [labelTitle sizeToFit];
    [cellView addSubview:labelTitle];
    
    //Подзаголовок----------------------------------------
    UILabel * labelSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(136, 16 + labelTitle.frame.size.height, 216, 55)];
    labelSubTitle.text = subTitle;
    labelSubTitle.textColor = [UIColor colorWithHexString:@"c0c0c0"];
    labelSubTitle.numberOfLines = 0;
    labelSubTitle.font = [UIFont fontWithName:FONTLITE size:14];
    if (isiPhone6) {
        labelSubTitle.frame = CGRectMake(120, 16 + labelTitle.frame.size.height, 200, 48);
        labelSubTitle.font = [UIFont fontWithName:FONTLITE size:13];
    } else if (isiPhone5) {
        labelSubTitle.frame = CGRectMake(100, 15 + labelTitle.frame.size.height, 175, 40);
        labelSubTitle.font = [UIFont fontWithName:FONTLITE size:11];
    }
    [cellView addSubview:labelSubTitle];
    
    //Платная или нет-------------------------------------
    UIImageView * moneyImage = [[UIImageView alloc] initWithFrame:CGRectMake(90, 74, 40, 40)];
    if (isiPhone6) {
        moneyImage.frame = CGRectMake(70, 70, 35, 35);
    } else if (isiPhone5) {
        moneyImage.frame = CGRectMake(65, 65, 30, 30);
    }
    moneyImage.image = [UIImage imageNamed:@"imageMoney.png"];
    [cellView addSubview:moneyImage];
    if (!money) {
        moneyImage.alpha = 0.f;
    }
    
    //Стрелка перехода------------------------------------
    UIImageView * arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(cellView.frame.size.width - 48, 40, 16, 48)];
    if (isiPhone6) {
        arrowImage.frame = CGRectMake(cellView.frame.size.width - 48, cellView.frame.size.height / 2 - 24, 16, 48);
    } else if (isiPhone5) {
        arrowImage.frame = CGRectMake(cellView.frame.size.width - 40, cellView.frame.size.height / 2 - 20, 13, 40);
    }
    arrowImage.image = [UIImage imageNamed:@"arrowImage.png"];
    [cellView addSubview:arrowImage];
    
    //Граница ячейки--------------------------------------
    UIView * viewBorder = [[UIView alloc] initWithFrame:CGRectMake(16, 119, cellView.frame.size.width - 32, 1)];
    if (isiPhone6) {
        viewBorder.frame = CGRectMake(16, 111, cellView.frame.size.width - 32, 1);
    } else if (isiPhone5) {
        viewBorder.frame = CGRectMake(16, 99, cellView.frame.size.width - 32, 1);
    }
    viewBorder.backgroundColor = [UIColor colorWithHexString:@"c0c0c0"];
    [cellView addSubview:viewBorder];
    
    return cellView;
}

#pragma mark - Buttons Methods
//Действие кнопки закрыть алерт
- (void) buttonCancelAction
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rectAlert = alertView.frame;
        
        
        if (isiPhone6) {
            rectAlert.origin.y -= 680;
        } else if (isiPhone5) {
            rectAlert.origin.y -= 650;
        } else {
            rectAlert.origin.y -= 760;
        }
        alertView.frame = rectAlert;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            darkView.alpha = 0;
        }];
    }];
}
//Действие кнопки открыть категорию
- (void) buttonOpenCategoryAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SUB_CATEGORY_PUSH_TU_SUBCATEGORY object:nil];
    [self performSelector:@selector(buttonCancelAction) withObject:nil afterDelay:0.5];
}

//Действие кнопки купить тему
-(void) buttonBuyAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_BUY_CATEGORY object:nil];
    [self performSelector:@selector(buttonCancelAction) withObject:nil afterDelay:0.5];
}



@end
