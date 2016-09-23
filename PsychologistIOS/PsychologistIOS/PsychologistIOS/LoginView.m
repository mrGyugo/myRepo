//
//  LoginView.m
//  PsychologistIOS
//
//  Created by Viktor on 31.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "LoginView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SingleTone.h"
#import "AlertClass.h"

@implementation LoginView
{
    
    UIScrollView * mainScrollView;
    
    UITextField * textFieldPhone;
    UITextField * textFieldSMS;
    UILabel * labelPlaceHolderPhone;
    UILabel * labelPlaceHoldSMS;
    
    UITextField * textFieldEmail;
    UILabel * labelPlaceHoldEmail;
    
    BOOL isBool;
    BOOL isBoolSMS;
    BOOL isBoolMail;
    
    BOOL isPhoneOrEmail;
    BOOL boolButton;
    
    UIView * viewPhone;
    UIView * viewSMS;
    UIView * viewEmail;
    UIButton * buttonLogin;
    UIButton * buttonInput;
    
    NSString * stringPhone;
    NSString * stringEmail;
}

- (instancetype)initButtonLogin
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(16, 520, 382, 64);
        if (isiPhone6) {
            self.frame = CGRectMake(16, 460, 382, 56);
        } else if (isiPhone5) {
            self.frame = CGRectMake(0, 400, 320, 48);
        }
        
        if (isiPhone4s) {
            self.frame = CGRectMake(0, 335, 320, 48);
        }
        
        boolButton = YES;
        
        
        //Кнопка меню---------------------------------------------------------------------
        buttonInput = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonInput.frame = CGRectMake(0, 0, 382, 64);
        buttonInput.backgroundColor = [UIColor colorWithHexString:@"48709d"];
        buttonInput.layer.borderColor = [UIColor whiteColor].CGColor;
        buttonInput.layer.cornerRadius = 30;
        [buttonInput setTitle:@"ВОЙТИ" forState:UIControlStateNormal];
        [buttonInput setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonInput.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:17];
        if (isiPhone6) {
            buttonInput.frame = CGRectMake(self.frame.size.width / 2 - 170 - 16, 0, 340, 56);
            buttonInput.layer.cornerRadius = 28;
        } else if (isiPhone5) {
            buttonInput.frame = CGRectMake(self.frame.size.width / 2 - 140, 0, 280, 46);
            buttonInput.layer.cornerRadius = 23;
            buttonInput.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:15];
        }
        [buttonInput addTarget:self action:@selector(buttonInputAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonInput];
        
        
        //Кнопка входа---------------------------------------------------------------------
        buttonLogin = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonLogin.frame = CGRectMake(0, 0, 382, 64);
        buttonLogin.backgroundColor = [UIColor colorWithHexString:@"3cc354"];
        buttonLogin.layer.borderColor = [UIColor whiteColor].CGColor;
        buttonLogin.layer.cornerRadius = 30;
        [buttonLogin setTitle:@"ПОЛУЧИТЬ КОД" forState:UIControlStateNormal];
        [buttonLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonLogin.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:17];
        if (isiPhone6) {
            buttonLogin.frame = CGRectMake(self.frame.size.width / 2 - 170 - 16, 0, 340, 56);
            buttonLogin.layer.cornerRadius = 28;
        } else if (isiPhone5) {
            buttonLogin.frame = CGRectMake(self.frame.size.width / 2 - 140, 0, 280, 46);
            buttonLogin.layer.cornerRadius = 23;
            buttonLogin.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:15];
        }
        [buttonLogin addTarget:self action:@selector(buttonLoginAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonLogin];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAnimationMethodButton:) name:NOTIFICATION_LOGIN_VIEW_ANIMATION_BUTTON object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testMethod:) name:@"NotificationTestBool" object:nil];
    }
    return self;
}

- (instancetype)initWithBackgroundView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        //Основной фон---------------------
        UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:self.frame];
        mainImageView.image = [UIImage imageNamed:@"mainFone.png"];
        [self addSubview:mainImageView];
    }
    return self;
}


