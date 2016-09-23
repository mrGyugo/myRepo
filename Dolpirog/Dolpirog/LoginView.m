//
//  LoginView.m
//  FlowersOnline
//
//  Created by Viktor on 30.04.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "LoginView.h"
#import "InputTextView.h"
#import "ButtonMenu.h"
#import "Macros.h"

@implementation LoginView
{
    UIScrollView * mainScrollView;
    CGFloat widthScroll;
    UIImageView * imageViewLogo;
    UILabel * labelTitle;
}

- (instancetype)initBackGroundWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        UIImageView * imageBackGround = [[UIImageView alloc] initWithFrame:self.frame];
        imageBackGround.image = [UIImage imageNamed:@"background2.png"];
        [self addSubview:imageBackGround];
    }
    return self;
}

- (instancetype)initContentWithView: (UIView*) view
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        mainScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        mainScrollView.scrollEnabled = NO;
        mainScrollView.showsHorizontalScrollIndicator = NO;
        mainScrollView.contentSize = CGSizeMake(self.frame.size.width * 2, 0);
        mainScrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        [self addSubview:mainScrollView];
        
        widthScroll = self.frame.size.width;
        
#pragma mark - LOGIN
        
        //Создание лого--------------
        imageViewLogo = [[UIImageView alloc] initWithFrame: CGRectMake(widthScroll + (self.frame.size.width / 2 - 150), 130, 300, 98)];
        if (isiPhone5) {
            imageViewLogo.frame = CGRectMake(widthScroll + (self.frame.size.width / 2 - 140), 110, 280, 91);
        } else if (isiPhone4s) {
            imageViewLogo.frame = CGRectMake(widthScroll + (self.frame.size.width / 2 - 140), 30, 280, 91);
        }
        imageViewLogo.image = [UIImage imageNamed:@"logo.png"];
        imageViewLogo.alpha = 0.6;
        [mainScrollView addSubview:imageViewLogo];
        
        //Массивы с данными для логина-------------
        NSArray * arrayImageName = [NSArray arrayWithObjects:@"UserNameImage.png", @"PasswordImage.png", nil];
        NSArray * arrayName = [NSArray arrayWithObjects:@"Имя", @"Пароль", nil];
        
        //Создание полей ввода текста----
        for (int i = 0; i < arrayImageName.count; i++) {
            InputTextView * inputText = [[InputTextView alloc] initWithView:self PointY:460 + 76 * i andImage:[arrayImageName objectAtIndex:i] andTextPlaceHolder:[arrayName objectAtIndex:i] andScrollWidth:widthScroll];
            if ([[arrayName objectAtIndex:i] isEqualToString:@"Пароль"]) {
                inputText.textFieldInput.secureTextEntry = YES;
            }
            if (isiPhone6) {
                inputText.height = 400 + 76 * i;
            } else if (isiPhone5) {
                inputText.height = 320 + 66 * i;
            } else if (isiPhone4s) {
                inputText.height = 230 + 66 * i;
            }
            [mainScrollView addSubview:inputText];
        }
        
        //Создание кнопки----------------
        UIButton * buttonComeIn = [ButtonMenu createButtonRegistrationWithName:@"Войти" andColor:COLORGREEN andPointY:612 andView:self];
        if (isiPhone6) {
            CGRect rect6 = buttonComeIn.frame;
            rect6.origin.y = 552;
            rect6.origin.x += widthScroll;
            buttonComeIn.frame = rect6;
        } else if (isiPhone5) {
            CGRect rect5 = buttonComeIn.frame;
            rect5.origin.y = 452;
            rect5.origin.x += widthScroll;
            buttonComeIn.frame = rect5;
        } else if (isiPhone4s) {
            CGRect rect4 = buttonComeIn.frame;
            rect4.origin.y = 372;
            rect4.origin.x += widthScroll;
            buttonComeIn.frame = rect4;
        } else {
            CGRect rect7 = buttonComeIn.frame;
            rect7.origin.x += widthScroll;
            buttonComeIn.frame = rect7;
        }
        [buttonComeIn addTarget:self action:@selector(buttonComeInAction) forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:buttonComeIn];
        
        //Содание кнопки регистрация------
        UIButton * buttonRegistration =[ButtonMenu createButtonTextWithName:@"Регистрация" andFrame:CGRectMake(20, 695, 100, 20) fontName:FONTREGULAR];
        if (isiPhone6) {
            CGRect rect6 = buttonRegistration.frame;
            rect6.origin.y = 635;
            rect6.origin.x += widthScroll;
            buttonRegistration.frame = rect6;
        } else if (isiPhone5) {
            CGRect rect5 = buttonRegistration.frame;
            rect5.origin.y = 525;
            rect5.origin.x += widthScroll;
            buttonRegistration.frame = rect5;
        } else if (isiPhone4s) {
            CGRect rect4 = buttonRegistration.frame;
            rect4.origin.y = 445;
            rect4.origin.x += widthScroll;
            buttonRegistration.frame = rect4;
        } else {
            CGRect rect7 = buttonRegistration.frame;
            rect7.origin.x += widthScroll;
            buttonRegistration.frame = rect7;
        }
        buttonRegistration.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [buttonRegistration addTarget:self action:@selector(buttonRegistrationAction) forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:buttonRegistration];
        
        //Создание кнопки Нужна помощ----
        UIButton * buttonNeedHelp = [ButtonMenu createButtonTextWithName:@"Нужна помощ" andFrame:CGRectMake(self.frame.size.width - 120, 695, 100, 20) fontName:FONTREGULAR];
        if (isiPhone6) {
            CGRect rect6 = buttonNeedHelp.frame;
            rect6.origin.y = 635;
            rect6.origin.x += widthScroll;
            buttonNeedHelp.frame = rect6;
        } else if (isiPhone5) {
            CGRect rect5 = buttonNeedHelp.frame;
            rect5.origin.y = 525;
            rect5.origin.x += widthScroll;
            buttonNeedHelp.frame = rect5;
        } else if (isiPhone4s) {
            CGRect rect4 = buttonNeedHelp.frame;
            rect4.origin.y = 445;
            rect4.origin.x += widthScroll;
            buttonNeedHelp.frame = rect4;
        } else {
            CGRect rect7 = buttonNeedHelp.frame;
            rect7.origin.x += widthScroll;
            buttonNeedHelp.frame = rect7;
        }
        buttonNeedHelp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [buttonNeedHelp addTarget:self action:@selector(buttonNeedHelpAction) forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:buttonNeedHelp];
        
        
