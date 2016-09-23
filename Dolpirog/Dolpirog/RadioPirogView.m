//
//  RadioView.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 21/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "RadioPirogView.h"
#import "InputTextToView.h"
#import "Macros.h"
#import "UIColor+HexColor.h"
#import "CustomLabels.h"
#import "CustomView.h"
#import "InputTextView.h"
#import "ButtonMenu.h"

@interface RadioPirogView () <UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView * sortTable;
@property (strong, nonatomic) NSMutableArray * mainArray;

@end

@implementation RadioPirogView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64);
        
        NSArray * arrayPlaysHolders = [NSArray arrayWithObjects:@"Имя", @"Песня", @"Исполнитель", nil];
        _mainArray = [self setArrayTest];
        
#pragma mark - RadioMenu
        
        UIView * viewRadio = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 80)];
        viewRadio.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3f];
        [self addSubview:viewRadio];
        
        UIImageView * mainImageRadio = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
        mainImageRadio.image = [UIImage imageNamed:@"mainImageRadio.png"];
        [self addSubview:mainImageRadio];
        
        UIButton * buttonPause = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonPause.frame = CGRectMake(52, 51, 20, 20);
        buttonPause.backgroundColor = [UIColor colorWithHexString:COLORORANGE];
        buttonPause.layer.cornerRadius = 10.f;
        UIImage * buttonPauseImage = [self imageWithImage:[UIImage imageNamed:@"pauseButtonImage.png"] convertToSize:CGSizeMake(10, 10)];
        [buttonPause setImage:buttonPauseImage forState:UIControlStateNormal];
        [buttonPause addTarget:self action:@selector(buttonPauseAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonPause];
        
        CustomLabels * labelStatusRadio = [[CustomLabels alloc] initLabelRegularWithWidht:self.frame.size.width / 2 - 30 andHeight:15 andColor:COLORGREEN andText:@"Online" andTextSize:16];
        [self addSubview:labelStatusRadio];
        
        CustomLabels * labelSong = [[CustomLabels alloc] initLabelRegularWithWidht:self.frame.size.width / 2 - 30 andHeight:35 andColor:COLORTEXTORANGE andText:@"On Every Street" andTextSize:16];
        [self addSubview:labelSong];
        
        CustomLabels * labelGroup = [[CustomLabels alloc] initLabelRegularWithWidht:self.frame.size.width / 2 - 30 andHeight:55 andColor:@"ffffff" andText:@"Dire Straits" andTextSize:16];
        [self addSubview:labelGroup];
        
        CustomView * borderOne = [[CustomView alloc] initWithHeight:79.5 andView:self andColor:COLORLITEGRAY];
        [self addSubview:borderOne];
        
#pragma mark - Messager
        
        CustomLabels * sendHelloLabel = [[CustomLabels alloc] initLabelRegularWithWidht:15 andHeight:90 andColor:COLORTEXTORANGE andText:@"Передать привет" andTextSize:15];
        [self addSubview:sendHelloLabel];
        
        for (int i = 0; i < 3; i++) {
            InputTextView * inputText = [[InputTextView alloc] initCustonTextViewWithRect:CGRectMake(15, 110 + 30 * i, self.frame.size.width - 30, 25) andTextPlaceHolder:[arrayPlaysHolders objectAtIndex:i] andCornerRadius:0.f andView:self fonColor:@"ffffff" andTextColor:@"9a9a99"];
            [self addSubview:inputText];
        }
        
        InputTextToView * inputView = [[InputTextToView alloc] initWithTextViewFrame:CGRectMake(15, 200, self.frame.size.width - 30, 100)];
        inputView.placeholder = @"Текст Сообщения";
        inputView.placeholderColor = [UIColor colorWithHexString:@"9a9a99"];
        [self addSubview:inputView];
        
        //кнопка корзина------------------------------------
        UIButton * buttonSend = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSend.frame = CGRectMake(self.frame.size.width - 120, 310, 105, 30);
        buttonSend.backgroundColor = [UIColor colorWithHexString:COLORORANGE];
        [buttonSend setTitle:@"Отправить" forState:UIControlStateNormal];
        [buttonSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonSend.titleLabel.font = [UIFont fontWithName:FONTBOND size:14];
        buttonSend.layer.cornerRadius = 6.f;
        [buttonSend addTarget:self action:@selector(buttonSendAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonSend];
        
        CustomView * borderTwo = [[CustomView alloc] initWithHeight:360 andView:self andColor:COLORLITEGRAY];
        [self addSubview:borderTwo];
        
#pragma mark - Schedule Songs
        
        CustomLabels * scheduleLabel = [[CustomLabels alloc] initLabelRegularWithWidht:15 andHeight:370 andColor:COLORTEXTORANGE andText:@"Расписание" andTextSize:15];
        [self addSubview:scheduleLabel];
        
        CustomLabels * sortLabel = [[CustomLabels alloc] initLabelRegularWithWidht:15 andHeight:400 andColor:COLORTEXTORANGE andText:@"Сортировать по дате" andTextSize:13];
        [self addSubview:sortLabel];
        
        
        
        _sortTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 420, view.frame.size.width, view.frame.size.height - 490)];
        //Убираем полосы разделяющие ячейки------------------------------
        _sortTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _sortTable.backgroundColor = nil;
        _sortTable.dataSource = self;
        _sortTable.delegate = self;
        _sortTable.showsVerticalScrollIndicator = NO;
        //Очень полездное свойство, отключает дествие ячейки-------------
        _sortTable.allowsSelection = NO;
        [self addSubview:_sortTable];
        
        
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mainArray.count;
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
    NSDictionary * dictCell = [_mainArray objectAtIndex:indexPath.row];
    
    if (_mainArray.count != 0) {
        [cell.contentView addSubview:[self setTableCellWithTime:[dictCell objectForKey:@"time"]
                                                        andText:[dictCell objectForKey:@"text"]]];
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
    return 20.f;
}

#pragma mark - CustomCell

- (UIView*) setTableCellWithTime: (NSString*) time
                              andText: (NSString*) text
{
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
    cellView.backgroundColor = nil;
    
    CustomLabels * timeLabel = [[CustomLabels alloc] initLabelRegularWithWidht:15 andHeight:0 andColor:COLORTEXTORANGE andText:time andTextSize:15];
    [cellView addSubview:timeLabel];
    
    CustomLabels * textLabel = [[CustomLabels alloc] initLabelRegularWithWidht:15 + timeLabel.frame.size.width + 10 andHeight:0 andColor:@"ffffff" andText:text andTextSize:15];
    [cellView addSubview:textLabel];

    return cellView;
}



#pragma mark - Action Methods

- (void) buttonPauseAction
{
    NSLog(@"buttonPauseAction");
}

- (void) buttonSendAction
{
    NSLog(@"buttonSendAction");
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

//создадим тестовый массив-----------
- (NSMutableArray *) setArrayTest
{
    NSMutableArray * arrayOrder = [[NSMutableArray alloc] init];
    
    NSArray * arrayTime = [NSArray arrayWithObjects:
                                @"14:36", @"14:23", @"14:14",
                                @"14:05", @"13:58", @"13:54",
                                @"13:48", @"13:43", @"13:38",
                                @"13:35",nil];
    
    
    NSArray * arrayText = [NSArray arrayWithObjects:
                           @"Браво - Стильный Оранжевый Галстук",
                           @"Пилот - Светлого Пути",
                           @"Алиса - Инок, Воин И Шут",
                           @"Сплин - Новые Люди",
                           @"ДДТ - Не Стреляй!",
                           @"Муха - Я Не Боюсь!",
                           @"Агата Кристи - Позорная Звезда",
                           @"Ногу Свело! - Из Алма-Аты",
                           @"Чайф - Не Дай Мне Повод",
                           @"Casual- Не Осталось", nil];
    
    for (int i = 0; i < arrayTime.count; i++) {
        
        NSDictionary * dictOrder = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [arrayTime objectAtIndex:i], @"time",
                                    [arrayText objectAtIndex:i], @"text", nil];
        
        [arrayOrder addObject:dictOrder];
    }
    
    return arrayOrder;
}





@end
