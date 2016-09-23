//
//  DevelopersController.m
//  PsychologistIOS
//
//  Created by Виктор Мишустин on 19.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "DevelopersController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SWRevealViewController.h"

@interface DevelopersController ()

@end

@implementation DevelopersController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark - Header
    
    self.navigationController.navigationBarHidden = NO;
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"РАЗРАБОТЧИКИ"];
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
    
#pragma mark - Initialization
    //Фоновая картинка--------------------
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundView.image = [UIImage imageNamed:@"fonSubImage.png"];
    [self.view addSubview:backgroundView];
    
    //Фоновая картинка--------------------
    UIView * mainLogoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    mainLogoView.backgroundColor = [UIColor colorWithHexString:@"eb9285"];
    [self.view addSubview:mainLogoView];
    UIImageView * imageViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(60, 0, self.view.frame.size.width - 140, 40)];
    imageViewLogo.image = [UIImage imageNamed:@"logo.png"];
    [self.view addSubview:imageViewLogo];
    
    UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, self.view.frame.size.width - 20, 400)];
    labelText.numberOfLines = 0;
    labelText.text = @"Мы превратим вашу идею в успешный и популярный мобильный сервис, который принесет прибыль\n\n\nНаши специалисты готовы предоставить вам консультацию по любым вопросам, связанным с разработкой мобильных приложений, помочь с выбором необходимого вам приложения и определением его функциональных параметров, предоставить готовые решения для вашего бизнеса!";
    labelText.textColor = [UIColor blackColor];
    labelText.font = [UIFont fontWithName:FONTREGULAR size:16];
    [self.view addSubview:labelText];
    
    //Кнопка Рекомендую--------------------------------------
    UIButton * buttonRecommend = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonRecommend.frame = CGRectMake(24, 530, self.view.frame.size.width - 48, 48);
    buttonRecommend.backgroundColor = nil;
    buttonRecommend.layer.cornerRadius = 25;
    buttonRecommend.layer.borderColor = [UIColor colorWithHexString:@"eb9285"].CGColor;
    buttonRecommend.layer.borderWidth = 1.f;
    [buttonRecommend setTitle:@"ПОДРОБНО" forState:UIControlStateNormal];
    [buttonRecommend setTitleColor:[UIColor colorWithHexString:@"eb9285"] forState:UIControlStateNormal];
    buttonRecommend.titleLabel.font = [UIFont fontWithName:FONTLITE size:16];
    if (isiPhone6) {
        buttonRecommend.frame = CGRectMake(24, 495, self.view.frame.size.width - 48, 40);
        buttonRecommend.layer.cornerRadius = 20;
    } else if (isiPhone5 ) {
        buttonRecommend.frame = CGRectMake(30, 425, self.view.frame.size.width - 60, 34);
        buttonRecommend.layer.cornerRadius = 17;
        buttonRecommend.titleLabel.font = [UIFont fontWithName:FONTLITE size:14];
    }
    [buttonRecommend addTarget:self action:@selector(buttonSite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRecommend];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) buttonSite
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://apptrends.ru"]];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
