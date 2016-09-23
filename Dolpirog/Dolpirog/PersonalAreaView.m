//
//  PersonalAreaView.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 19/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "PersonalAreaView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "CustomLabels.h"

@implementation PersonalAreaView
{
    UITableView * mainTableView;
    NSMutableArray * testArray;
}

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height);
        
        //тестовый массив---------
        testArray = [self setArrayTest];
        
        //Имя пользовтаеля---------------------
        CustomLabels * labelName = [[CustomLabels alloc] initLabelBondWithWidht:20 andHeight:15 andColor:COLORTEXTORANGE andText:@"Анатоле Вассерман" andTextSize: 15];
        [self addSubview:labelName];
        
        //Заголовк телефон-------------------
        CustomLabels * labelTintPhone = [[CustomLabels alloc] initLabelBondWithWidht:20
                                                                           andHeight:labelName.frame.origin.y + labelName.frame.size.height + 2
                                                                            andColor:COLORLITEGRAY andText:@"Тел:" andTextSize: 15];
        [self addSubview:labelTintPhone];
        
        //Данные Телефон
        CustomLabels * labelTintPhoneAct = [[CustomLabels alloc] initLabelRegularWithWidht:25 + labelTintPhone.frame.size.width
                                                                                 andHeight:labelName.frame.origin.y + labelName.frame.size.height + 2
                                                                                  andColor:COLORLITEGRAY andText:@"+7 999 999 999" andTextSize: 15];
        [self addSubview:labelTintPhoneAct];
        
        //Заголовк почта-------------------
        CustomLabels * labelTintEmail = [[CustomLabels alloc] initLabelBondWithWidht:20
                                                                           andHeight:labelTintPhone.frame.origin.y + labelTintPhone.frame.size.height + 2
                                                                            andColor:COLORLITEGRAY andText:@"Email:" andTextSize: 15];
        [self addSubview:labelTintEmail];
        
        //Заголовк почта изменяемый-------------------
        CustomLabels * labelTintEmailAct = [[CustomLabels alloc] initLabelRegularWithWidht:25 + labelTintEmail.frame.size.width
                                                                                 andHeight:labelTintPhone.frame.origin.y + labelTintPhone.frame.size.height + 2
                                                                                  andColor:COLORLITEGRAY andText:@"Anatole@mail.ru" andTextSize: 15];
        [self addSubview:labelTintEmailAct];
        
        //Вью Фон Для таблицы-------
        UIView * viewFoneForTable = [[UIView alloc] initWithFrame:CGRectMake(0, labelTintEmail.frame.origin.y + labelTintEmail.frame.size.height + 15, self.frame.size.width, 40)];
        viewFoneForTable.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        [self addSubview:viewFoneForTable];
        
        //Заголовок для таблицы------
        CustomLabels * labelTintTable = [[CustomLabels alloc] initLabelBondWithWidht:20 andHeight:viewFoneForTable.frame.origin.y + 11 andColor:@"4d4d4b" andText:@"Мои заказы" andTextSize: 15];
        [self addSubview:labelTintTable];
        
        //Создание таблицы заказов----
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, viewFoneForTable.frame.origin.y + viewFoneForTable.frame.size.height, self.frame.size.width, self.frame.size.height - (viewFoneForTable.frame.origin.y + viewFoneForTable.frame.size.height) - 64)];
        //Убираем полосы разделяющие ячейки------------------------------
        mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        mainTableView.backgroundColor = nil;
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.showsVerticalScrollIndicator = NO;
        //Очень полездное свойство, отключает дествие ячейки-------------
        mainTableView.allowsSelection = NO;
        [self addSubview:mainTableView];
        
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return testArray.count;
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
    NSDictionary * dictCell = [testArray objectAtIndex:indexPath.row];
    
    if (testArray.count != 0) {
        [cell.contentView addSubview:[self setTableCellWithDate:[dictCell objectForKey:@"date"]
                                                          andID:[dictCell objectForKey:@"id"]
                                                        andName:[dictCell objectForKey:@"name"]
                                                      andStatus:[dictCell objectForKey:@"status"]]];
    } else {
        NSLog(@"Нет категорий");
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46.f;
}

#pragma mark - CustomCell

