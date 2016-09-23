//
//  GalleryDetailsController.m
//  mykamchatka
//
//  Created by Viktor on 18.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "GalleryDetailsController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "SingleTone.h"
#import "GallaryDetailsView.h"

@implementation GalleryDetailsController

#pragma mark - Title

- (void) viewDidLoad {
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithLiteTitle:@"ГАЛЕРЕЯ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"b3ddf4"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;

#pragma mark - Initialization  
    
    //Подключаем фон-------------------------------------------
    GallaryDetailsView * gallaryDetailsViewBackGround = [[GallaryDetailsView alloc] initBackgroundWithView:self.view];
    [self.view addSubview:gallaryDetailsViewBackGround];
    
    //Подключаем картинку--------------------------------------
    GallaryDetailsView * gallaryDetailsViewImage = [[GallaryDetailsView alloc] initImageWithView:self.view andDict:[[SingleTone sharedManager] dictImage]];
    [self.view addSubview:gallaryDetailsViewImage];
    

}

@end
