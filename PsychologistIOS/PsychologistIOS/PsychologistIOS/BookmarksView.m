//
//  BookmarksView.m
//  PsychologistIOS
//
//  Created by Viktor on 12.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "BookmarksView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SingleTone.h"
#import "StringImage.h"
#import "ViewSectionTable.h"
#import "TextMethodClass.h"
#import "APIGetClass.h"

@interface BookmarksView () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@end

@implementation BookmarksView
{
    NSMutableArray * mainArray;
    NSMutableArray * filteredContentList;
    BOOL isSearching;
     NSDictionary* dictResponse;
    
    UITableView * mainTableView;
    NSDictionary * dictInform;
    UISearchBar * mainSearchBar;
}

- (instancetype)initWithBackgroundView: (UIView*) view
{
    self = [super init];
    if (self) {
        //Фоновая картинка--------------------
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:self.frame];
        backgroundView.image = [UIImage imageNamed:@"fonAlpha.png"];
        [self addSubview:backgroundView];
    }
    return self;
}


- (instancetype)initWithContent: (UIView*) view andArray: (NSArray*) array
{
    self = [super init];
    if (self) {
        
        //Основной контент---------------------
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        mainArray = [NSMutableArray arrayWithArray:array];
        
        dictResponse = [NSDictionary new];
        
        //Вью поиска---------------------------
        UIView * viewSearch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 40)];
        viewSearch.backgroundColor = [UIColor colorWithHexString:@"eb9285"];
        [self addSubview:viewSearch];
        
        //Окно поиска--------------------------
        mainSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 240, 24)];
        mainSearchBar.center = viewSearch.center;
        mainSearchBar.backgroundImage = [UIImage imageNamed:@"Search1.png"];
        mainSearchBar.layer.cornerRadius = 10;
        mainSearchBar.placeholder = @"Поиск по категориям";
        mainSearchBar.searchBarStyle = UISearchBarStyleDefault;
        mainSearchBar.barTintColor = [UIColor colorWithHexString:@"eb9285"];
        mainSearchBar.tintColor = [UIColor redColor];
        mainSearchBar.showsBookmarkButton = NO;
        mainSearchBar.showsCancelButton = NO;
        mainSearchBar.showsScopeBar = NO;
        mainSearchBar.showsSearchResultsButton = NO;
        mainSearchBar.delegate = self;
        mainSearchBar.enablesReturnKeyAutomatically = NO;
        [viewSearch addSubview:mainSearchBar];
        
        mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 40) style:UITableViewStylePlain];
        if (isiPhone6) {
            mainTableView.frame = CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 40);
        } else if (isiPhone5) {
            mainTableView.frame = CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 40);
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
    if (isSearching) {
        if([filteredContentList isEqual: [NSNull null]]){
            return 0;
        }else{
            return filteredContentList.count;
        }
        
    }
    else {
        return mainArray.count;
    }
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
    
    
    
    NSDictionary * dictCell;
    
    
    if (isSearching) {
        NSLog(@"DICTS %li",filteredContentList.count);
        
        
        if (filteredContentList.count !=0) {
            dictCell = [filteredContentList objectAtIndex:indexPath.row];
            NSString * type;
            if ([[dictCell objectForKey:@"type"] isEqualToString:@"post"]) {
                type = @"Тема";
            } else if ([[dictCell objectForKey:@"type"] isEqualToString:@"subcategory"]) {
                type = @"Категория";
            } else if ([[dictCell objectForKey:@"type"] isEqualToString:@"category"]) {
                type = @"Раздел";
            } else {
                type = @"";
            }
            
            
            dictInform = [dictCell objectForKey:@"inform"];
            NSString * stringURL = [StringImage createStringImageURLWithString:[dictInform objectForKey:@"media_path"]];
            [cell.contentView addSubview:[self setTableCellWithTitle:[dictInform objectForKey:@"title"]
                                                         andSubTitle:[dictInform objectForKey:@"description"]
                                                            andImage:stringURL
                                                            andTrial:nil
                                                      andNotifiction:nil
                                                             andType:type]];
            
            
        } else {
            NSLog(@"Нет категорий");
        }
        
        
    }else{
        dictCell = [mainArray objectAtIndex:indexPath.row];
        if (mainArray.count != 0) {
            
            NSString * type;
            if ([[dictCell objectForKey:@"type"] isEqualToString:@"post"]) {
                type = @"Тема";
            } else if ([[dictCell objectForKey:@"type"] isEqualToString:@"subcategory"]) {
                type = @"Категория";
            } else if ([[dictCell objectForKey:@"type"] isEqualToString:@"category"]) {
                type = @"Раздел";
            } else {
                type = @"";
            }
            
            
            dictInform = [dictCell objectForKey:@"inform"];
            NSString * stringURL = [StringImage createStringImageURLWithString:[dictInform objectForKey:@"media_path"]];
            [cell.contentView addSubview:[self setTableCellWithTitle:[dictInform objectForKey:@"title"]
                                                         andSubTitle:[dictInform objectForKey:@"description"]
                                                            andImage:stringURL
                                                            andTrial:nil
                                                      andNotifiction:nil
                                                             andType:type]];
            
            
        } else {
            NSLog(@"Нет категорий");
        }
    }
    
    
         

    

 
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete && !isSearching) {
        NSDictionary * dictCell;
    
            dictCell = [mainArray objectAtIndex:indexPath.row];
        
      
//        NSLog(@"%@", dictCell);
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DELET_CELL_BOOKMARK object:nil userInfo:dictCell];

          
              [mainArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
        
      
        
    }
    [tableView endUpdates];
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
    NSDictionary * dictCell = [mainArray objectAtIndex:indexPath.row];
    
