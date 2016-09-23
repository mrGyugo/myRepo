//
//  PersonalAreaView.m
//  PsychologistIOS
//
//  Created by Viktor on 14.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "PersonalAreaView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "SingleTone.h"

@interface PersonalAreaView () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation PersonalAreaView
{
//    UIScrollView * mainScrollView;
    
    NSMutableArray * arrayMCity;
    
    //Телефон---------------------
    UITextField * textFieldPhone;
    UILabel * labelPlaceHolderPhone;
    BOOL isBoolPhone;
    //Емаил------------------------
    UITextField * textFieldEmail;
    UILabel * labelPlaceHolderEmail;
    BOOL isBoolEmail;
    //НикНейм----------------------
    UITextField * textFieldviewNickName;
    UILabel * labelPlaceHolderNickName;
    BOOL isBoolNickName;
    //Город-----------------------
    UITextField * textFieldviewCity;
    UILabel * labelPlaceHolderCity;
    BOOL isBoolCity;
    
    UIButton * buttonCity;
    UILabel * labelButtonCity;
    
    //Алерт------------------------
    //Город------------------------
    UIView * darkView;
    UIView * alertViewPersonalArea;
    UIPickerView * pickerCity;
    NSArray * arrayCity;
    UITextField * textFieldAlertCity;
    UILabel * labelPlaceHolderAlertCity;
    BOOL isBoolAlertCity;
    
    //Дата-------------------------
    UIDatePicker * dataPicker;
    UIButton * buttonBirth;
    
    //Семейное положение-----------
    UIPickerView * maritalStatusPicker;
    NSArray * arrayMoterial;
    UIButton * buttonMaritalStatus;

}

- (instancetype)initWithView: (UIView*) view andDictionary: (NSDictionary*) dict
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        isBoolPhone = YES;
        isBoolEmail = YES;
        isBoolNickName = YES;
        isBoolAlertCity = YES;
        isBoolCity = YES;
        
        arrayMoterial = [NSArray arrayWithObjects:@"Замужем", @"Не замужем", @"В разводе", @"Не готова ответить", nil];
        
        //Телефон-----------
        //Вью для телефона------------------------------------------------
        UIView * viewPhone = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 164, 110, 328, 48)];
        viewPhone.layer.cornerRadius = 24.f;
        if (isiPhone6) {
            viewPhone.frame = CGRectMake(self.frame.size.width / 2 - 164, 110, 328, 48);
        } else if (isiPhone5) {
            viewPhone.frame = CGRectMake(self.frame.size.width / 2 - 140, 55, 280, 42);
            viewPhone.layer.cornerRadius = 21.f;
        }
        
        if (isiPhone4s) {
            viewPhone.frame = CGRectMake(self.frame.size.width / 2 - 140, 60, 280, 38);
            viewPhone.layer.cornerRadius = 19.f;
        }
        
        viewPhone.backgroundColor = [UIColor whiteColor];
        viewPhone.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        viewPhone.layer.borderWidth = 0.4f;
        [self addSubview:viewPhone];
        
        //Ввод телефона-----------------------------------------------------------------
        textFieldPhone = [[UITextField alloc] initWithFrame:CGRectMake(32, 0, viewPhone.frame.size.width - 64, viewPhone.frame.size.height)];
        textFieldPhone.delegate = self;
        
        textFieldPhone.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textFieldPhone.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldPhone.font = [UIFont fontWithName:FONTREGULAR size:22];
        if (isiPhone5) {
            textFieldPhone.font = [UIFont fontWithName:FONTREGULAR size:18];
        }
        textFieldPhone.textColor = [UIColor colorWithHexString:@"515050"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelPhone:) name:UITextFieldTextDidChangeNotification object:textFieldPhone];
        [viewPhone addSubview:textFieldPhone];
        
        //Плэйс холдер телефона----------------------------------------------------------
        labelPlaceHolderPhone = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, viewPhone.frame.size.width - 64, viewPhone.frame.size.height)];
        labelPlaceHolderPhone.text = @"Телефон";
        labelPlaceHolderPhone.textColor = [UIColor colorWithHexString:@"515050"];
        labelPlaceHolderPhone.font = [UIFont fontWithName:FONTREGULAR size:22];
        if (isiPhone5) {
            labelPlaceHolderPhone.font = [UIFont fontWithName:FONTREGULAR size:18];
        }
        
        if([dict objectForKey:@"phone"] != [NSNull null]){

            NSString *firstLetter = [[dict objectForKey:@"phone"] substringToIndex:1];
        
            if ([firstLetter isEqualToString:@"7"]) {
                if([dict objectForKey:@"phone"] != [NSNull null]){
                    if(![[dict objectForKey:@"phone"] isEqualToString:@""]){
                            textFieldPhone.text=[dict objectForKey:@"phone"];
                    }else{
                        [viewPhone addSubview:labelPlaceHolderPhone];
                    }
                    
                }else{
                    [viewPhone addSubview:labelPlaceHolderPhone];
                }
            } else {
                [viewPhone addSubview:labelPlaceHolderPhone];
            }
        }else{
          
          [viewPhone addSubview:labelPlaceHolderPhone];
        }
        
        
        