- (instancetype)initWithContentView: (UIView*) view
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        isBool = YES;
        isBoolSMS = YES;
        isBoolMail = YES;
        isPhoneOrEmail = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAnimationMethod) name:NOTIFICATION_LOGIN_VIEW_ANIMATION object:nil];
        
        mainScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        [self addSubview:mainScrollView];
        
        //Массив картинок-------------------
        NSArray * arrayImage = [NSArray arrayWithObjects:@"VK.png", @"facebook.png", @"Email.png", nil];
        
        //Вью ввода телефона----------------
        viewPhone = [[UIView alloc] initWithFrame:CGRectMake(16, 440, self.frame.size.width - 32, 64)];
        if (isiPhone6) {
            viewPhone.frame = CGRectMake(16, 390, self.frame.size.width - 32, 56);
        } else if (isiPhone5) {
            viewPhone.frame = CGRectMake(20, 340, self.frame.size.width - 40, 48);
        }
        
        if (isiPhone4s) {
            viewPhone.frame = CGRectMake(20, 280, self.frame.size.width - 40, 48);
        }
        viewPhone.backgroundColor = [UIColor colorWithHexString:@"a04c43"];
        viewPhone.layer.borderColor = [UIColor colorWithHexString:@"e18c82"].CGColor;
        viewPhone.layer.borderWidth = 0.4f;
        viewPhone.layer.cornerRadius = 5;
        [mainScrollView addSubview:viewPhone];
        
        //Ввод телефона-----------------------------------------------------------------
        textFieldPhone = [[UITextField alloc] initWithFrame:CGRectMake(24, 0, viewPhone.frame.size.width - 48, viewPhone.frame.size.height)];
        textFieldPhone.delegate = self;
        textFieldPhone.tag = 257;
        textFieldPhone.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textFieldPhone.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldPhone.font = [UIFont fontWithName:FONTLITE size:19];
        if (isiPhone6) {
            textFieldPhone.font = [UIFont fontWithName:FONTLITE size:18];
        } else if (isiPhone5) {
            textFieldPhone.font = [UIFont fontWithName:FONTLITE size:16];
        }
        textFieldPhone.textColor = [UIColor colorWithHexString:@"b3b3b4"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelPhone:) name:UITextFieldTextDidChangeNotification object:textFieldPhone];
        [viewPhone addSubview:textFieldPhone];
        
        //Плэйс холдер телефона----------------------------------------------------------
        labelPlaceHolderPhone = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, viewPhone.frame.size.width - 48, viewPhone.frame.size.height)];
        labelPlaceHolderPhone.tag = 3022;
        labelPlaceHolderPhone.text = @"Телефон";
        labelPlaceHolderPhone.textColor = [UIColor colorWithHexString:@"b3b3b4"];
        labelPlaceHolderPhone.font = [UIFont fontWithName:FONTLITE size:19];
        if (isiPhone6) {
            labelPlaceHolderPhone.font = [UIFont fontWithName:FONTLITE size:18];
        } else if (isiPhone5) {
            labelPlaceHolderPhone.font = [UIFont fontWithName:FONTLITE size:16];
        }
        [viewPhone addSubview:labelPlaceHolderPhone];
        
        //Вью ввода СМС----------------
        viewSMS = [[UIView alloc] initWithFrame:CGRectMake(800, 440, self.frame.size.width - 32, 64)];
        if (isiPhone6) {
            viewSMS.frame = CGRectMake(800, 390, self.frame.size.width - 32, 56);
        } else if (isiPhone5) {
            viewSMS.frame = CGRectMake(800, 340, self.frame.size.width - 40, 48);
        }
        
        if (isiPhone4s) {
            viewSMS.frame = CGRectMake(800, 280, self.frame.size.width - 40, 48);
        }
        viewSMS.backgroundColor = [UIColor colorWithHexString:@"a04c43"];
        viewSMS.layer.borderColor = [UIColor colorWithHexString:@"e18c82"].CGColor;
        viewSMS.layer.borderWidth = 0.4f;
        viewSMS.layer.cornerRadius = 5;
        [mainScrollView addSubview:viewSMS];
        
        //Ввод смс-----------------------------------------------------------------
        textFieldSMS = [[UITextField alloc] initWithFrame:CGRectMake(24, 0, viewPhone.frame.size.width - 48, viewPhone.frame.size.height)];
        textFieldSMS.delegate = self;
        textFieldSMS.tag = 120;
        textFieldSMS.keyboardType = UIKeyboardTypeDefault;
        textFieldSMS.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldSMS.font = [UIFont fontWithName:FONTLITE size:19];
        if (isiPhone6) {
            textFieldSMS.font = [UIFont fontWithName:FONTLITE size:18];
        } else if (isiPhone5) {
            textFieldSMS.font = [UIFont fontWithName:FONTLITE size:16];
        }
        textFieldSMS.textColor = [UIColor colorWithHexString:@"b3b3b4"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelSMS:) name:UITextFieldTextDidChangeNotification object:textFieldSMS];
        [viewSMS addSubview:textFieldSMS];
        
        //Плесхолдер СМС-------------------------------------------------------------------
        labelPlaceHoldSMS = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, viewPhone.frame.size.width - 48, viewPhone.frame.size.height)];
        labelPlaceHoldSMS.tag = 3021;
        labelPlaceHoldSMS.text = @"Введите код";
        labelPlaceHoldSMS.textColor = [UIColor colorWithHexString:@"b3b3b4"];
        labelPlaceHoldSMS.font = [UIFont fontWithName:FONTLITE size:19];
        if (isiPhone6) {
            labelPlaceHoldSMS.font = [UIFont fontWithName:FONTLITE size:18];
        } else if (isiPhone5) {
            labelPlaceHoldSMS.font = [UIFont fontWithName:FONTLITE size:16];
        }
        [viewSMS addSubview:labelPlaceHoldSMS];
        
        //Вью ввода Почты----------------
        viewEmail = [[UIView alloc] initWithFrame:CGRectMake(800, 440, self.frame.size.width - 32, 64)];
        if (isiPhone6) {
            viewEmail.frame = CGRectMake(800, 390, self.frame.size.width - 32, 56);
        } else if (isiPhone5) {
            viewEmail.frame = CGRectMake(800, 340, self.frame.size.width - 40, 48);
        }
        
        if (isiPhone4s) {
            viewEmail.frame = CGRectMake(800, 280, self.frame.size.width - 40, 48);
        }
        viewEmail.backgroundColor = [UIColor colorWithHexString:@"a04c43"];
        viewEmail.layer.borderColor = [UIColor colorWithHexString:@"e18c82"].CGColor;
        viewEmail.layer.borderWidth = 0.4f;
        viewEmail.layer.cornerRadius = 5;
        [mainScrollView addSubview:viewEmail];
        
        //Ввод Почты-----------------------------------------------------------------
        textFieldEmail = [[UITextField alloc] initWithFrame:CGRectMake(24, 0, viewPhone.frame.size.width - 48, viewPhone.frame.size.height)];
        textFieldEmail.delegate = self;
        textFieldEmail.tag = 473;
        textFieldEmail.keyboardType = UIKeyboardTypeDefault;
        textFieldEmail.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldEmail.font = [UIFont fontWithName:FONTLITE size:19];
        if (isiPhone6) {
            textFieldEmail.font = [UIFont fontWithName:FONTLITE size:18];
        } else if (isiPhone5) {
            textFieldEmail.font = [UIFont fontWithName:FONTLITE size:16];
        }
        textFieldEmail.textColor = [UIColor colorWithHexString:@"b3b3b4"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelEmail:) name:UITextFieldTextDidChangeNotification object:textFieldEmail];
        [viewEmail addSubview:textFieldEmail];
        
        //Плесхолдер Email-------------------------------------------------------------------
        labelPlaceHoldEmail = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, viewPhone.frame.size.width - 48, viewPhone.frame.size.height)];
        labelPlaceHoldEmail.tag = 3021;
        labelPlaceHoldEmail.text = @"Введите E-mail";
        labelPlaceHoldEmail.textColor = [UIColor colorWithHexString:@"b3b3b4"];
        labelPlaceHoldEmail.font = [UIFont fontWithName:FONTLITE size:19];
        if (isiPhone6) {
            labelPlaceHoldEmail.font = [UIFont fontWithName:FONTLITE size:18];
        } else if (isiPhone5) {
            labelPlaceHoldEmail.font = [UIFont fontWithName:FONTLITE size:16];
        }
        [viewEmail addSubview:labelPlaceHoldEmail];
        
        //Лейбл возможности регистрации другим путем---------------------------------------
        UILabel * labelOtherInput = [[UILabel alloc] initWithFrame:CGRectMake(0, viewPhone.frame.size.height + viewPhone.frame.origin.y + 96, self.frame.size.width, 16)];
        labelOtherInput.text = @"ВОЙТИ ЧЕРЕЗ АККАУНТ";
        labelOtherInput.textColor = [UIColor whiteColor];
        labelOtherInput.textAlignment = NSTextAlignmentCenter;
        labelOtherInput.font = [UIFont fontWithName:FONTREGULAR size:15.6];
        if (isiPhone6) {
            labelOtherInput.frame = CGRectMake(0, viewPhone.frame.size.height + viewPhone.frame.origin.y + 86, self.frame.size.width, 16);
            labelOtherInput.font = [UIFont fontWithName:FONTREGULAR size:14.6];
        } else if (isiPhone5) {
            labelOtherInput.frame = CGRectMake(0, viewPhone.frame.size.height + viewPhone.frame.origin.y + 65, self.frame.size.width, 16);
            labelOtherInput.font = [UIFont fontWithName:FONTREGULAR size:12.6];
        }
        
        if (isiPhone4s) {
            labelOtherInput.frame = CGRectMake(0, viewPhone.frame.size.height + viewPhone.frame.origin.y + 55, self.frame.size.width, 16);
        }
        
        [self addSubview:labelOtherInput];
        
        for (int i = 0; i < 3; i++) {
            UIButton * buttonOtherInput = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonOtherInput.frame = CGRectMake(150 + 60 * i, labelOtherInput.frame.origin.y + labelOtherInput.frame.size.height + 12, 56, 56);
            buttonOtherInput.layer.cornerRadius = 28;
            if (isiPhone6) {
                buttonOtherInput.frame = CGRectMake(136 + 52 * i, labelOtherInput.frame.origin.y + labelOtherInput.frame.size.height + 12, 48, 48);
                buttonOtherInput.layer.cornerRadius = 24;
            } else if (isiPhone5) {
                buttonOtherInput.frame = CGRectMake(117 + 48 * i, labelOtherInput.frame.origin.y + labelOtherInput.frame.size.height + 12, 40, 40);
                buttonOtherInput.layer.cornerRadius = 20;
            }
            
            if (isiPhone4s) {
                buttonOtherInput.frame = CGRectMake(117 + 48 * i, labelOtherInput.frame.origin.y + labelOtherInput.frame.size.height + 5, 40, 40);
            }
            UIImage *btnImage = [UIImage imageNamed:[arrayImage objectAtIndex:i]];
            [buttonOtherInput setImage:btnImage forState:UIControlStateNormal];
            buttonOtherInput.tag = 10 + i;
            [buttonOtherInput addTarget:self action:@selector(buttonOtherInputAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:buttonOtherInput];
            
            if (i == 2) {
                //Скрываем вход через почту
                buttonOtherInput.alpha = 0.f;
            }
        }
        
        //Кнопка условия лицензионного соглашения
        UIButton * buttonLicense = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonLicense.frame = CGRectMake(self.frame.size.width / 2 - 76, labelOtherInput.frame.size.height + labelOtherInput.frame.origin.y + 72, 152, 24);
        [buttonLicense setTitle:@"Условия соглашения" forState:UIControlStateNormal];
        [buttonLicense setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonLicense.tag = 386;
        buttonLicense.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:13];
        if (isiPhone6) {
            buttonLicense.frame = CGRectMake(self.frame.size.width / 2 - 76, labelOtherInput.frame.size.height + labelOtherInput.frame.origin.y + 66, 152, 24);
        } else if (isiPhone5) {
            buttonLicense.frame = CGRectMake(self.frame.size.width / 2 - 76, labelOtherInput.frame.size.height + labelOtherInput.frame.origin.y + 52, 152, 24);
            buttonLicense.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:11];
        }
        
        if (isiPhone4s) {
            buttonLicense.frame = CGRectMake(self.frame.size.width / 2 - 76, labelOtherInput.frame.size.height + labelOtherInput.frame.origin.y + 42, 152, 24);
        }
        
        [self addSubview:buttonLicense];
        
        
        
    }
    return self;
}

