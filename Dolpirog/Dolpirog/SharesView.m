//
//  SharesView.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 19/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "SharesView.h"
#import "CustomLabels.h"
#import "Macros.h"
#import "UIColor+HexColor.h"

@interface SharesView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView * mainTableView;
@property (strong, nonatomic) NSMutableArray * testArray;

@end

@implementation SharesView

- (instancetype)initWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        
        _testArray = [self setArrayTest];
        
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, view.frame.size.width, view.frame.size.height - 64)];
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
    NSDictionary * dictCell = [_testArray objectAtIndex:indexPath.row];
    
    if (_testArray.count != 0) {
        [cell.contentView addSubview:[self setTableCellWithInageName:[dictCell objectForKey:@"imageName"]
                                                        andTitleText:[dictCell objectForKey:@"titleText"]
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
    return 140.f;
}

#pragma mark - CustomCell

- (UIView*) setTableCellWithInageName: (NSString*) imageName
                      andTitleText: (NSString*) titleText
                           andText: (NSString*) text
{
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 140)];
    cellView.backgroundColor = nil;
    
    //Изображение--------------------------------------
    UIImageView * imageViewCell = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    imageViewCell.image = [UIImage imageNamed:imageName];
    [cellView addSubview:imageViewCell];
    
    //Заголовок----------------------------------------
    CustomLabels * titleCell = [[CustomLabels alloc] initLabelRegularWithWidht:imageViewCell.frame.origin.x + imageViewCell.frame.size.width + 10
                                                                     andHeight:imageViewCell.frame.origin.y
                                                                      andColor:COLORTEXTORANGE
                                                                       andText:titleText
                                                                   andTextSize:16];
    [titleCell sizeToFit];
    titleCell.numberOfLines = 1;
    [cellView addSubview:titleCell];
    
    //Основной текст-----------------------------------
    CustomLabels * textCell = [[CustomLabels alloc] initLabelTableWithWidht:titleCell.frame.origin.x
                                                                  andHeight:titleCell.frame.origin.y + 25
                                                               andSizeWidht:self.frame.size.width - titleCell.frame.origin.x - 20
                                                              andSizeHeight:30
                                                                   andColor:@"ffffff"
                                                                    andText:text];
    textCell.numberOfLines = 0;
    textCell.font = [UIFont fontWithName:FONTREGULAR size:12];
    textCell.textAlignment = NSTextAlignmentLeft;
    [textCell sizeToFit];
    [cellView addSubview:textCell];
    
    return cellView;
}



//создадим тестовый массив-----------
- (NSMutableArray *) setArrayTest
{
    NSMutableArray * arrayOrder = [[NSMutableArray alloc] init];
    
    NSArray * arrayImageName = [NSArray arrayWithObjects:
                           @"meat.png", @"withPotato.png", @"cabbage.png",
                           @"withChicken.png", nil];
    
    NSArray * arrayTitleText = [NSArray arrayWithObjects:
                         @"Мясные пироги", @"Пироги с картошкой",
                         @"Пироги с капустой", @"Пироги с курицей",  nil];
    
    NSArray * arrayText = [NSArray arrayWithObjects:
                           @"Накануне майских праздников для всех клиентов нашего ресторана скидка 10%! на мясные пироги до конца месяца.",
                           @"При заказе на сумму более 2500 р вы получаете скидку в 20% на пирог с картошкой.",
                           @"Каждую пятницу действует скидка 50% на все пироги с капустой.",
                           @"При заказе двух пирогов с курицей вы получаете третий бесплатно! Акция действует до конца месяца.", nil];

    for (int i = 0; i < arrayImageName.count; i++) {
        
        NSDictionary * dictOrder = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [arrayImageName objectAtIndex:i], @"imageName",
                                    [arrayTitleText objectAtIndex:i], @"titleText",
                                    [arrayText objectAtIndex:i], @"text", nil];
        
        [arrayOrder addObject:dictOrder];
    }
    
    return arrayOrder;
}


@end