//        //Email-----------
//        //Вью для Email------------------------------------------------
//        UIView * viewEmail = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 164, viewPhone.frame.size.height + viewPhone.frame.origin.y + 16, 328, 48)];
//        viewEmail.layer.cornerRadius = 24.f;
//        if (isiPhone5) {
//                viewEmail.frame = CGRectMake(self.frame.size.width / 2 - 140, viewPhone.frame.size.height + viewPhone.frame.origin.y + 25, 280, 42);
//                viewEmail.layer.cornerRadius = 21.f;
//            }
//        if (isiPhone4s) {
//            viewEmail.frame = CGRectMake(self.frame.size.width / 2 - 140, viewPhone.frame.size.height + viewPhone.frame.origin.y + 12, 280, 38);
//            viewEmail.layer.cornerRadius = 19.f;
//        }
//        viewEmail.backgroundColor = [UIColor whiteColor];
//        viewEmail.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
//        viewEmail.layer.borderWidth = 0.4f;
//        [self addSubview:viewEmail];
//        
//        //Ввод Email-----------------------------------------------------------------
//        textFieldEmail = [[UITextField alloc] initWithFrame:CGRectMake(32, 0, viewPhone.frame.size.width - 64, viewPhone.frame.size.height)];
//        textFieldEmail.delegate = self;
//        textFieldEmail.keyboardType = UIKeyboardTypeURL;
//        textFieldEmail.autocorrectionType = UITextAutocorrectionTypeNo;
//        textFieldEmail.font = [UIFont fontWithName:FONTREGULAR size:20];
//        if (isiPhone5) {
//            textFieldEmail.font = [UIFont fontWithName:FONTREGULAR size:18];
//        }
//        textFieldEmail.textColor = [UIColor colorWithHexString:@"515050"];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelEmail:) name:UITextFieldTextDidChangeNotification object:textFieldEmail];
//        [viewEmail addSubview:textFieldEmail];
//        
//        //Плэйс холдер Email----------------------------------------------------------
//        labelPlaceHolderEmail = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, viewPhone.frame.size.width - 64, viewPhone.frame.size.height)];
//        labelPlaceHolderEmail.text = @"Введите Email";
//        labelPlaceHolderEmail.textColor = [UIColor colorWithHexString:@"515050"];
//        labelPlaceHolderEmail.font = [UIFont fontWithName:FONTREGULAR size:20];
//        if (isiPhone5) {
//            labelPlaceHolderEmail.font = [UIFont fontWithName:FONTREGULAR size:18];
//        }
//        
//        
//
//        if([dict objectForKey:@"email"] != [NSNull null]){
//          
//            if(![[dict objectForKey:@"email"] isEqualToString:@""]){
//                textFieldEmail.text=[dict objectForKey:@"email"];
//            }else{
//                [viewEmail addSubview:labelPlaceHolderEmail];
//            }
//        }else{
//            NSLog(@"EMPTY");
//            [viewEmail addSubview:labelPlaceHolderEmail];
//        }
        
        
        
        
        //NickName-----------
        //Вью для NickName------------------------------------------------
        UIView * viewNickName = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 164, viewPhone.frame.size.height + viewPhone.frame.origin.y + 16, 328, 48)];
        viewNickName.layer.cornerRadius = 24.f;
        if (isiPhone5) {
            viewNickName.frame = CGRectMake(self.frame.size.width / 2 - 140, viewPhone.frame.size.height + viewPhone.frame.origin.y + 12, 280, 42);
            viewNickName.layer.cornerRadius = 21.f;
        }
        
        if (isiPhone4s) {
            viewNickName.frame = CGRectMake(self.frame.size.width / 2 - 140, viewPhone.frame.size.height + viewPhone.frame.origin.y + 12, 280, 38);
            viewNickName.layer.cornerRadius = 19.f;
        }
        viewNickName.backgroundColor = [UIColor whiteColor];
        viewNickName.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        viewNickName.layer.borderWidth = 0.4f;
        [self addSubview:viewNickName];
        
        //Ввод NickName-----------------------------------------------------------------
        textFieldviewNickName = [[UITextField alloc] initWithFrame:CGRectMake(32, 0, viewPhone.frame.size.width - 64, viewPhone.frame.size.height)];
        textFieldviewNickName.delegate = self;
        textFieldviewNickName.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldviewNickName.font = [UIFont fontWithName:FONTREGULAR size:20];
        if (isiPhone5) {
            textFieldviewNickName.font = [UIFont fontWithName:FONTREGULAR size:18];
        }
        textFieldviewNickName.textColor = [UIColor colorWithHexString:@"515050"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelNickName:) name:UITextFieldTextDidChangeNotification object:textFieldviewNickName];
        [viewNickName addSubview:textFieldviewNickName];
    
        //Плэйс холдер NickName----------------------------------------------------------
        labelPlaceHolderNickName = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, viewPhone.frame.size.width - 64, viewPhone.frame.size.height)];
        labelPlaceHolderNickName.text = @"Ник";
        labelPlaceHolderNickName.textColor = [UIColor colorWithHexString:@"515050"];
        labelPlaceHolderNickName.font = [UIFont fontWithName:FONTREGULAR size:20];
        if (isiPhone5) {
            labelPlaceHolderNickName.font = [UIFont fontWithName:FONTREGULAR size:18];
        }
        if([dict objectForKey:@"name"] != [NSNull null]){
            if(![[dict objectForKey:@"name"] isEqualToString:@""]){
                textFieldviewNickName.text=[dict objectForKey:@"name"];
            }else{
                [viewNickName addSubview:labelPlaceHolderNickName];
            }
        }else{
           [viewNickName addSubview:labelPlaceHolderNickName];
        }
       
        
        //Город-----------
        //Вью для Город------------------------------------------------
        UIView * viewCity = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 164, viewNickName.frame.size.height + viewNickName.frame.origin.y + 16, 328, 48)];
        viewCity.layer.cornerRadius = 24.f;
        if (isiPhone5) {
            viewCity.frame = CGRectMake(self.frame.size.width / 2 - 140, viewNickName.frame.size.height + viewNickName.frame.origin.y + 12, 280, 42);
            viewCity.layer.cornerRadius = 21.f;
        }
        if (isiPhone4s) {
            viewCity.frame = CGRectMake(self.frame.size.width / 2 - 140, viewNickName.frame.size.height + viewNickName.frame.origin.y + 12, 280, 38);
            viewCity.layer.cornerRadius = 19.f;
        }
        viewCity.backgroundColor = [UIColor whiteColor];
        viewCity.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        viewCity.layer.borderWidth = 0.4f;
        [self addSubview:viewCity];
        
        //Ввод City-----------------------------------------------------------------
        textFieldviewCity = [[UITextField alloc] initWithFrame:CGRectMake(32, 0, viewPhone.frame.size.width - 64, viewPhone.frame.size.height)];
        textFieldviewCity.delegate = self;
        textFieldviewCity.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldviewCity.font = [UIFont fontWithName:FONTREGULAR size:20];
        if (isiPhone5) {
            textFieldviewCity.font = [UIFont fontWithName:FONTREGULAR size:18];
        }
        textFieldviewCity.textColor = [UIColor colorWithHexString:@"515050"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelCity:) name:UITextFieldTextDidChangeNotification object:textFieldviewCity];
        [viewCity addSubview:textFieldviewCity];
        
        //Плэйс холдер NickName----------------------------------------------------------
        labelPlaceHolderCity = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, viewPhone.frame.size.width - 64, viewPhone.frame.size.height)];
        labelPlaceHolderCity.text = @"Город";
        labelPlaceHolderCity.textColor = [UIColor colorWithHexString:@"515050"];
        labelPlaceHolderCity.font = [UIFont fontWithName:FONTREGULAR size:20];
        if (isiPhone5) {
            labelPlaceHolderCity.font = [UIFont fontWithName:FONTREGULAR size:18];
        }
        if([dict objectForKey:@"city"] != [NSNull null]){
            if(![[dict objectForKey:@"city"] isEqualToString:@""]){
                textFieldviewCity.text=[dict objectForKey:@"city"];
            }else{
                [viewCity addSubview:labelPlaceHolderCity];
            }
        }else{
            [viewCity addSubview:labelPlaceHolderCity];
        }
        
