//
//  InputTextView.m
//  FlowersOnline
//
//  Created by Viktor on 02.05.16.
//  Copyright © 2016 datastore24. All rights reserved.
//

#import "InputTextView.h"
#import "CustomTextField.h"

@implementation InputTextView
{
//    CustomTextField * textFieldInput;
    UILabel * labelPlaceHoldInput;
    UIView * mainView;
    BOOL keyboardUp;
}



- (instancetype)initWithView: (UIView*) view
                      PointY: (CGFloat) pointY
                    andImage: (NSString*) imageName
          andTextPlaceHolder: (NSString*) placeHolder
              andScrollWidth: (CGFloat) scrollWidth
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(20 + scrollWidth, pointY, view.frame.size.width - 40, 60);
        self.layer.cornerRadius = 30.f;
        if (isiPhone5 || isiPhone4s) {
            self.frame = CGRectMake(20 + scrollWidth, pointY, view.frame.size.width - 40, 50);
            self.layer.cornerRadius = 25.f;
        }
        self.backgroundColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.5];
        keyboardUp = NO;
        
        mainView = view;
        
        //Картинка объекта--------
        UIImageView * imageViewInput = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
        imageViewInput.image = [UIImage imageNamed:imageName];
        imageViewInput.alpha = 0.5;
        [imageViewInput sizeThatFits:CGSizeMake(40, 40)];
        if (isiPhone5 || isiPhone4s) {
            imageViewInput.frame = CGRectMake(20, 7.5, 35, 35);
            [imageViewInput sizeThatFits:CGSizeMake(35, 35)];
        }
        [self addSubview:imageViewInput];
        
        //Ввод текста-------------
        self.textFieldInput = [[CustomTextField alloc] initWithFrame:CGRectMake(70, 0, self.frame.size.width - 70, 60)];
        if (isiPhone5 || isiPhone4s) {
            self.textFieldInput.frame = CGRectMake(70, 0, self.frame.size.width - 70, 50);
        }
        self.textFieldInput.delegate = self;
        self.textFieldInput.isBoll = YES;
        self.textFieldInput.keyboardType = UIKeyboardTypeDefault;
        self.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textFieldInput.font = [UIFont fontWithName:FONTREGULAR size:17];
        self.textFieldInput.textColor = [UIColor whiteColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabel:) name:UITextFieldTextDidChangeNotification object:self.textFieldInput];
        [self addSubview:self.textFieldInput];
        
        //Плесхолдер --------------
        labelPlaceHoldInput = [[UILabel alloc] initWithFrame:self.textFieldInput.frame];
        labelPlaceHoldInput.text = placeHolder;
        labelPlaceHoldInput.textColor = [UIColor whiteColor];
        labelPlaceHoldInput.font = [UIFont fontWithName:FONTREGULAR size:17];
        [self addSubview:labelPlaceHoldInput];
        
    }
    return self;
}


- (instancetype)initCheckoutWithView: (UIView*) view
                              PointY: (CGFloat) pointY
                  andTextPlaceHolder: (NSString*) placeHolder
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(20, pointY, view.frame.size.width - 40, 40);
        self.layer.borderColor = [UIColor colorWithHexString:COLORGREEN].CGColor;
        self.layer.borderWidth = 1.f;
        if (isiPhone5 || isiPhone4s) {
            self.frame = CGRectMake(20, pointY, view.frame.size.width - 40, 30);

        }
        keyboardUp = NO;
        
        mainView = view;
        
        //Ввод текста-------------
        self.textFieldInput = [[CustomTextField alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width - 70, 40)];
        if (isiPhone5 || isiPhone4s) {
            self.textFieldInput.frame = CGRectMake(10, 0, self.frame.size.width - 70, 30);
        }
        self.textFieldInput.delegate = self;
        self.textFieldInput.isBoll = YES;
        self.textFieldInput.tag = 90;
        self.textFieldInput.keyboardType = UIKeyboardTypeDefault;
        self.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textFieldInput.font = [UIFont fontWithName:FONTREGULAR size:17];
        self.textFieldInput.textColor = [UIColor colorWithHexString:COLORTEXTGRAY];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabel:) name:UITextFieldTextDidChangeNotification object:self.textFieldInput];
        [self addSubview:self.textFieldInput];
        
        //Плесхолдер --------------
        labelPlaceHoldInput = [[UILabel alloc] initWithFrame:self.textFieldInput.frame];
        labelPlaceHoldInput.text = placeHolder;
        labelPlaceHoldInput.textColor = [UIColor colorWithHexString:COLORTEXTGRAY];
        labelPlaceHoldInput.font = [UIFont fontWithName:FONTREGULAR size:17];
        [self addSubview:labelPlaceHoldInput];
        
    }
    return self;
}