#pragma mark - REGISTRATION
        
        labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 150, 110, 300, 123)];
        if (isiPhone5) {
            labelTitle.frame = CGRectMake(self.frame.size.width / 2 - 140, 60, 280, 130);
        } else if (isiPhone4s) {
            labelTitle.frame = CGRectMake(self.frame.size.width / 2 - 140, 30, 280, 130);
        }
        labelTitle.text = @"СОЗДАТЬ АККАУНТ";
        labelTitle.textColor = [UIColor whiteColor];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        labelTitle.font = [UIFont fontWithName:FONTBOND size:24];
        [mainScrollView addSubview:labelTitle];
        
        //Массивы с данными для логина-------------
        NSArray * arrayImageNameReg = [NSArray arrayWithObjects:@"nameImageReg.png", @"emailImageReg.png", @"PasswordImage.png", nil];
        NSArray * arrayNameReg = [NSArray arrayWithObjects:@"Имя", @"Email", @"Пароль", nil];
        
        //Создание полей ввода текста при регистрации----
        for (int i = 0; i < arrayImageNameReg.count; i++) {
            InputTextView * inputTextReg = [[InputTextView alloc] initWithView:self PointY:360 + 76 * i andImage:[arrayImageNameReg objectAtIndex:i] andTextPlaceHolder:[arrayNameReg objectAtIndex:i] andScrollWidth:0];
            if ([[arrayNameReg objectAtIndex:i] isEqualToString:@"Пароль"]) {
                inputTextReg.textFieldInput.secureTextEntry = YES;
            }
            if (isiPhone6) {
                inputTextReg.height = 300 + 76 * i;
            } else if (isiPhone5) {
                inputTextReg.height = 230 + 66 * i;
            } else if (isiPhone4s) {
                inputTextReg.height = 170 + 66 * i;
            }
            [mainScrollView addSubview:inputTextReg];
        }
        
        if (isiPhone4s) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLogoStart) name:UITextFieldTextDidBeginEditingNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLogoEnd) name:UITextFieldTextDidEndEditingNotification object:nil];
        }
        
        //Создание кнопки----------------
        UIButton * buttonNext = [ButtonMenu createButtonRegistrationWithName:@"Продолжить" andColor:COLORBROWN andPointY:612 andView:self];
        if (isiPhone6) {
            CGRect rect6 = buttonNext.frame;
            rect6.origin.y = 552;
            buttonNext.frame = rect6;
        } else if (isiPhone5) {
            CGRect rect5 = buttonNext.frame;
            rect5.origin.y = 452;
            buttonNext.frame = rect5;
        } else if (isiPhone4s) {
            CGRect rect4 = buttonNext.frame;
            rect4.origin.y = 380;
            buttonNext.frame = rect4;
        }
        [buttonNext addTarget:self action:@selector(buttonNextAction) forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:buttonNext];
        
        //Содание кнопки регистрация------
        UIButton * buttonLicAgreement =[ButtonMenu createButtonTextWithName:@"Лицензионное соглашение" andFrame:CGRectMake(20, 695, self.frame.size.width - 40, 20) fontName:FONTREGULAR];
        if (isiPhone6) {
            CGRect rect6 = buttonLicAgreement.frame;
            rect6.origin.y = 635;
            buttonLicAgreement.frame = rect6;
        } else if (isiPhone5) {
            CGRect rect5 = buttonLicAgreement.frame;
            rect5.origin.y = 525;
            buttonLicAgreement.frame = rect5;
        } else if (isiPhone4s) {
            CGRect rect4 = buttonLicAgreement.frame;
            rect4.origin.y = 450;
            buttonLicAgreement.frame = rect4;
        }
        [buttonLicAgreement addTarget:self action:@selector(buttonLicAgreementAction) forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:buttonLicAgreement];
        
        
        
        
    }
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - ActionMethods