//    NSLog(@"%@", [dictCell objectForKey:@"type"]);
    
    if ([[dictCell objectForKey:@"type"] isEqualToString:@"post"]) {
        NSDictionary * dictSubject = [dictCell objectForKey:@"inform"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_BOOKMARK_SUBJECT object:nil userInfo:dictSubject];
        [[SingleTone sharedManager] setIdentifierSubjectModel:[dictSubject objectForKey:@"id"]];
        [[SingleTone sharedManager] setTitleSubject:[dictSubject objectForKey:@"title"]];
        NSLog(@"dictCell тема %@", dictCell);
    } else if ([[dictCell objectForKey:@"type"] isEqualToString:@"subcategory"]) {
        NSDictionary * dictSubCategory = [dictCell objectForKey:@"inform"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_BOOKMARK_SUB_CATEGORY object:nil userInfo:dictSubCategory];
//        NSLog(@"%@", [dictSubCategory objectForKey:@"id"]);
        [[SingleTone sharedManager] setIdentifierSubCategory:[dictSubCategory objectForKey:@"id"]];
        [[SingleTone sharedManager] setTitleSubCategory:[dictSubCategory objectForKey:@"title"]];
        NSLog(@"dictCell категория %@", dictCell);
    } else if ([[dictCell objectForKey:@"type"] isEqualToString:@"category"]) {
        NSDictionary * dictCategory = [dictCell objectForKey:@"inform"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_BOOKMARK_CATEGORY object:nil userInfo:dictCategory];
        [[SingleTone sharedManager] setIdentifierCategory:[dictCategory objectForKey:@"id"]];
        [[SingleTone sharedManager] setTitleCategory:[dictCategory objectForKey:@"title"]];
        
    } else {
        NSLog(@"Error");
    }
    
//    [[SingleTone sharedManager] setTitleSubject:[dictInform objectForKey:@"title"]];
//    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_BOOKMARKS_WITH_OPENSUBJECT object:[dictCell objectForKey:@"title"]];
    
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
                   andNotifiction: (NSNumber*) notific
                          andType: (NSString*) type
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
    UIView * imageViewCategory = [[UIView alloc] initWithFrame:CGRectMake(16, 10, 96, 96)];
    imageViewCategory.layer.cornerRadius = 0.5;
    if (isiPhone6) {
        imageViewCategory.frame = CGRectMake(12, 11, 88, 88);
    } else if (isiPhone5) {
        imageViewCategory.frame = CGRectMake(12, 11, 80, 80);
    }
    
    ViewSectionTable * viewSectionTable = [[ViewSectionTable alloc] initWithImageURL:image andView:nil andContentMode:UIViewContentModeScaleAspectFill];
    [imageViewCategory addSubview:viewSectionTable];
    
    
    [cellView addSubview:imageViewCategory];
    
    //Заголовок-------------------------------------------
    UILabel * labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(136, 10, 216, 24)];
    NSString * myString = string;
    labelTitle.text = myString;
    labelTitle.numberOfLines = 0;
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
    
