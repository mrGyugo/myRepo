//
//  MenuController.h
//  FlowersOnline
//
//  Created by Viktor on 29.04.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

//Основной класс меню отвечающий за навигацию в приложении, все объекты написанны кодом кроме основной таблицы навигации

#import <UIKit/UIKit.h>
#import "UIColor+HexColor.h"
#import "SWRevealViewController.h"
#import "Macros.h"
#import "CustomCellView.h"

@interface MenuController : UIViewController <UITableViewDataSource, UITableViewDelegate>

//Свойство основной таблицы
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
//Основной массив ячеек
@property (strong, nonatomic) NSArray * cellArray;
//Массив заголовков
@property (strong, nonatomic) NSArray * arrayTint;
//Массив картинок
@property (strong, nonatomic) NSArray * arrayImageMenu;



@end