//        //Дата рождения-----------
//        //Вью для Даты рождения------------------------------------------------
//        buttonBirth = [UIButton buttonWithType:UIButtonTypeSystem];
//        buttonBirth.frame = CGRectMake(self.frame.size.width / 2 - 164, viewCity.frame.size.height + viewCity.frame.origin.y + 16, 328, 48);
//        buttonBirth.layer.cornerRadius = 24.f;
//        if (isiPhone5) {
//            buttonBirth.frame = CGRectMake(self.frame.size.width / 2 - 140, viewCity.frame.size.height + viewCity.frame.origin.y + 12, 280, 42);
//            buttonBirth.layer.cornerRadius = 21.f;
//        }
//        if (isiPhone4s) {
//            buttonBirth.frame = CGRectMake(self.frame.size.width / 2 - 140, viewCity.frame.size.height + viewCity.frame.origin.y + 12, 280, 38);
//            buttonBirth.layer.cornerRadius = 19.f;
//        }
//        buttonBirth.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [buttonBirth setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 130.0f, 0.0f, 0.0f)];
//        buttonBirth.backgroundColor = [UIColor whiteColor];
//        buttonBirth.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
//        buttonBirth.layer.borderWidth = 0.4f;
//        [buttonBirth addTarget:self action:@selector(buttonBirthAction) forControlEvents:UIControlEventTouchUpInside];
//        
//        if([dict objectForKey:@"b_date"] != [NSNull null]){
//            if(![[dict objectForKey:@"b_date"] isEqualToString:@""]){
//            
//                [buttonBirth setTitle:[dict objectForKey:@"b_date"] forState:UIControlStateNormal];
//            }else{
//                [buttonBirth setTitle:@"Дата рождения" forState:UIControlStateNormal];
//            }
//        }else{
//          [buttonBirth setTitle:@"Дата рождения" forState:UIControlStateNormal];
//        }
//        
//        [buttonBirth setTitleColor:[UIColor colorWithHexString:@"515050"] forState:UIControlStateNormal];
//        buttonBirth.contentEdgeInsets = UIEdgeInsetsMake(0, -100, 0, 0);
//        buttonBirth.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:20];
//        if (isiPhone5) {
//            buttonBirth.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:18];
//        }
//        [self addSubview:buttonBirth];
//        
//        UIImageView * imageViewButtonBirth = [[UIImageView alloc] initWithFrame:CGRectMake(buttonBirth.frame.size.width - 64, 24, 16, 8)];
//        if (isiPhone5) {
//            imageViewButtonBirth.frame = CGRectMake(buttonCity.frame.size.width - 60, 18, 16, 8);
//        }
//        imageViewButtonBirth.image = [UIImage imageNamed:@"arrowDownImage.png"];
//        [buttonBirth addSubview:imageViewButtonBirth];
        
        //Семейное положение-----------
        //Вью для Семейное положение------------------------------------------------
        buttonMaritalStatus = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonMaritalStatus.frame = CGRectMake(self.frame.size.width / 2 - 164, viewCity.frame.size.height + viewCity.frame.origin.y + 16, 328, 48);
        buttonMaritalStatus.layer.cornerRadius = 24.f;
        buttonMaritalStatus.backgroundColor = [UIColor whiteColor];
        buttonMaritalStatus.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        buttonMaritalStatus.layer.borderWidth = 0.4f;
        buttonMaritalStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [buttonMaritalStatus setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 70.0f, 0.0f, 0.0f)];
        [buttonMaritalStatus addTarget:self action:@selector(buttonMaritalStatu) forControlEvents:UIControlEventTouchUpInside];
        
        
        if([dict objectForKey:@"family"] != [NSNull null]){
            if(![[dict objectForKey:@"family"] isEqualToString:@""]){
                [buttonMaritalStatus setTitle:[dict objectForKey:@"family"] forState:UIControlStateNormal];
            }else{
                [buttonMaritalStatus setTitle:@"Семейное положение" forState:UIControlStateNormal];
            }
        }else{
            [buttonMaritalStatus setTitle:@"Семейное положение" forState:UIControlStateNormal];
        }
        
        [buttonMaritalStatus setTitleColor:[UIColor colorWithHexString:@"515050"] forState:UIControlStateNormal];
        buttonMaritalStatus.contentEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        buttonMaritalStatus.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:20];
        if (isiPhone5) {
            buttonMaritalStatus.frame = CGRectMake(self.frame.size.width / 2 - 140, viewCity.frame.size.height + viewCity.frame.origin.y + 12, 280, 42);
            buttonMaritalStatus.layer.cornerRadius = 21.f;
            buttonMaritalStatus.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:18];
        }
        if (isiPhone4s) {
            buttonMaritalStatus.frame = CGRectMake(self.frame.size.width / 2 - 140, viewCity.frame.size.height + viewCity.frame.origin.y + 12, 280, 38);
            buttonMaritalStatus.layer.cornerRadius = 19.f;
        }
        [self addSubview:buttonMaritalStatus];
        
        UIImageView * imageViewButtonbuttonMaritalStatus = [[UIImageView alloc] initWithFrame:CGRectMake(buttonMaritalStatus.frame.size.width - 64, 24, 16, 8)];
        if (isiPhone5) {
            imageViewButtonbuttonMaritalStatus.frame = CGRectMake(buttonCity.frame.size.width - 60, 18, 16, 8);
        }
        imageViewButtonbuttonMaritalStatus.image = [UIImage imageNamed:@"arrowDownImage.png"];
        [buttonMaritalStatus addSubview:imageViewButtonbuttonMaritalStatus];
        
        //Есть 18ть ??--------------------------------------
        UIButton * buttonEighteen = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonEighteen.frame = CGRectMake(110, buttonMaritalStatus.frame.size.height + buttonMaritalStatus.frame.origin.y + 16, 16, 16);
        buttonEighteen.backgroundColor = [UIColor whiteColor];
        [buttonEighteen addTarget:self action:@selector(buttonEighteenAction) forControlEvents:UIControlEventTouchUpInside];
        buttonEighteen.alpha = 0.f;
        [self addSubview:buttonEighteen];
        
