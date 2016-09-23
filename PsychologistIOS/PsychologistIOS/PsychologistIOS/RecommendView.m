//
//  RecommendView.m
//  PsychologistIOS
//
//  Created by Viktor on 10.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "RecommendView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import <AKPickerView/AKPickerView.h>
#import "StringImage.h"
#import "ViewSectionTable.h"

@interface RecommendView () <UITableViewDataSource, UITableViewDelegate, AKPickerViewDataSource, AKPickerViewDelegate>
@property (strong,nonatomic) NSString * personalID;
@end

@implementation RecommendView
{
    UITableView * mainTableViewRecommend;
    
    //Массив кнопок------------------------
    NSMutableArray * arrayButtons;
    NSArray * arrayBool;
    NSArray * arrayInfo;
    NSInteger customTagCallButton;
    NSInteger customTagBackCallButton;
    NSMutableDictionary * phoneDict;
    NSMutableDictionary * idDict;
    //Алерт
    UIView * darkView;
    UIView * alertViewRecommend;
    UITextField * textFieldPhone;
    UILabel * labelPlaceHolderPhone;
    BOOL isBool;
    AKPickerView * pickerAlert;
    NSArray * titles;
    NSInteger row;
}

- (instancetype)initWithView: (UIView*) view andArray: (NSArray*) array;
{
    self = [super init];
    if (self) {
        arrayInfo=array;
        phoneDict = [[NSMutableDictionary alloc] init];
        idDict = [[NSMutableDictionary alloc] init];
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        arrayButtons = [[NSMutableArray alloc] init];
        arrayBool = [NSArray arrayWithObjects:[NSNumber numberWithBool:NO], [NSNumber numberWithBool:YES],
                                              [NSNumber numberWithBool:YES], [NSNumber numberWithBool:NO], nil];
        customTagCallButton = 0;
        customTagBackCallButton = 0;
        isBool = YES;
        
        mainTableViewRecommend = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        //Убираем полосы разделяющие ячейки------------------------------
        mainTableViewRecommend.separatorStyle = UITableViewCellSeparatorStyleNone;
        mainTableViewRecommend.dataSource = self;
        mainTableViewRecommend.delegate = self;
        mainTableViewRecommend.showsVerticalScrollIndicator = NO;
        //Очень полездное свойство, отключает дествие ячейки-------------
        mainTableViewRecommend.allowsSelection = NO;
        [self addSubview:mainTableViewRecommend];
        
#pragma mark - Create Alert
        
        //Затемнение-----------------------------------------------------
        darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height+65)];
        darkView.backgroundColor = [UIColor blackColor];
        darkView.alpha = 0.0;
        [self addSubview:darkView];
        
        //Создаем алерт---------------------------------------------------
        alertViewRecommend = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 192, -600, 384, 368)];
        if (isiPhone6) {
            alertViewRecommend.frame = CGRectMake(self.frame.size.width / 2 - 162, -600, 324, 368);
        } else if (isiPhone5) {
            alertViewRecommend.frame = CGRectMake(self.frame.size.width / 2 - 150, -700, 300, 340);
        }
        alertViewRecommend.layer.cornerRadius = 5.f;
        alertViewRecommend.backgroundColor = [UIColor whiteColor];
        alertViewRecommend.userInteractionEnabled = YES;
        [self addSubview:alertViewRecommend];
        
        //Кнопка отмены--------------------------------------------------
        UIButton * buttonCancelRecommend = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonCancelRecommend.frame = CGRectMake(10, 10, 24, 24);
        if (isiPhone5) {
            buttonCancelRecommend.frame = CGRectMake(7, 7, 20, 20);
        }
        UIImage *btnImage = [UIImage imageNamed:@"imageCancel.png"];
        [buttonCancelRecommend setImage:btnImage forState:UIControlStateNormal];
        [buttonCancelRecommend addTarget:self action:@selector(buttonCancelAction) forControlEvents:UIControlEventTouchUpInside];
        [alertViewRecommend addSubview:buttonCancelRecommend];
        
        //Основной текст-------------------------------------------------
        UILabel * mainLabelText = [[UILabel alloc] initWithFrame:CGRectMake(32, 24, alertViewRecommend.frame.size.width - 64, 80)];
        mainLabelText.numberOfLines = 0;
        mainLabelText.text = @"Введите номер телефона и укажите время в которое вы хотите получить консультацию наших специалистов";
        mainLabelText.textColor = [UIColor colorWithHexString:@"4b4a4a"];
        mainLabelText.font = [UIFont fontWithName:FONTREGULAR size:14];
        [alertViewRecommend addSubview:mainLabelText];
        
        //Вью для телевона------------------------------------------------
        UIView * viewPhone = [[UIView alloc] initWithFrame:CGRectMake(32, 152, alertViewRecommend.frame.size.width - 64, 48)];
        if (isiPhone6) {
            viewPhone.frame = CGRectMake(32, 152, alertViewRecommend.frame.size.width - 64, 40);
        } else if (isiPhone5) {
            viewPhone.frame = CGRectMake(32, 152, alertViewRecommend.frame.size.width - 64, 32);
        }
        viewPhone.layer.cornerRadius = 10.f;
        viewPhone.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        viewPhone.layer.borderWidth = 0.4f;
        [alertViewRecommend addSubview:viewPhone];
        
        //Ввод телефона-----------------------------------------------------------------
        textFieldPhone = [[UITextField alloc] initWithFrame:CGRectMake(24, 0, viewPhone.frame.size.width - 48, viewPhone.frame.size.height)];
        textFieldPhone.delegate = self;
        textFieldPhone.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        textFieldPhone.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldPhone.font = [UIFont fontWithName:FONTREGULAR size:19];
        if (isiPhone5) {
            textFieldPhone.font = [UIFont fontWithName:FONTREGULAR size:17];
        }
        textFieldPhone.textColor = [UIColor colorWithHexString:@"a6a6a6"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelPhone:) name:UITextFieldTextDidChangeNotification object:textFieldPhone];
        [viewPhone addSubview:textFieldPhone];
        
        //Плэйс холдер телефона----------------------------------------------------------
        labelPlaceHolderPhone = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, viewPhone.frame.size.width - 48, viewPhone.frame.size.height)];
        labelPlaceHolderPhone.tag = 3022;
        labelPlaceHolderPhone.text = @"Номер телефона";
        labelPlaceHolderPhone.textColor = [UIColor colorWithHexString:@"a6a6a6"];
        labelPlaceHolderPhone.font = [UIFont fontWithName:FONTREGULAR size:19];
        if (isiPhone5) {
            labelPlaceHolderPhone.font = [UIFont fontWithName:FONTREGULAR size:17];
        }
        [viewPhone addSubview:labelPlaceHolderPhone];
        
        //Заголовок предпочитаемое время-------------------------------------------------
        UILabel * labelTime = [[UILabel alloc] initWithFrame:CGRectMake(0, viewPhone.frame.size.height + viewPhone.frame.origin.y + 16, alertViewRecommend.frame.size.width, 16)];
        labelTime.text = @"Предпочитаемое время";
        labelTime.textColor = [UIColor colorWithHexString:@"9f9f9f"];
        labelTime.textAlignment = NSTextAlignmentCenter;
        labelTime.font = [UIFont fontWithName:FONTREGULAR size:13];
        [alertViewRecommend addSubview:labelTime];
        
        //Вью предпочитаемое время--------------------------------------------------------
        UIView * viewTime = [[UIView alloc] initWithFrame:CGRectMake(alertViewRecommend.frame.size.width / 2 - 40, labelTime.frame.size.height + labelTime.frame.origin.y + 12, 80, 40)];
        viewTime.layer.cornerRadius = 8.f;
        viewTime.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        viewTime.layer.borderWidth = 0.4f;
        viewTime.backgroundColor = nil;
        [alertViewRecommend addSubview:viewTime];
        
        //Пикер------------------------------------------------------------------------------
        pickerAlert = [[AKPickerView alloc] initWithFrame:CGRectMake(32, labelTime.frame.size.height + labelTime.frame.origin.y + 8, alertViewRecommend.frame.size.width - 64, 48)];
        pickerAlert.dataSource = self;
        pickerAlert.delegate = self;
        pickerAlert.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [alertViewRecommend addSubview:pickerAlert];
        pickerAlert.font = [UIFont fontWithName:FONTLITE size:20];
        pickerAlert.highlightedFont = [UIFont fontWithName:FONTREGULAR size:20];
        pickerAlert.textColor = [UIColor colorWithHexString:@"9f9f9f"];
        pickerAlert.highlightedTextColor = [UIColor colorWithHexString:@"9f9f9f"];
        pickerAlert.interitemSpacing = 20.0;
        pickerAlert.fisheyeFactor = 0.001;
        pickerAlert.pickerViewStyle = AKPickerViewStyle3D;
        pickerAlert.maskDisabled = false;
        titles = @[@"10:00",
                   @"10:30",
                   @"11:00",
                   @"11:30",
                   @"12:00",
                   @"12:30",
                   @"13:00",
                   @"13:30",
                   @"14:00",
                   @"14:30",
                   @"15:00",
                   @"15:30",
                   @"16:00",
                   @"16:30",
                   @"17:00",
                   @"17:30",
                   @"18:00",
                   @"18:30",
                   @"19:00",
                   @"19:30",
                   @"20:00",
                   @"20:30",
                   @"21:00",
                   @"21:30",
                   @"22:00"];
        
        [pickerAlert reloadData];
        NSInteger intCount = 10;
        [pickerAlert selectItem:intCount animated:NO];
        
        //Кнопка отправить-----------------------------------------------------
        //Кнопка открыть категорию--------------------------------------
        UIButton * buttonSend = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSend.frame = CGRectMake(40, pickerAlert.frame.origin.y + pickerAlert.frame.size.height + 16, alertViewRecommend.frame.size.width - 80, 48);
        buttonSend.backgroundColor = [UIColor colorWithHexString:@"44d05c"];
        buttonSend.layer.cornerRadius = 25;
        if (isiPhone6) {
            buttonSend.frame = CGRectMake(40, pickerAlert.frame.origin.y + pickerAlert.frame.size.height + 16, alertViewRecommend.frame.size.width - 80, 40);
            buttonSend.layer.cornerRadius = 20;
        } else if (isiPhone5) {
            buttonSend.frame = CGRectMake(40, pickerAlert.frame.origin.y + pickerAlert.frame.size.height + 16, alertViewRecommend.frame.size.width - 80, 34);
            buttonSend.layer.cornerRadius = 17;
        }
        buttonSend.layer.borderColor = [UIColor colorWithHexString:@"a6a6a6"].CGColor;
        buttonSend.layer.borderWidth = 1.f;
        [buttonSend setTitle:@"ОТПРАВИТЬ" forState:UIControlStateNormal];
        [buttonSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonSend addTarget:self action:@selector(buttonSendAction) forControlEvents:UIControlEventTouchUpInside];
        [alertViewRecommend addSubview:buttonSend];
        
        
        
    }
    return self;
}