#pragma mark - UITextFieldDelegate

//Скрытие клавиатуры----------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//Метод ввода тоьлко чисел-----------------------------------
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    /* for backspace */
    if([string length]==0){
        return YES;
    }
    
    /*  limit to only numeric characters  */
    
    if ([textField isEqual:textFieldPhone]) {
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if ([myCharSet characterIsMember:c]) {
                
                
                /*  limit the users input to only 9 characters  */
                NSUInteger newLength = [textField.text length] + [string length] - range.length;
                return (newLength > 12) ? NO : YES;
            }
        }
        return NO;
    } else if ([textField isEqual:textFieldSMS]){
        /*  limit the users input to only 9 characters  */
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 5) ? NO : YES;
    } else if ([textField isEqual:textFieldEmail]) {
        /*  limit the users input to only 9 characters  */
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 30) ? NO : YES;
    }
    
    return NO;
}

//Анимация Лейблов при вводе Телефона------------------------
- (void) animationLabelPhone: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    
    if (testField.text.length < 3) {
        testField.text = @"+7";
    }
    
    
    if (testField.text.length != 0 && isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderPhone.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderPhone.frame = rect;
            labelPlaceHolderPhone.alpha = 0.f;
            isBool = NO;
        }];
    } else if (testField.text.length == 0 && !isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderPhone.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderPhone.frame = rect;
            labelPlaceHolderPhone.alpha = 1.f;
            isBool = YES;
        }];
    }
}