//        //Лейбл есть 18ть ???-----------------------------------
//        UILabel * labelButtonEighteen = [[UILabel alloc] initWithFrame:CGRectMake(142, buttonMaritalStatus.frame.size.height + buttonMaritalStatus.frame.origin.y + 18, 200, 16)];
//        labelButtonEighteen.text = @"Отображать темы 18 +";
//        labelButtonEighteen.textColor = [UIColor colorWithHexString:@"5b5b5b"];
//        labelButtonEighteen.font = [UIFont fontWithName:FONTREGULAR size:15];
//        [self addSubview:labelButtonEighteen];
        
        //Кнопка сохранить----------------------------------------
        UIButton * buttonSave = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSave.frame = CGRectMake(self.frame.size.width / 2 - 92, buttonEighteen.frame.size.height + buttonEighteen.frame.origin.y + 128, 184, 48);
        buttonSave.layer.cornerRadius = 24;
        [buttonSave setTitle:@"СОХРАНИТЬ" forState:UIControlStateNormal];
        [buttonSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonSave.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:19];
        if (isiPhone6) {
            buttonSave.frame = CGRectMake(self.frame.size.width / 2 - 92, buttonEighteen.frame.size.height + buttonEighteen.frame.origin.y + 80, 184, 48);
        } else if (isiPhone5) {
            buttonSave.frame = CGRectMake(self.frame.size.width / 2 - 80, buttonEighteen.frame.size.height + buttonEighteen.frame.origin.y + 80, 160, 40);
            buttonSave.layer.cornerRadius = 20;
            buttonSave.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:17];
        }
        
        if (isiPhone4s) {
           buttonSave.frame = CGRectMake(self.frame.size.width / 2 - 80, buttonEighteen.frame.size.height + buttonEighteen.frame.origin.y + 40, 160, 40);
        }
        buttonSave.backgroundColor = [UIColor colorWithHexString:@"ea504f"];
        [buttonSave addTarget:self action:@selector(buttonSaveAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonSave];
        
        //Кнопка Подписки----------------------------------------
        UIButton * buttonSubscription = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSubscription.frame = CGRectMake(self.frame.size.width / 2 - 92, 25, 184, 48);
        buttonSubscription.layer.cornerRadius = 24;
        [buttonSubscription setTitle:@"ПОДПИСКИ" forState:UIControlStateNormal];
        [buttonSubscription setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonSubscription.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:19];
        if (isiPhone6) {
            buttonSubscription.frame = CGRectMake(self.frame.size.width / 2 - 92, 28, 184, 48);
        } else if (isiPhone5) {
            buttonSubscription.frame = CGRectMake(self.frame.size.width / 2 - 80, 28, 160, 40);
            buttonSubscription.layer.cornerRadius = 20;
            buttonSubscription.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:17];
        }
        
        if (isiPhone4s) {
            buttonSubscription.frame = CGRectMake(self.frame.size.width / 2 - 80, 10, 160, 40);
        }
        buttonSubscription.backgroundColor = [UIColor colorWithHexString:@"44d05c"];
        [buttonSubscription addTarget:self action:@selector(buttonSubscriptionAction) forControlEvents:UIControlEventTouchUpInside];
        //Скрываем кнопку подписки------------
        buttonSubscription.alpha = 0.f;
        [self addSubview:buttonSubscription];
        
        //Кнопка сменить пароль------------------------------------
        UIButton * changePussButton = [UIButton buttonWithType:UIButtonTypeSystem];
        changePussButton.frame = CGRectMake(self.frame.size.width / 2 - 52, buttonSave.frame.size.height + buttonSave.frame.origin.y + 16, 104, 16);
        if (isiPhone4s) {
                    changePussButton.frame = CGRectMake(self.frame.size.width / 2 - 52, buttonSave.frame.size.height + buttonSave.frame.origin.y + 5, 104, 16);
        }
        changePussButton.backgroundColor = nil;
        [changePussButton setTitle:@"Сменить пароль" forState:UIControlStateNormal];
        [changePussButton setTitleColor:[UIColor colorWithHexString:@"5b5b5b"] forState:UIControlStateNormal];
        changePussButton.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:13];
        [changePussButton addTarget:self action:@selector(changePussButtonAction) forControlEvents:UIControlEventTouchUpInside];
        //Пока что отключаем-----------------------
        changePussButton.alpha = 0.f;
        [self addSubview:changePussButton];
        
