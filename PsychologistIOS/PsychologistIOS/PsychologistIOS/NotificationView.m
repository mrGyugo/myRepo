//
//  NotificationView.m
//  PsychologistIOS
//
//  Created by Viktor on 16.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "NotificationView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@interface NotificationView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation NotificationView
{
    UITableView * mainTableView;
    NSMutableArray * mainArray;
}

- (instancetype)initWithView: (UIView*) view andArray: (NSMutableArray*) array
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        
        mainArray = array;
        
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
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
        return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = nil;
    
    NSDictionary * dictTable = [mainArray objectAtIndex:indexPath.row];
    
    [cell addSubview:[self setTableCellWithName:[dictTable objectForKey:@"Name"]
                                      andAction:[dictTable objectForKey:@"Action"]
                                       andThemr:[dictTable objectForKey:@"Thema"]
                                        andTime:[dictTable objectForKey:@"Time"]]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

#pragma mark - CustomCell

//Кастомная ячейка---------------------------------------
- (UIView*) setTableCellWithName: (NSString*) name
                      andAction: (NSString*) action
                         andThemr: (NSString*) theme
                         andTime: (NSString*) time
{
    //Основное окно ячейки--------------------------------
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 128)];
    cellView.backgroundColor = nil;
    
    //Лейбл прозвища-------------------------------------
    UILabel * nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 24, 20, 16)];
    nickNameLabel.text = name;
    nickNameLabel.textColor = [UIColor colorWithHexString:@"d46458"];
    nickNameLabel.font = [UIFont fontWithName:FONTBOND size:13];
    if (isiPhone5) {
        nickNameLabel.frame = CGRectMake(20, 24, 20, 16);
        nickNameLabel.font = [UIFont fontWithName:FONTBOND size:10];
    }
    [nickNameLabel sizeToFit];
    [cellView addSubview:nickNameLabel];
    
    //Текст действия--------------------------------------
    UILabel * labelTextAction = [[UILabel alloc] initWithFrame:CGRectMake(nickNameLabel.frame.origin.x + nickNameLabel.frame.size.width + 3, 24, 20, 16)];
    labelTextAction.text = action;
    labelTextAction.textColor = [UIColor colorWithHexString:@"333332"];
    labelTextAction.font = [UIFont fontWithName:FONTLITE size:13];
    if (isiPhone5) {
        labelTextAction.font = [UIFont fontWithName:FONTLITE size:10];
    }
    [labelTextAction sizeToFit];
    [cellView addSubview:labelTextAction];
    
    //Текст темы-----------------------------------------
    UILabel * labelTheme = [[UILabel alloc] initWithFrame:CGRectMake(40, 48, 20, 16)];
    labelTheme.text = theme;
    labelTheme.textColor = [UIColor colorWithHexString:@"333332"];
    labelTheme.font = [UIFont fontWithName:FONTBOND size:13];
    if (isiPhone5) {
        labelTheme.frame = CGRectMake(20, 48, 20, 16);
        labelTheme.font = [UIFont fontWithName:FONTBOND size:10];
    }
    [labelTheme sizeToFit];
    [cellView addSubview:labelTheme];
    
    //Лейбл Времени--------------------------------------
    UILabel * labelTime = [[UILabel alloc] initWithFrame:CGRectMake(labelTheme.frame.size.width + labelTheme.frame.origin.x + 2, 48, 20, 16)];
    if ([labelTheme.text isEqualToString:@""]) {
        labelTime.frame = CGRectMake(labelTextAction.frame.origin.x + labelTextAction.frame.size.width + 2, 24, 20, 16);
    }
    labelTime.text = time;
    labelTime.textColor = [UIColor colorWithHexString:@"a4a4a3"];
    labelTime.font = [UIFont fontWithName:FONTLITE size:13];
    if (isiPhone5) {
        labelTime.font = [UIFont fontWithName:FONTLITE size:10];
    }
    [labelTime sizeToFit];
    [cellView addSubview:labelTime];
    
    //Изображение нотификации-----------------------------
    UIImageView * notificationView = [[UIImageView alloc] initWithFrame:CGRectMake(cellView.frame.size.width - 72, 16, 56, 56)];
    notificationView.image = [UIImage imageNamed:@"notificationImage.png"];
    [cellView addSubview:notificationView];
    
    //Граница ячейки--------------------------------------
    UIView * viewBorder = [[UIView alloc] initWithFrame:CGRectMake(16, 87, cellView.frame.size.width - 32, 1)];
    viewBorder.backgroundColor = [UIColor colorWithHexString:@"c0c0c0"];
    [cellView addSubview:viewBorder];
    
    return cellView;
}

@end
