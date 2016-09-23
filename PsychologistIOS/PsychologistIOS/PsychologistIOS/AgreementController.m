//
//  AgreementController.m
//  PsychologistIOS
//
//  Created by Виктор Мишустин on 03.06.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "AgreementController.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "TitleClass.h"
#import "SingleTone.h"

@interface AgreementController ()

@end

@implementation AgreementController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"СОГЛАШЕНИЕ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    UIScrollView * mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:mainScrollView];
    
    UILabel * labelTint = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 30)];
    labelTint.text = @"Условия использования “To be a woman”";
    labelTint.textAlignment = NSTextAlignmentCenter;
    labelTint.font = [UIFont fontWithName:FONTBOND size:13];
    [mainScrollView addSubview:labelTint];
    
    UILabel * labelOnePurt = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, self.view.frame.size.width - 20, 10)];
    labelOnePurt.numberOfLines = 0;
    labelOnePurt.text = [[SingleTone sharedManager] rules];
    labelOnePurt.font = [UIFont fontWithName:FONTREGULAR size:13];
    [labelOnePurt sizeToFit];
    [mainScrollView addSubview:labelOnePurt];
    
    mainScrollView.contentSize = CGSizeMake(0, labelOnePurt.frame.size.height + 70 + 80);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