#pragma mark - Alert View
        
        //Затемнение-----------------------------------------------------
        darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        darkView.backgroundColor = [UIColor blackColor];
        darkView.alpha = 0.0;
        [self addSubview:darkView];
        
        //Создаем алерт---------------------------------------------------
        alertViewPersonalArea = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 192, -600, 384, 368)];
        if (isiPhone6) {
            alertViewPersonalArea.frame = CGRectMake(self.frame.size.width / 2 - 162, -600, 324, 368);

        } else if (isiPhone5) {
            alertViewPersonalArea.frame = CGRectMake(self.frame.size.width / 2 - 150, -700, 300, 340);
        }
        alertViewPersonalArea.layer.cornerRadius = 5.f;
        alertViewPersonalArea.backgroundColor = [UIColor whiteColor];
        alertViewPersonalArea.userInteractionEnabled = YES;
        [self addSubview:alertViewPersonalArea];
        
        //Кнопка отмены--------------------------------------------------
        UIButton * buttonCancelXania = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonCancelXania.frame = CGRectMake(10, 10, 24, 24);
        UIImage *btnImage = [UIImage imageNamed:@"imageCancel.png"];
        [buttonCancelXania setImage:btnImage forState:UIControlStateNormal];
        [buttonCancelXania addTarget:self action:@selector(buttonCancelAction) forControlEvents:UIControlEventTouchUpInside];
        [alertViewPersonalArea addSubview:buttonCancelXania];
        
        //Плэйс холдер NickName----------------------------------------------------------
        labelPlaceHolderAlertCity = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, viewPhone.frame.size.width - 64, viewPhone.frame.size.height)];
        labelPlaceHolderAlertCity.text = @"Введите город";
        labelPlaceHolderAlertCity.textColor = [UIColor colorWithHexString:@"515050"];
        labelPlaceHolderAlertCity.font = [UIFont fontWithName:FONTREGULAR size:20];
        labelPlaceHolderAlertCity.alpha = 0.f;
        [alertViewPersonalArea addSubview:labelPlaceHolderAlertCity];
        
        //Дата пикер----------------------------------------
        dataPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake (30, 50, alertViewPersonalArea.frame.size.width - 60, alertViewPersonalArea.frame.size.height - 150)];
        dataPicker.datePickerMode = UIDatePickerModeDate;
        dataPicker.maximumDate = [NSDate date];
        dataPicker.alpha = 0.f;
        [alertViewPersonalArea addSubview:dataPicker];
        
        //Пикер семейного положение--------------------------
        maritalStatusPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(30, 50, alertViewPersonalArea.frame.size.width - 60, alertViewPersonalArea.frame.size.height - 150)];
        maritalStatusPicker.dataSource = self;
        maritalStatusPicker.delegate = self;
        [alertViewPersonalArea addSubview:maritalStatusPicker];
        maritalStatusPicker.alpha = 0.f;
        
        //Кнопка отправить---------------------------------
        UIButton * buttonSend = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSend.frame = CGRectMake(40, dataPicker.frame.origin.y + dataPicker.frame.size.height + 16, alertViewPersonalArea.frame.size.width - 80, 48);
        buttonSend.backgroundColor = [UIColor colorWithHexString:@"44d05c"];
        buttonSend.layer.cornerRadius = 25;
        if (isiPhone6) {
            buttonSend.frame = CGRectMake(40, dataPicker.frame.origin.y + dataPicker.frame.size.height + 16, alertViewPersonalArea.frame.size.width - 80, 40);
            buttonSend.layer.cornerRadius = 20;
        }
        buttonSend.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        buttonSend.layer.borderWidth = 1.f;
        [buttonSend setTitle:@"ОТПРАВИТЬ" forState:UIControlStateNormal];
        [buttonSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonSend.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:16];
        [buttonSend addTarget:self action:@selector(buttonSendAction) forControlEvents:UIControlEventTouchUpInside];
        [alertViewPersonalArea addSubview:buttonSend];

        
        
        

        


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
    } else {
        /*  limit the users input to only 9 characters  */
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
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
    
    
    if (testField.text.length != 0 && isBoolPhone) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderPhone.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderPhone.frame = rect;
            labelPlaceHolderPhone.alpha = 0.f;
            isBoolPhone = NO;
        }];
    } else if (testField.text.length == 0 && !isBoolPhone) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderPhone.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderPhone.frame = rect;
            labelPlaceHolderPhone.alpha = 1.f;
            isBoolPhone = YES;
        }];
    }
}

