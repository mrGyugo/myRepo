//
//  InstructionDetailsController.m
//  PsychologistIOS
//
//  Created by Viktor on 13.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "InstructionDetailsController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "SingleTone.h"
#import "InstructionDetailsView.h"

@implementation InstructionDetailsController

- (void) viewDidLoad {
    
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:[[SingleTone sharedManager] titleInstruction]];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
#pragma mark - Initialization
    
    //Основной вью контент------------------------------------
    InstructionDetailsView * viewContent = [[InstructionDetailsView alloc] initWithView:self.view];
    [self.view addSubview:viewContent];
}

@end