//Анимация Лейблов при вводе SMS-------------------------
- (void) animationLabelSMS: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    if (testField.text.length != 0 && isBoolSMS) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHoldSMS.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHoldSMS.frame = rect;
            labelPlaceHoldSMS.alpha = 0.f;
            isBoolSMS = NO;
        }];
    } else if (testField.text.length == 0 && !isBoolSMS) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHoldSMS.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHoldSMS.frame = rect;
            labelPlaceHoldSMS.alpha = 1.f;
            isBoolSMS = YES;
        }];
    }
}

- (void) animationLabelEmail: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    if (testField.text.length != 0 && isBoolMail) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHoldEmail.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHoldEmail.frame = rect;
            labelPlaceHoldEmail.alpha = 0.f;
            isBoolMail = NO;
        }];
    } else if (testField.text.length == 0 && !isBoolMail) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHoldEmail.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHoldEmail.frame = rect;
            labelPlaceHoldEmail.alpha = 1.f;
            isBoolMail = YES;
        }];
    }
}

//Поднимаем текст вверх--------------------------------------
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:textFieldPhone]) {
        if ([textField.text isEqualToString:@""]) {
            textField.text = @"+7";
            if (textField.text.length != 0 && isBool) {
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect rect;
                    rect = labelPlaceHolderPhone.frame;
                    rect.origin.x = rect.origin.x + 100.f;
                    labelPlaceHolderPhone.frame = rect;
                    labelPlaceHolderPhone.alpha = 0.f;
                    isBool = NO;
                }];
            }
            
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        

        if (isiPhone4s) {
            mainScrollView.contentOffset = (CGPoint){
                0, // ось x нас не интересует
                100 // Скроллим скролл к верхней границе текстового поля - Вы можете настроить эту величину по своему усмотрению
            };
        } else {
        
        if (isiPhone5) {
            mainScrollView.contentOffset = (CGPoint){
                0, // ось x нас не интересует
                60 // Скроллим скролл к верхней границе текстового поля - Вы можете настроить эту величину по своему усмотрению
            };
        } else {
        mainScrollView.contentOffset = (CGPoint){
            0, // ось x нас не интересует
            30 // Скроллим скролл к верхней границе текстового поля - Вы можете настроить эту величину по своему усмотрению
        };
            
            
            
        }
        }
    }];

    textField.textAlignment = NSTextAlignmentLeft;
}