//Анимация Лейблов при вводе Email------------------------
- (void) animationLabelEmail: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    
    if (testField.text.length != 0 && isBoolEmail) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderEmail.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderEmail.frame = rect;
            labelPlaceHolderEmail.alpha = 0.f;
            isBoolEmail = NO;
        }];
    } else if (testField.text.length == 0 && !isBoolEmail) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderEmail.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderEmail.frame = rect;
            labelPlaceHolderEmail.alpha = 1.f;
            isBoolEmail = YES;
        }];
    }
}

//Анимация Лейблов при вводе NickName------------------------
- (void) animationLabelNickName: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    
    if (testField.text.length != 0 && isBoolNickName) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderNickName.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderNickName.frame = rect;
            labelPlaceHolderNickName.alpha = 0.f;
            isBoolNickName = NO;
        }];
    } else if (testField.text.length == 0 && !isBoolNickName) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderNickName.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderNickName.frame = rect;
            labelPlaceHolderNickName.alpha = 1.f;
            isBoolNickName = YES;
        }];
    }
}

//Анимация Лейблов при вводе Города------------------------
- (void) animationLabelCity: (NSNotification*) notification
{
    UITextField * testField = notification.object;
    
    if (testField.text.length != 0 && isBoolCity) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderCity.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderCity.frame = rect;
            labelPlaceHolderCity.alpha = 0.f;
            isBoolCity = NO;
        }];
    } else if (testField.text.length == 0 && !isBoolCity) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderCity.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderCity.frame = rect;
            labelPlaceHolderCity.alpha = 1.f;
            isBoolCity = YES;
        }];
    }
}


