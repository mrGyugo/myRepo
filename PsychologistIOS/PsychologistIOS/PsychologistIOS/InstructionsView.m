//
//  InstructionsView.m
//  PsychologistIOS
//
//  Created by Viktor on 13.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "InstructionsView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SingleTone.h"

@interface InstructionsView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation InstructionsView
{
    UITableView * mainTableView;
    NSMutableArray * mainArray;
}

- (instancetype)initWithView: (UIView*) view
                    andArray: (NSMutableArray*) array
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        mainArray = array;
        
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 40) style:UITableViewStylePlain];
        //Убираем полосы разделяющие ячейки------------------------------
        mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        mainTableView.backgroundColor = [UIColor clearColor];
        mainTableView.dataSource = self;
        mainTableView.delegate = self;
        mainTableView.showsVerticalScrollIndicator = NO;
        mainTableView.scrollEnabled = NO;
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
    [cell addSubview:[self setTableCellWithTitle:[dictCell objectForKey:@"title"]]];
    
    return cell;
}


#pragma mark - UITableViewDelegate

//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary * dictArray = [mainArray objectAtIndex:indexPath.row];
    [[SingleTone sharedManager] setTitleInstruction:[dictArray objectForKey:@"title"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_INSTRUCTIONS_WITH_INSTRUCTION_DETAILS object:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isiPhone5) {
        return 50;
    } else {
        return 56;
    }
}

#pragma mark - CustomCell

//Кастомная ячейка---------------------------------------
- (UIView*) setTableCellWithTitle: (NSString*) title
{
    //Основное окно ячейки--------------------------------
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 56)];
    if (isiPhone5) {
        cellView.frame = CGRectMake(0, 0, self.frame.size.width, 50);
    }
    cellView.backgroundColor = nil;
    
    //Заголовок-------------------------------------------
    UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(48, 16, 200, 24)];
    labelTitle.text = title;
    labelTitle.textColor = [UIColor colorWithHexString:@"323131"];
    labelTitle.font = [UIFont fontWithName:FONTLITE size:19];
    if (isiPhone5) {
        labelTitle.font = [UIFont fontWithName:FONTLITE size:16];
    }
    [cellView addSubview:labelTitle];
    
    //Стрелка перехода-----------------------------------
    UIImageView * imageArrow = [[UIImageView alloc] initWithFrame:CGRectMake(cellView.frame.size.width - 32, 16, 8, 16)];
    imageArrow.image = [UIImage imageNamed:@"arrowImgeCell.png"];
    [cellView addSubview:imageArrow];
    
    //Граница ячейки--------------------------------------
    UIView * viewBorder = [[UIView alloc] initWithFrame:CGRectMake(16, 55, cellView.frame.size.width - 32, 1)];
    if (isiPhone5) {
        viewBorder.frame = CGRectMake(16, 49, cellView.frame.size.width - 32, 1);
    }
    viewBorder.backgroundColor = [UIColor colorWithHexString:@"d9d9d9"];
    [cellView addSubview:viewBorder];
    
    return cellView;

}

@end