//Кастомная ячейка---------------------------------------
- (UIView*) setTableCellWithDate: (NSString*) date
                           andID: (NSString*) textID
                         andName: (NSString*) name
                       andStatus: (NSString*) status
{
    //Основное окно ячейки--------------------------------
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 46)];
    cellView.backgroundColor = nil;
    
    //Лэйбл даты-------------
    CustomLabels * labelDate = [[CustomLabels alloc] initLabelTableWithWidht:0 andHeight:0 andSizeWidht:cellView.frame.size.width / 4 andSizeHeight:46 andColor:COLORTEXTLITE andText:date];
    labelDate.font = [UIFont fontWithName:FONTREGULAR size:13];
    if (isiPhone5 || isiPhone4s) {
        labelDate.font = [UIFont fontWithName:FONTREGULAR size:11];
    }
    [cellView addSubview:labelDate];
    
    //Лейбл id
    CustomLabels * labelID = [[CustomLabels alloc] initLabelTableWithWidht:labelDate.frame.size.width - 10 andHeight:0 andSizeWidht:labelDate.frame.size.width andSizeHeight:46 andColor:COLORTEXTLITE andText:textID];
    labelID.font = [UIFont fontWithName:FONTREGULAR size:13];
    if (isiPhone5 || isiPhone4s) {
        labelID.font = [UIFont fontWithName:FONTREGULAR size:11];
    }
    [cellView addSubview:labelID];
    
    //Лейбл имени
    CustomLabels * labelName = [[CustomLabels alloc] initLabelTableWithWidht:labelDate.frame.size.width * 2 - 10 andHeight:0 andSizeWidht:labelDate.frame.size.width + 12 andSizeHeight:46 andColor:COLORTEXTLITE andText:name];
    labelName.font = [UIFont fontWithName:FONTBOND size:13];
    if (isiPhone5 || isiPhone4s) {
        labelName.font = [UIFont fontWithName:FONTBOND size:11];
    }
    [cellView addSubview:labelName];
    
    //Лейбл статуса
    if ([status isEqualToString:@"В пути"]) {
        CustomLabels * labelStatus = [[CustomLabels alloc] initLabelTableWithWidht:8 + labelDate.frame.size.width * 3 andHeight:0 andSizeWidht:labelDate.frame.size.width andSizeHeight:46 andColor:COLORTEXTORANGE andText:status];
        labelStatus.font = [UIFont fontWithName:FONTREGULAR size:13];
        if (isiPhone5 || isiPhone4s) {
            labelStatus.font = [UIFont fontWithName:FONTREGULAR size:11];
        }
        [cellView addSubview:labelStatus];
    } else if ([status isEqualToString:@"Доставлен"]) {
        CustomLabels * labelStatus = [[CustomLabels alloc] initLabelTableWithWidht:labelDate.frame.size.width * 3 andHeight:0 andSizeWidht:labelDate.frame.size.width andSizeHeight:46 andColor:@"49c903" andText:status];
        labelStatus.font = [UIFont fontWithName:FONTREGULAR size:13];
        if (isiPhone5 || isiPhone4s) {
            labelStatus.font = [UIFont fontWithName:FONTREGULAR size:11];
        }
        [cellView addSubview:labelStatus];
    } else {
        NSLog(@"Error");
    }
    
    //граница--------------------------
    UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 45.5f, cellView.frame.size.width, 0.5f)];
    borderView.backgroundColor = [UIColor colorWithHexString:@"737373"];
    [cellView addSubview:borderView];
    
    return cellView;
    
}







//создадим тестовый массив-----------
- (NSMutableArray *) setArrayTest
{
    NSMutableArray * arrayOrder = [[NSMutableArray alloc] init];
    
    NSArray * arrayDate = [NSArray arrayWithObjects:
                           @"25.04.2016", @"21.04.2016", @"21.04.2016",
                           @"21.04.2016", @"12.02.2015", nil];
    
    NSArray * arrayID = [NSArray arrayWithObjects:
                         @"№ 53", @"№ 453",
                         @"№ 445", @"№ 465", @"№ 541", nil];
    
    
    NSArray * arrayName = [NSArray arrayWithObjects:
                           @"Шашлык", @"Гарнир", @"Пирог с капустой",
                           @"Пирог с рыбой", @"Напитки+пирог", nil];
    
    NSArray * arrayStatus = [NSArray arrayWithObjects:
                             @"В пути", @"В пути", @"В пути",
                             @"Доставлен", @"Доставлен", nil];
    
    
    for (int i = 0; i < arrayDate.count; i++) {
        
        NSDictionary * dictOrder = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [arrayDate objectAtIndex:i], @"date",
                                    [arrayID objectAtIndex:i], @"id",
                                    [arrayName objectAtIndex:i], @"name",
                                    [arrayStatus objectAtIndex:i], @"status", nil];
        
        [arrayOrder addObject:dictOrder];
    }
    
    return arrayOrder;
}

@end