//Поднимаем текст вверх--------------------------------------
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:textFieldPhone]) {
        if ([textField.text isEqualToString:@""]) {
            textField.text = @"+7";
            if (textField.text.length != 0 && isBoolPhone) {
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect rect;
                    rect = labelPlaceHolderPhone.frame;
                    rect.origin.x = rect.origin.x + 100.f;
                    labelPlaceHolderPhone.frame = rect;
                    labelPlaceHolderPhone.alpha = 0.f;
                    isBoolPhone = NO;
                }];
            }
            
        }
        
        textField.textAlignment = NSTextAlignmentLeft;
    }
    
    
}

//Восстанавливаем стандартный размер-----------------------
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:textFieldPhone]) {
        if ([textField.text isEqualToString:@"+7"]) {
            textField.text = @"";
            if (textField.text.length == 0 && !isBoolPhone) {
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect rect;
                    rect = labelPlaceHolderPhone.frame;
                    rect.origin.x = rect.origin.x - 100.f;
                    labelPlaceHolderPhone.frame = rect;
                    labelPlaceHolderPhone.alpha = 1.f;
                    isBoolPhone = YES;
                }];
            }
        }
        textField.textAlignment = NSTextAlignmentCenter;
    }
    
    
}

//Отвязка от всех нотификаций------------------------------
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action Methods
//Действие кнопки Выбора города-----------------------------
- (void) buttonCityAction
{
    pickerCity.alpha = 1.f;
    textFieldAlertCity. alpha = 1.f;
    labelPlaceHolderAlertCity.alpha = 1.f;
    //Анимация алерта---------------------------------------------
    [UIView animateWithDuration:0.1 animations:^{
        darkView.alpha = 0.4f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rectAlert = alertViewPersonalArea.frame;
            rectAlert.origin.y += 750;
            alertViewPersonalArea.frame = rectAlert;
        }];
    }];
}

