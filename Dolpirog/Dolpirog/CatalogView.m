//
//  CatalogView.m
//  Dolpirog
//
//  Created by Виктор Мишустин on 05/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "CatalogView.h"
#import "CustomLabels.h"
#import "Macros.h"

@interface CatalogView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView * mainTableView;
@property (strong, nonatomic) NSArray * arrayMain;

@end

@implementation CatalogView

- (instancetype)initWithView: (UIView*) view andDate: (NSMutableArray*) arrayDate
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        //create table
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, self.frame.size.width, 300)];
        if (isiPhone6) {
            _mainTableView.frame = CGRectMake(0, 170, self.frame.size.width, 300);
        } else if (isiPhone5) {
            _mainTableView.frame = CGRectMake(0, 140, self.frame.size.width, 300);
        } else if (isiPhone4s) {
            _mainTableView.frame = CGRectMake(0, 100, self.frame.size.width, 300);
        }
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.scrollEnabled = NO;
        [self addSubview:_mainTableView];
        
        
        _arrayMain = arrayDate;
    
        
        
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayMain.count;
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
    NSDictionary * dictCell = [_arrayMain objectAtIndex:indexPath.row];
    
    if (_arrayMain.count != 0) {
        [cell.contentView addSubview:[self setTableCellWithName:[dictCell objectForKey:@"name"]
                                                   andImageName:[dictCell objectForKey:@"imageName"]]];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFIVATION_CATALOG_VIEW_PUSH_CATALOG_DETAIL_CONTROLLER object:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46.f;
}

#pragma mark - CustomCell
//Кастомная ячейка---------------------------------------
- (UIView*) setTableCellWithName: (NSString*) name
                           andImageName: (NSString*) imageName
{
    //Основное окно ячейки--------------------------------
    UIView * cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 46)];
    cellView.backgroundColor = nil;
    
    //Изображение----------------------------------------
    UIImageView * imageCell = [[UIImageView alloc] initWithFrame:CGRectMake(40, 8, 30, 30)];
    if (isiPhone5 || isiPhone4s) {
        imageCell.frame = CGRectMake(40, 10, 26, 26);
    }
    imageCell.image = [UIImage imageNamed:imageName];
    [cellView addSubview:imageCell];
    
    //Текст ячейки---------------------------------------
    CustomLabels * labelCell = [[CustomLabels alloc] initLabelTableWithWidht:100 andHeight:2 andSizeWidht:cellView.frame.size.width - 150 andSizeHeight:46 andColor:COLORTEXTORANGE andText:name];
    labelCell.font = [UIFont fontWithName:FONTBOND size:15];
    if (isiPhone5 || isiPhone4s) {
        labelCell.frame = CGRectMake(90, 2, cellView.frame.size.width - 150, 46);
        labelCell.font = [UIFont fontWithName:FONTBOND size:13];
    }
    labelCell.textAlignment = NSTextAlignmentLeft;
    [cellView addSubview:labelCell];
    
    //Стрелка------------------------------------------
    UIImageView * imageArrowCell = [[UIImageView alloc] initWithFrame:CGRectMake(cellView.frame.size.width - 70, 10, 26, 26)];
    if (isiPhone5 || isiPhone4s) {
        imageArrowCell.frame = CGRectMake(cellView.frame.size.width - 50, 13, 20, 20);
    }
    imageArrowCell.image = [UIImage imageNamed:@"arrowImage.png"];
    [cellView addSubview:imageArrowCell];
    
    return cellView;
}


@end