//Восстанавливаем стандартный размер-----------------------
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:textFieldPhone]) {
        if ([textField.text isEqualToString:@"+7"]) {
            textField.text = @"";
            if (textField.text.length == 0 && !isBool) {
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect rect;
                    rect = labelPlaceHolderPhone.frame;
                    rect.origin.x = rect.origin.x - 100.f;
                    labelPlaceHolderPhone.frame = rect;
                    labelPlaceHolderPhone.alpha = 1.f;
                    isBool = YES;
                }];
            }
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
            mainScrollView.contentOffset = (CGPoint){0, 0}; // Возвращаем скролл в начало, так как редактирование текстового поля закончено
    }];
    textField.textAlignment = NSTextAlignmentCenter;
}

//Отвязка от всех нотификаций------------------------------
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Buttons Methods

- (void) buttonOtherInputAction: (UIButton*) button
{
        if (button.tag == 10) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"VKN" object:nil];
        } else if (button.tag == 11) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FaceBookN" object:nil];
        } else if (button.tag == 12) {
        
            
            [UIView animateWithDuration:0.3 animations:^{
                
                if (isPhoneOrEmail) {
                    CGRect rectPhone = viewPhone.frame;
                    rectPhone.origin.x -= 500;
                    viewPhone.frame = rectPhone;
                    
                    CGRect rectSMS = viewSMS.frame;
                    rectSMS.origin.x -= 784;
                    viewEmail.frame = rectSMS;
                    
                    isPhoneOrEmail = NO;
                } else {
                    CGRect rectPhone = viewPhone.frame;
                    rectPhone.origin.x += 500;
                    viewPhone.frame = rectPhone;
                    
                    CGRect rectSMS = viewSMS.frame;
                    rectSMS.origin.x += 784;
                    viewEmail.frame = rectSMS;
                    
                    isPhoneOrEmail = YES;
                    
                    
                }
                
            } completion:^(BOOL finished) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationTestBool" object:[NSNumber numberWithBool:isPhoneOrEmail]];
                
            }];
            
        } else {
            NSLog(@"Error");
        }
}