//Действие семейное положение--------------------------------
- (void) buttonMaritalStatu
{
    maritalStatusPicker.alpha = 1.f;
    //Анимация алерта---------------------------------------------
    [UIView animateWithDuration:0.1 animations:^{
        darkView.alpha = 0.4f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rectAlert = alertViewPersonalArea.frame;
            rectAlert.origin.y += 750;
            alertViewPersonalArea.frame = rectAlert;
        }];
    }];
}

//Действие дата рождения----------------------------------------
- (void) buttonBirthAction
{
    dataPicker.alpha = 1.f;
    //Анимация алерта---------------------------------------------
    [UIView animateWithDuration:0.1 animations:^{
        darkView.alpha = 0.4f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rectAlert = alertViewPersonalArea.frame;
            rectAlert.origin.y += 750;
            alertViewPersonalArea.frame = rectAlert;
        }];
    }];
}

//Действие кнопки есть 18ть------------------------------------
- (void) buttonEighteenAction
{
    NSLog(@"Есть 18ть");
}

//Действие кнопки подтвердить по СМС
- (void) buttonСonfirmAction
{
    NSLog(@"подтвердить по СМС");
}

//Действие кнопки сменить пароль
- (void) changePussButtonAction
{
    NSLog(@"сменить пароль");
}

//Действие кнопки сохранить
- (void) buttonSaveAction
{
    
    NSUInteger selectedRow = [maritalStatusPicker selectedRowInComponent:0];
    NSString * selectedTitle = [arrayMoterial objectAtIndex:selectedRow];
    NSLog(@"Selected: %@",selectedTitle);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    
    NSString *stringFromDate = [formatter stringFromDate:dataPicker.date];
    
    
    NSDictionary * dictInfo = [[NSDictionary alloc] initWithObjectsAndKeys:
                              [[SingleTone sharedManager] userID],@"id",
                               textFieldviewNickName.text,@"name",
                               selectedTitle,@"family",
                               textFieldEmail.text,@"email",
                               textFieldPhone.text,@"phone",
                               textFieldviewCity.text,@"city",
                               stringFromDate,@"bdate",
                     
                               
                               nil];
      [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SAVE_PROFILE object:dictInfo];
    NSLog(@"Сохранить");
}

//Действие кнопки закрыть алерт
- (void) buttonCancelAction
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rectAlert = alertViewPersonalArea.frame;
        rectAlert.origin.y -= 750;
        alertViewPersonalArea.frame = rectAlert;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            darkView.alpha = 0;
            pickerCity.alpha = 0.f;
            maritalStatusPicker.alpha = 0.f;
            dataPicker.alpha = 0.f;
            textFieldAlertCity.alpha = 0.f;
            labelPlaceHolderAlertCity.alpha = 0.f;
            if (textFieldAlertCity.text.length != 0) {
                
            }
        }];
    }];
}

//Действие кнопки отправить -------
- (void) buttonSendAction
{
    NSLog(@"Отправить !!!");

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    
    NSString *stringFromDate = [formatter stringFromDate:dataPicker.date];
    NSLog(@"FORMAT %@",stringFromDate);
    
    [buttonBirth setTitle:stringFromDate forState:(UIControlStateNormal)];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rectAlert = alertViewPersonalArea.frame;
        rectAlert.origin.y -= 750;
        alertViewPersonalArea.frame = rectAlert;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            darkView.alpha = 0;
            pickerCity.alpha = 0.f;
            maritalStatusPicker.alpha = 0.f;
            dataPicker.alpha = 0.f;
            textFieldAlertCity.alpha = 0.f;
            labelPlaceHolderAlertCity.alpha = 0.f;
            if (textFieldAlertCity.text.length != 0) {
                
            }
        }];
    }];
    
}

- (void) buttonSubscriptionAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PUSH_SUBSCRIPTION object:nil];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == pickerCity) {
        if (textFieldAlertCity.text.length == 0) {
            return arrayCity.count;
        } else {
            return arrayMCity.count;
        }
}
    return arrayMoterial.count;
}

- (NSString*)pickerView:(UIPickerView*)thePickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component
{
    if (thePickerView == pickerCity) {
    if (textFieldAlertCity.text.length == 0) {
        return arrayCity[row];
    } else {
        return arrayMCity[row];
    }
}
    return arrayMoterial[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == pickerCity) {
        if (textFieldAlertCity.text.length == 0) {
            NSLog(@"%@", arrayCity[row]);
        } else {
            NSLog(@"%@", arrayMCity[row]);
        }
    } else if(pickerView == maritalStatusPicker){
        NSLog(@"TYT %@", arrayMoterial[row]);
        
        [buttonMaritalStatus setTitle:arrayMoterial[row] forState:UIControlStateNormal];
        
    }

    
    
}



@end
