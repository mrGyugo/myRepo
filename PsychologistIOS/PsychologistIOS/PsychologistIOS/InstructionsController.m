//
//  InstructionsController.m
//  PsychologistIOS
//
//  Created by Viktor on 13.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "InstructionsController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SWRevealViewController.h"
#import "TitleClass.h"
#import "InstructionsModel.h"
#import "InstructionsView.h"
#import "InstructionDetailsController.h"

@implementation InstructionsController

- (void) viewDidLoad {
    
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ИНСТРУКЦИЯ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    //Пареметры кнопки меню------------------------------------
    UIImage *imageBarButton = [UIImage imageNamed:@"menuIcon.png"];
    [_buttonMenu setImage:imageBarButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 32, 24);
    CGRect rect = button.frame;
    rect.origin.y += 16;
    button.frame = rect;
    [button setImage:imageBarButton forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _buttonMenu.customView=button;
    //    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
#pragma mark - Initiliztion    
    InstructionsView * contentView = [[InstructionsView alloc] initWithView:self.view andArray:[InstructionsModel setArrayJuri]];
    [self.view addSubview:contentView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPushInstructionDetails) name:NOTIFICATION_PUSH_INSTRUCTIONS_WITH_INSTRUCTION_DETAILS object:nil];

}

#pragma mark - DEALLOC
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action Methods

- (void) notificationPushInstructionDetails
{
    InstructionDetailsController * details = [self.storyboard instantiateViewControllerWithIdentifier:@"InstructionDetailsController"];
    [self.navigationController pushViewController:details animated:YES];
}

@end
