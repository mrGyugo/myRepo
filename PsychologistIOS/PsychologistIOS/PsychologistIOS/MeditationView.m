//
//  MeditationView.m
//  PsychologistIOS
//
//  Created by Viktor on 12.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "MeditationView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@interface MeditationView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MeditationView
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
        
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.frame.size.width, self.frame.size.height - 40) style:UITableViewStylePlain];
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
    return mainArray.count;
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
    
    [cell addSubview:[self setTableCellWithTitle:[dictCell objectForKey:@"title"] andSubTitle:[dictCell objectForKey:@"subTitle"] andText:[dictCell objectForKey:@"text"]]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 144;
}

#pragma mark - Custom Cell

//Кастомная ячейка---------------------------------------
- (UIView*) setTableCellWithTitle: (NSString*) title
                      andSubTitle: (NSString*) subTitle
                         andText: (NSString*) text

{
    //Основное окно ячейки--------------------------------
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 144)];
    cellView.backgroundColor = nil;
    
    //Заголовок--------------------------------------------
    UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 200, 24)];
    labelTitle.text = title;
    labelTitle.textColor = [UIColor blackColor];
    labelTitle.font = [UIFont fontWithName:FONTREGULAR size:15];
    [cellView addSubview:labelTitle];
    
    //Подзаголовок---------------------------------------
    UILabel * labelSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 32, 200, 16)];
    labelSubTitle.text = subTitle;
    labelSubTitle.textColor = [UIColor colorWithHexString:@"393a35"];
    labelSubTitle.font = [UIFont fontWithName:FONTBOND size:11];
    [cellView addSubview:labelSubTitle];
    
    //Основной текст-------------------------------------
    UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(16, 48, cellView.frame.size.width - 32, 48)];
    labelText.numberOfLines = 0;
    labelText.text = text;
    labelText.textColor = [UIColor colorWithHexString:@"393a35"];
    labelText.font = [UIFont fontWithName:FONTLITE size:11];
    [cellView addSubview:labelText];
    
    //Временная картинка до появления аудиоплеера---------
    //Заменить на реальную логику, картинкой музыку не послушаешь ))
    UIImageView * imageViewPlayer = [[UIImageView alloc] initWithFrame:CGRectMake(16, 96, cellView.frame.size.width - 32, 32)];
    if (isiPhone5) {
        imageViewPlayer.frame = CGRectMake(16, 96, cellView.frame.size.width - 32, 20);
    }
    imageViewPlayer.image = [UIImage imageNamed:@"playerImage.png"];
    [cellView addSubview:imageViewPlayer];
    
    //Граница ячейки--------------------------------------
    UIView * viewBorder = [[UIView alloc] initWithFrame:CGRectMake(16, 143, cellView.frame.size.width - 32, 1)];
    viewBorder.backgroundColor = [UIColor colorWithHexString:@"c0c0c0"];
    [cellView addSubview:viewBorder];
    
    
    
    return cellView;
}



@end