- (void) buttonComeInAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_VIEW_PUSH_BOUQUETS_CONTROLLER object:nil];
}

- (void) buttonRegistrationAction
{
   [UIView animateWithDuration:0.5 animations:^{
       mainScrollView.contentOffset = CGPointMake(0, 0);
   } completion:^(BOOL finished) {
   }];
}

- (void) buttonNeedHelpAction
{
    NSLog(@"buttonNeedHelpAction");
}

- (void) buttonNextAction
{
    [UIView animateWithDuration:0.5 animations:^{
        mainScrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    } completion:^(BOOL finished) {
    }];
}

- (void) buttonLicAgreementAction
{
    NSLog(@"buttonLicAgreementAction");
}

- (void) animationLogoStart
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rectLogo = imageViewLogo.frame;
        rectLogo.origin.y -= 100;
        imageViewLogo.frame = rectLogo;
        CGRect rectLabel = labelTitle.frame;
        rectLabel.origin.y -= 100;
        labelTitle.frame = rectLabel;
    }];

}

- (void) animationLogoEnd
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rectLogo = imageViewLogo.frame;
        rectLogo.origin.y += 100;
        imageViewLogo.frame = rectLogo;
        CGRect rectLabel = labelTitle.frame;
        rectLabel.origin.y += 100;
        labelTitle.frame = rectLabel;
    }];

}

@end