//    //Тип----------------------------------------
//    UILabel * labelType = [[UILabel alloc] initWithFrame:CGRectMake(136, 16 + labelSubTitle.frame.size.height + labelSubTitle.frame.origin.y, 216, 16)];
//    labelType.text = type;
//    labelType.textColor = [UIColor colorWithHexString:@"676766"];
//    labelType.numberOfLines = 0;
//    labelType.font = [UIFont fontWithName:FONTLITE size:16];
//    if (isiPhone6) {
//        labelType.frame = CGRectMake(120, 16 + labelTitle.frame.size.height + labelSubTitle.frame.origin.y, 216, 16);
//        labelType.font = [UIFont fontWithName:FONTLITE size:15];
//    } else if (isiPhone5) {
//        labelType.frame = CGRectMake(100, 20 + labelTitle.frame.size.height + labelSubTitle.frame.origin.y, 216, 16);
//        labelType.font = [UIFont fontWithName:FONTLITE size:12];
//    }
//    [cellView addSubview:labelType];
    
    //Граница ячейки--------------------------------------
    UIView * viewBorder = [[UIView alloc] initWithFrame:CGRectMake(16, 127, cellView.frame.size.width - 32, 1)];
    if (isiPhone6) {
        viewBorder.frame = CGRectMake(16, 111, cellView.frame.size.width - 32, 1);
    } else if (isiPhone5) {
        viewBorder.frame = CGRectMake(16, 99, cellView.frame.size.width - 32, 1);
    }
    viewBorder.backgroundColor = [UIColor colorWithHexString:@"c0c0c0"];
    [cellView addSubview:viewBorder];
    
    //Стрелка перехода------------------------------------
    UIImageView * arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(cellView.frame.size.width - 48, 40, 16, 48)];
    if (isiPhone6) {
        arrowImage.frame = CGRectMake(cellView.frame.size.width - 48, cellView.frame.size.height / 2 - 24, 16, 48);
    } else if (isiPhone5) {
        arrowImage.frame = CGRectMake(cellView.frame.size.width - 40, cellView.frame.size.height / 2 - 20, 13, 40);
    }
    arrowImage.image = [UIImage imageNamed:@"arrowImage.png"];
    [cellView addSubview:arrowImage];
    
    return cellView;
}

#pragma mark - Action Methods


//Действие кнопки продлить доступ
- (void) buttonBuyTrialActiob
{
    NSLog(@"Продлить доступ");
}


- (void)searchTableList {
    NSString *searchString = mainSearchBar.text;
    NSLog(@"ПОИСК");
    
    [self getAPIWithSearch:searchString andBlock:^{
        //Remove all objects first.
        filteredContentList = [dictResponse objectForKey:@"data"];
        
        isSearching = YES;
        [mainTableView reloadData];
    }];
    
}

- (void) getAPIWithSearch: (NSString *) search andBlock: (void (^)(void))block
{
    NSLog(@"Serch %@",search);

    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [[SingleTone sharedManager] userID] , @"id_user",
                             search, @"search", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"show_fav_search" complitionBlock:^(id response) {
        
        dictResponse = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"SEARCH %@:",response);
            block();
        }
    }];
}



- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d",isSearching);
    
    //Remove all objects first.
    
    
    if([searchText length] > 2) {
        
        [self searchTableList];
        
    }
    else {
        isSearching = NO;
        [mainTableView reloadData];
    }
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");
    //    [mainSearchBar resignFirstResponder];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
    [mainSearchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [mainSearchBar resignFirstResponder];
}


@end