- (UIView*) setTableCellWithImage: (NSString*) image
                         andTitle: (NSString*) title
                      andSubTitle: (NSString*) subTitle
                          andSite: (NSString*) site
                        andPhone: (NSString*) phone
                         andPersonalId: (NSString*) personal_id
                          andMail: (NSString*) mail
                     andButtonTag: (NSInteger) buttonTag
                       andBoolParams: (BOOL) boolPrams
{
    //Основное вью ячейки-----------------------------------------
    UIView * viewCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 144)];
    if (isiPhone5) {
        viewCell.frame = CGRectMake(0, 0, self.frame.size.width, 130);
    }
    
    //Картинка ячейки---------------------------------------------
    UIImageView * imageViewCell = [[UIImageView alloc] initWithFrame:CGRectMake(32, 16, 80, 80)];
    if (isiPhone5) {
        imageViewCell.frame = CGRectMake(32, 16, 70, 70);
    }
    
    ViewSectionTable * viewSectionTable =[[ViewSectionTable alloc] initWithImageURL:image andView:viewCell andImageView:imageViewCell andContentMode:UIViewContentModeScaleAspectFill];
    
    [viewCell addSubview:viewSectionTable];
    
    //Заголовок---------------------------------------------------
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(144, 16, 200, 24)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithHexString:@"8a8a8a"];
    titleLabel.font = [UIFont fontWithName:FONTREGULAR size:22];
    if (isiPhone5) {
        titleLabel.frame = CGRectMake(124, 16, 200, 20);
        titleLabel.font = [UIFont fontWithName:FONTREGULAR size:18];
    }
    [viewCell addSubview:titleLabel];
    
    //Подзаголовок-----------------------------------------------
    UILabel * subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(144, 40, 200, 16)];
    if (isiPhone5) {
        subTitleLabel.frame = CGRectMake(124, 38, 200, 16);
    }
    subTitleLabel.text = subTitle;
    subTitleLabel.textColor = [UIColor colorWithHexString:@"f26e6e"];
    subTitleLabel.font = [UIFont fontWithName:FONTLITE size:12];
    [viewCell addSubview:subTitleLabel];
    
    //Сайт-------------------------------------------------------
    UILabel * labelSite = [[UILabel alloc] initWithFrame:CGRectMake(144, 56, 200, 16)];
    if (isiPhone5) {
        labelSite.frame = CGRectMake(124, 56, 200, 16);
    }
    labelSite.text = site;
    labelSite.textColor = [UIColor colorWithHexString:@"777575"];
    labelSite.font = [UIFont fontWithName:FONTLITE size:12];
    [viewCell addSubview:labelSite];
    
    //Почта------------------------------------------------------
    UILabel * labelMail = [[UILabel alloc] initWithFrame:CGRectMake(32, 102, 90, 16)];
    if (isiPhone5) {
        labelMail.frame = CGRectMake(32, 95, 90, 16);
    }
    labelMail.text = mail;
    labelMail.textColor = [UIColor colorWithHexString:@"f26e6e"];
    labelMail.font = [UIFont fontWithName:FONTLITE size:11];
    [viewCell addSubview:labelMail];
    
    if (boolPrams) {
        //Кнопка подвонить-------------------------------------------
        UIButton * callButton = [UIButton buttonWithType:UIButtonTypeSystem];
        callButton.frame = CGRectMake(144, 80, viewCell.frame.size.width - 32 - 144, 24);
        callButton.backgroundColor = [UIColor colorWithHexString:@"36b34c"];
        [callButton setTitle:@"ПОЗВОНИТЬ" forState:UIControlStateNormal];
        callButton.tag = buttonTag;
        NSString * tag =[NSString stringWithFormat:@"%li",buttonTag];
        [phoneDict setObject:phone forKey:tag];
        callButton.layer.cornerRadius = 10.f;
        [callButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        callButton.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:15];
        if (isiPhone5) {
            callButton.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:12];
        }
        [callButton addTarget:self action:@selector(callButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [viewCell addSubview:callButton];
        
        [arrayButtons addObject:callButton];
    } else {
        //Кнопка обратный звонок----------------------------------------
        UIButton * backCallButton = [UIButton buttonWithType:UIButtonTypeSystem];
        backCallButton.frame = CGRectMake(144, 80, viewCell.frame.size.width - 32 - 144, 24);
        backCallButton.backgroundColor = [UIColor colorWithHexString:@"0076a2"];
        [backCallButton setTitle:@"ОБРАТНЫЙ ЗВОНОК" forState:UIControlStateNormal];
        backCallButton.tag = buttonTag;
        NSString * tagPersonal =[NSString stringWithFormat:@"%li",buttonTag];
        [idDict setObject:personal_id forKey:tagPersonal];
        backCallButton.layer.cornerRadius = 10.f;
        [backCallButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        backCallButton.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:15];
        if (isiPhone5) {
            backCallButton.titleLabel.font = [UIFont fontWithName:FONTREGULAR size:12];
        }
        [backCallButton addTarget:self action:@selector(backCallButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [viewCell addSubview:backCallButton];
        
        [arrayButtons addObject:backCallButton];
    }

    return viewCell;
}

#pragma mark - AKPickerViewDataSource

- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView
{
    return [titles count];
}


- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item
{
    return titles[item];
}



#pragma mark - AKPickerViewDelegate

- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item
{
    NSLog(@"%@", titles[item]);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * resultDict = [arrayInfo objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.backgroundColor = nil;
    
    NSString * stringURL = [StringImage createStringImageURLWithString:[resultDict objectForKey:@"media_path"]];
    
  
    if ([[resultDict objectForKey:@"can_call"] integerValue]==1) {
        
        customTagCallButton += 1;

        [cell addSubview:[self setTableCellWithImage:stringURL andTitle:[resultDict objectForKey:@"name"] andSubTitle:[resultDict objectForKey:@"description"]  andSite:[resultDict objectForKey:@"site"] andPhone:[resultDict objectForKey:@"phone"] andPersonalId:[resultDict objectForKey:@"id"] andMail:[resultDict objectForKey:@"email"] andButtonTag:customTagCallButton andBoolParams:[[resultDict objectForKey:@"can_call"] integerValue]]];
        
    } else {
        
        customTagBackCallButton += 1;
        
        [cell addSubview:[self setTableCellWithImage:stringURL andTitle:[resultDict objectForKey:@"name"] andSubTitle:[resultDict objectForKey:@"description"]  andSite:[resultDict objectForKey:@"site"] andPhone:[resultDict objectForKey:@"phone"] andPersonalId:[resultDict objectForKey:@"id"] andMail:[resultDict objectForKey:@"email"] andButtonTag:customTagBackCallButton andBoolParams:[[resultDict objectForKey:@"can_call"] integerValue]]];

    }
    

     
     
    cell.editing = NO;

    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isiPhone5) {
        return 130;
    }  else {
       return 144;
    }
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
        return (newLength > 5) ? NO : YES;
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
    
    textField.textAlignment = NSTextAlignmentCenter;
}

//Отвязка от всех нотификаций------------------------------
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action Methods

//Действие кнопки позвонить
- (void) callButtonAction: (UIButton*) button
{
    NSLog(@"%@",phoneDict);
    for (int i = 0; i < arrayButtons.count; i++) {
        if (button.tag == i + 1) {
            NSLog(@"Звоним на конкретный номер");
            NSString * phone = [NSString stringWithFormat:@"%li",button.tag];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[phoneDict objectForKey:phone]]];
        }
    }
}

