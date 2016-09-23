//
//  ContactsView.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 19/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ContactsView.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "UIColor+HexColor.h"
#import "CustomView.h"

@interface ContactsView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView * mainTableView;
@property (strong, nonatomic) NSArray * testArray;
@property (assign, nonatomic) NSInteger sizeText;

@end

@implementation ContactsView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64);
        
        NSInteger sizeBigText;
        if (isiPhone4s || isiPhone5) {
            sizeBigText = 14;
            _sizeText = 12;
        } else {
            sizeBigText = 16;
            _sizeText = 14;
        }
        
        _testArray = [self setArrayTest];
        
        //Адрес основной кухни-------------------------------
        CustomLabels * labelTitleMainContact = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:30 andSizeWidht:self.frame.size.width - 40 andSizeHeight:35 andColor:COLORTEXTORANGE andText:@"Адрес основной кухни: "];
        labelTitleMainContact.numberOfLines = 0;
        labelTitleMainContact.font = [UIFont fontWithName:FONTREGULAR size:16];
        labelTitleMainContact.textAlignment = NSTextAlignmentLeft;
        [self addSubview:labelTitleMainContact];
        

        //Доставка долгопрудный
        CustomLabels * labelContact = [[CustomLabels alloc] initLabelRegularWithWidht:20 andHeight:70
                                                                               andColor:@"ffffff" andText:@"г.Долгопрудный пр-т Пацаева д.7 корп.6" andTextSize:_sizeText];
        
        [self addSubview:labelContact];
        
        //Телефон
        CustomLabels * labelPhone = [[CustomLabels alloc] initLabelRegularWithWidht:20 andHeight:90
                                                                             andColor:@"ffffff" andText:@"Телефон: +7 (495) 241-241-8 (многоканальный)" andTextSize:_sizeText];
        
        [self addSubview:labelPhone];
        
        //Email
        CustomLabels * labelEmail = [[CustomLabels alloc] initLabelRegularWithWidht:20 andHeight:110
                                                                           andColor:@"ffffff" andText:@"E-mail: co@dolpirog.ru" andTextSize:_sizeText];
        
        [self addSubview:labelEmail];
        
        CustomView * borderOne = [[CustomView alloc] initWithHeight:135 andView:self andColor:@"737373"];
        [self addSubview:borderOne];
        
        
        CustomLabels * labelTimeOne = [[CustomLabels alloc] initLabelRegularWithWidht:20 andHeight:150
                                                                             andColor:COLORTEXTORANGE andText:@"Время работы доставки:" andTextSize:_sizeText];
        [self addSubview:labelTimeOne];
        
        CustomLabels * labelTimeOneAction = [[CustomLabels alloc] initLabelRegularWithWidht:labelTimeOne.frame.size.width + 25 andHeight:150
                                                                                   andColor:@"ffffff" andText:@"с 10:00 до 23:00" andTextSize:_sizeText];
        
        [self addSubview:labelTimeOneAction];
        
        CustomLabels * labelTimeTwo = [[CustomLabels alloc] initLabelRegularWithWidht:20 andHeight:170
                                                                             andColor:COLORTEXTORANGE andText:@"Время приема последнего заказа:" andTextSize:_sizeText];
        [self addSubview:labelTimeTwo];
        
        CustomLabels * labelTimeTwoAction = [[CustomLabels alloc] initLabelRegularWithWidht:labelTimeTwo.frame.size.width + 25 andHeight:170
                                                                                   andColor:@"ffffff" andText:@"22:00" andTextSize:_sizeText];
        
        [self addSubview:labelTimeTwoAction];
        
        CustomView * borderTwo = [[CustomView alloc] initWithHeight:195 andView:self andColor:@"737373"];
        [self addSubview:borderTwo];
        
        //Адрес основной кухни-------------------------------
        CustomLabels * labelAddContacts = [[CustomLabels alloc] initLabelTableWithWidht:20 andHeight:205 andSizeWidht:self.frame.size.width - 40 andSizeHeight:35 andColor:COLORTEXTORANGE andText:@"Адреса дополнительных кухонь:"];
        labelAddContacts.numberOfLines = 0;
        labelAddContacts.font = [UIFont fontWithName:FONTREGULAR size:16];
        labelAddContacts.textAlignment = NSTextAlignmentLeft;
        [self addSubview:labelAddContacts];
        
        //Основная таблица-------------------------------------
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, view.frame.size.width, view.frame.size.height)];
        //Убираем полосы разделяющие ячейки------------------------------
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.backgroundColor = nil;
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        //Очень полездное свойство, отключает дествие ячейки-------------
        _mainTableView.allowsSelection = NO;
        [self addSubview:_mainTableView];

        
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _testArray.count;
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
    
    if (_testArray.count != 0) {
        [cell.contentView addSubview:[self setTableCellWithText:[_testArray objectAtIndex:indexPath.row]]];
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
    return 50.f;
}

#pragma mark - CustomCell

- (UIView*) setTableCellWithText: (NSString*) text
{
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    cellView.backgroundColor = nil;
    
    CustomLabels * labelTimeOne = [[CustomLabels alloc] initLabelRegularWithWidht:20 andHeight:10
                                                                         andColor:COLORTEXTORANGE andText:@"Дополнительная кухня," andTextSize:_sizeText];
    [cellView addSubview:labelTimeOne];
    
    CustomLabels * labelTimeOneAction = [[CustomLabels alloc] initLabelRegularWithWidht:20 andHeight:30
                                                                               andColor:@"ffffff" andText:text andTextSize:_sizeText];
    
    [cellView addSubview:labelTimeOneAction];
    
    CustomView * borderOne = [[CustomView alloc] initWithHeight:49.5 andView:self andColor:@"737373"];
    [cellView addSubview:borderOne];
    
    return cellView;
}




//создадим тестовый массив-----------
- (NSArray *) setArrayTest
{

    
    NSArray * arrayText = [NSArray arrayWithObjects:
                           @"г. Лобня, Ул. Ленина дом 19/1",
                           @"мкр. Северный, 9-ая Северная линия дом 7",
                           @"район Шереметьевский, улица Центральная дом 1/2",
                           @"м. Алтуфьево, Алтуфьевское шоссе дом 15", nil];
    

    
    return arrayText;
}



@end
