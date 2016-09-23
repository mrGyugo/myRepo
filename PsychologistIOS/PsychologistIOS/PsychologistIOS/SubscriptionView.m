//
//  SubscriptionView.m
//  PsychologistIOS
//
//  Created by Viktor on 07.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "SubscriptionView.h"
#import "SingleTone.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@interface SubscriptionView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation SubscriptionView
{
    NSMutableArray * mainArray;
    UITableView * mainTableView;
}

- (instancetype)initBackGrounWithView: (UIView*) view
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

- (instancetype)initWithContent: (UIView*) view andArray: (NSMutableArray*) array
{
    self = [super init];
    if (self) {
        
        //Основной контент---------------------
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        mainArray = array;
        
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        if (isiPhone6) {
            mainTableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } else if (isiPhone5) {
            mainTableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        }
        //Убираем полосы разделяющие ячейки------------------------------
        mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        mainTableView.backgroundColor = [UIColor clearColor];
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.showsVerticalScrollIndicator = NO;
        [self addSubview:mainTableView];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.backgroundColor = nil;
    
    NSDictionary * dictCell = [mainArray objectAtIndex:indexPath.row];
    
    [cell addSubview:[self setTableCellWithTitle:[dictCell objectForKey:@"title"]
                                     andSubTitle:[dictCell objectForKey:@"subTitle"]
                                        andImage:[dictCell objectForKey:@"image"]
                                        andTrial:[dictCell objectForKey:@"trial"]]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * dictCell = [mainArray objectAtIndex:indexPath.row];
    
    [[SingleTone sharedManager] setTitleSubject:[dictCell objectForKey:@"title"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_SUBSCRIPTION_WITH_OPENSUBJECT object:[dictCell objectForKey:@"title"]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isiPhone6) {
        return 112;
    } else if (isiPhone5) {
        return 100;
    } else {
        return 128;
    }
}

#pragma mark - CustomCell

//Кастомная ячейка---------------------------------------
- (UIView*) setTableCellWithTitle: (NSString*) string
                      andSubTitle: (NSString*) subTitle
                         andImage: (NSString*) image
                         andTrial: (NSNumber*) trial
{
    //Основное окно ячейки--------------------------------
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 128)];
    if (isiPhone6) {
        cellView.frame = CGRectMake(0, 0, self.frame.size.width, 112);
    } else if (isiPhone5) {
        cellView.frame = CGRectMake(0, 0, self.frame.size.width, 100);
    }
    cellView.backgroundColor = nil;
    
    //Создаем картинку------------------------------------
    UIImageView * imageViewCategory = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 96, 96)];
    imageViewCategory.layer.cornerRadius = 0.5;
    if (isiPhone6) {
        imageViewCategory.frame = CGRectMake(12, 11, 88, 88);
    } else if (isiPhone5) {
        imageViewCategory.frame = CGRectMake(12, 11, 80, 80);
    }
    imageViewCategory.image = [UIImage imageNamed:image];
    [cellView addSubview:imageViewCategory];
    
    //Заголовок-------------------------------------------
    UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(136, 16, 216, 24)];
    labelTitle.text = string;
    labelTitle.numberOfLines = 0;
    labelTitle.textColor = [UIColor colorWithHexString:@"d46458"];
    labelTitle.font = [UIFont fontWithName:FONTLITE size:23];
    if (isiPhone6) {
        labelTitle.frame = CGRectMake(120, 16, 216, 24);
        labelTitle.font = [UIFont fontWithName:FONTLITE size:22];
    } else if (isiPhone5) {
        labelTitle.frame = CGRectMake(100, 14, 200, 24);
        labelTitle.font = [UIFont fontWithName:FONTLITE size:18];
    }
    [labelTitle sizeToFit];
    [cellView addSubview:labelTitle];
    
    //Подзаголовок----------------------------------------
    UILabel * labelSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(136, 16 + labelTitle.frame.size.height, 216, 16)];
    labelSubTitle.text = subTitle;
    labelSubTitle.textColor = [UIColor colorWithHexString:@"676766"];
    labelSubTitle.numberOfLines = 0;
    labelSubTitle.font = [UIFont fontWithName:FONTLITE size:16];
    if (isiPhone6) {
        labelSubTitle.frame = CGRectMake(120, 16 + labelTitle.frame.size.height, 216, 16);
        labelSubTitle.font = [UIFont fontWithName:FONTLITE size:15];
    } else if (isiPhone5) {
        labelSubTitle.frame = CGRectMake(100, 20 + labelTitle.frame.size.height, 216, 16);
        labelSubTitle.font = [UIFont fontWithName:FONTLITE size:12];
    }
    [labelSubTitle sizeToFit];
    [cellView addSubview:labelSubTitle];
    
    //Граница ячейки--------------------------------------
    UIView * viewBorder = [[UIView alloc] initWithFrame:CGRectMake(16, 127, cellView.frame.size.width - 32, 1)];
    if (isiPhone6) {
        viewBorder.frame = CGRectMake(16, 111, cellView.frame.size.width - 32, 1);
    } else if (isiPhone5) {
        viewBorder.frame = CGRectMake(16, 99, cellView.frame.size.width - 32, 1);
    }
    viewBorder.backgroundColor = [UIColor colorWithHexString:@"c0c0c0"];
    [cellView addSubview:viewBorder];
    
    
    //Срок действия------------------------------------------
    // 0 - бесплатная, 1 - платная оплаченная, 2 - платная закончилась
    if ([trial integerValue] == 1) {
        UILabel * labelTrial = [[UILabel alloc] initWithFrame:CGRectMake(136, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 24, 200, 16)];
        labelTrial.text = @"Доступен до 1.04.2016";
        labelTrial.textColor = [UIColor colorWithHexString:@"676766"];
        labelTrial.font = [UIFont fontWithName:FONTLITE size:13];
        if (isiPhone6) {
            labelTrial.frame = CGRectMake(120, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 14, 200, 16);
            labelTrial.font = [UIFont fontWithName:FONTLITE size:12];
        } else if (isiPhone5) {
            labelTrial.frame = CGRectMake(100, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 14, 200, 16);
            labelTrial.font = [UIFont fontWithName:FONTLITE size:10];
        }
        [cellView addSubview:labelTrial];
    } else if ([trial integerValue] == 2) {
        UIButton * buttonBuyTrial = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonBuyTrial.frame = CGRectMake(136, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 24, 110, 16);
        [buttonBuyTrial setTitle:@"Продлить доступ" forState:UIControlStateNormal];
        [buttonBuyTrial setTitleColor:[UIColor colorWithHexString:@"0aa00a"] forState:UIControlStateNormal];
        buttonBuyTrial.titleLabel.font = [UIFont fontWithName:FONTLITE size:13];
        if (isiPhone6) {
            buttonBuyTrial.frame = CGRectMake(111, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 14, 110, 16);
            buttonBuyTrial.titleLabel.font = [UIFont fontWithName:FONTLITE size:12];
        } else if (isiPhone5) {
            buttonBuyTrial.frame = CGRectMake(90, labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y + 14, 110, 16);
            buttonBuyTrial.titleLabel.font = [UIFont fontWithName:FONTLITE size:10];
        }
        [buttonBuyTrial addTarget:self action:@selector(buttonBuyTrialActiob) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview:buttonBuyTrial];
    }
    
    return cellView;
}

#pragma mark - Action Methods

//Действие кнопки продлить доступ
- (void) buttonBuyTrialActiob
{
    NSLog(@"Продлить доступ");
}


@end