- (void) buttonLoginAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_VIEW_ANIMATION object:nil];
    if (boolButton) {
        if (stringPhone.length == 12) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SEND_SMS_CODE object:stringPhone];
        }
    } else {
        if (stringEmail.length != 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SEND_EMAIL_CODE object:stringEmail];
        }
    }
    
}

- (void) buttonInputAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_VIEW_PUSH_MAIN_VIEW object:nil];
}

- (void) notificationAnimationMethod
{
    if (textFieldEmail.text.length != 0 || textFieldPhone.text.length == 12) {
        NSDictionary * dictNotf = [NSDictionary dictionaryWithObjectsAndKeys:textFieldPhone.text, @"textPhone", textFieldEmail.text, @"textEmail", nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_VIEW_ANIMATION_BUTTON object:nil userInfo:dictNotf];
        
        [UIView animateWithDuration:0.5 animations:^{
            if (isPhoneOrEmail) {
                CGRect rectPhone = viewPhone.frame;
                rectPhone.origin.x -= 500;
                viewPhone.frame = rectPhone;
            } else {
                CGRect rectPhone = viewEmail.frame;
                rectPhone.origin.x -= 500;
                viewEmail.frame = rectPhone;
            }
            
            CGRect rectSMS = viewSMS.frame;
            rectSMS.origin.x -= 784;
            viewSMS.frame = rectSMS;
            
            
            
        }];
    } else {
        [AlertClass showAlertViewWithMessage:@"Введите верное колличество символов"];
    }

}

- (void) notificationAnimationMethodButton: (NSNotification*) notification
{
    [UIView transitionFromView:buttonLogin
                        toView:buttonInput
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    completion:nil];
    
    
    stringPhone = [notification.userInfo objectForKey:@"textPhone"];
    stringEmail = [notification.userInfo objectForKey:@"textEmail"];
    
    
    
}

- (void) testMethod: (NSNotification*) notification
{
    boolButton = [notification.object boolValue];
}

@end