- (instancetype)initCustonTextViewWithRect: (CGRect) rect
                        andTextPlaceHolder: (NSString*) placeHolder
                           andCornerRadius: (CGFloat) cornerRadius
                                   andView: (UIView*) view
                                  fonColor: (NSString*) bgColor
                              andTextColor: (NSString*) textColor
{
    self = [super init];
    if (self) {
        self.frame = rect;
        self.layer.cornerRadius = cornerRadius;
        self.backgroundColor = [UIColor colorWithHexString:bgColor];


        keyboardUp = NO;
        
        mainView = view;
        
        //Ввод текста-------------
        self.textFieldInput = [[CustomTextField alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width - 70, self.frame.size.height)];
        if (isiPhone5 || isiPhone4s) {
            self.textFieldInput.frame = CGRectMake(10, 0, self.frame.size.width - 70, 30);
        }
        self.textFieldInput.delegate = self;
        self.textFieldInput.isBoll = YES;
        self.textFieldInput.tag = 90;
        self.textFieldInput.keyboardType = UIKeyboardTypeDefault;
        self.textFieldInput.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textFieldInput.font = [UIFont fontWithName:FONTREGULAR size:15];
        self.textFieldInput.textColor = [UIColor colorWithHexString:textColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabel:) name:UITextFieldTextDidChangeNotification object:self.textFieldInput];
        [self addSubview:self.textFieldInput];
        
        //Плесхолдер --------------
        labelPlaceHoldInput = [[UILabel alloc] initWithFrame:self.textFieldInput.frame];
        labelPlaceHoldInput.text = placeHolder;
        labelPlaceHoldInput.textColor = [UIColor colorWithHexString:textColor];
        labelPlaceHoldInput.font = [UIFont fontWithName:FONTREGULAR size:15];
        [self addSubview:labelPlaceHoldInput];
    }
    return self;
}



- (void) setHeight:(CGFloat)height
{
    CGRect myRect = self.frame;
    myRect.origin.y = height;
    self.frame = myRect;
}

#pragma mark - UITextFieldDelegate

//Скрытие клавиатуры----------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//Анимация Лейблов при вводе SMS-------------------------
- (void) animationLabel: (NSNotification*) notification
{
    CustomTextField * testField = notification.object;
    if (testField.text.length != 0 && testField.isBoll) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect rect;
            rect = labelPlaceHoldInput.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHoldInput.frame = rect;
            labelPlaceHoldInput.alpha = 0.f;
            testField.isBoll = NO;
        }];
    } else if (testField.text.length == 0 && !testField.isBoll) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect;
            rect = labelPlaceHoldInput.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHoldInput.frame = rect;
            labelPlaceHoldInput.alpha = 1.f;
            testField.isBoll = YES;
        }];
    }
}

//Поднимаем текст вверх--------------------------------------
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 90) {
        
    } else {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect rectAnimation = mainView.frame;
            rectAnimation.origin.y -= 90;
        mainView.frame = rectAnimation;
    } completion:^(BOOL finished) {
    }];
    }
}

//Восстанавливаем стандартный размер-----------------------
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 90) {
        
    } else {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect rectAnimation = mainView.frame;
            rectAnimation.origin.y += 90;
        mainView.frame = rectAnimation;
    } completion:^(BOOL finished) {
    }];
    }
}


//Отвязка от всех нотификаций------------------------------
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