//Дествие кнопки обраный звонок
- (void) backCallButtonAction: (UIButton*) button
{
    
    for (int i = 0; i < arrayButtons.count; i++) {
        if (button.tag == i + 1) {
            
            NSString * personalID = [NSString stringWithFormat:@"%li",button.tag];
            self.personalID = [idDict objectForKey:personalID];
            
            //Анимация алерта---------------------------------------------
            [UIView animateWithDuration:0.1 animations:^{
                darkView.alpha = 0.4f;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect rectAlert = alertViewRecommend.frame;
                    rectAlert.origin.y += 750;
                    alertViewRecommend.frame = rectAlert;
                }];
            }];
        }
    }
}

//Действие кнопки закрыть алерт
- (void) buttonCancelAction
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rectAlert = alertViewRecommend.frame;
        rectAlert.origin.y -= 760;
        alertViewRecommend.frame = rectAlert;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            darkView.alpha = 0;
        }];
    }];
}

//Действие кнопки отправить--------------------
- (void) buttonSendAction
{
    
    NSUInteger selectedRow = [pickerAlert selectedItem];
    NSString * selectedTitle = [titles objectAtIndex:selectedRow];
    
    
    NSDictionary * dictInfo = [[NSDictionary alloc] initWithObjectsAndKeys:
                               textFieldPhone.text,@"phone",
                               selectedTitle,@"time",
                               self.personalID,@"personal_id",
                     
                               nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SEND_PERSONAL_SMS object:dictInfo];
    
   
    
    NSLog(@"Попросить перезвонить мне:%@",selectedTitle);
}



@end
