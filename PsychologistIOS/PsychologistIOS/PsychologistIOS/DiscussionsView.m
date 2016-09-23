//
//  DiscussionsView.m
//  PsychologistIOS
//
//  Created by Viktor on 07.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "DiscussionsView.h"
#import "UIColor+HexColor.h"
#include "Macros.h"
#import "DACircularProgressView.h"
#import "DALabeledCircularProgressView.h"
#import <AVFoundation/AVFoundation.h>
#import "CustomPlayer.h"
#import "SingleTone.h"
#import "ViewSectionTable.h"

@interface DiscussionsView () <UITextViewDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) DACircularProgressView *progressView;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer * timerLabel;
@property (strong, nonatomic) UILabel * labelTest;
@property (assign, nonatomic) CGFloat labelFloat;

@property (strong, nonatomic) CustomPlayer *player;


@end

@implementation DiscussionsView
{

    
    
    UIScrollView * mainScrollView;
    //Переменные вью отправки------------
    BOOL isBool;
    UITextView * textFieldChat;
    UILabel * labelPlaceHolderChat;
    UIView * inputText;
    
    //Переменные чата---------------------
    UIScrollView * viewScrollChat;
    NSMutableArray * mArrayForPushButton;
    CGFloat countFor; //customHeight
    CGFloat mainFloat;
    CGFloat testFloat;
    UIView * viewMessage;
    UIButton * imageViewChat;
    
    //Счетчик картинок--------------------
    NSInteger buttonsNumber;
    //Массив картинок---------------------
    NSMutableArray * buttonsArray;
    NSMutableArray * imageArray;
    BOOL buttonImageChange;
    UIView * imageFullView;
    UIImageView * imageFull;
    
    
    //Вью микрофона------------------------
    UIView * dictaphoneView;
    BOOL dictaBool;
    UIButton * buttonSend;
    
    NSInteger integetButtonPlay;
    NSMutableDictionary * soundDict;
    
    NSInteger integerButtonName;
    
    

}

- (instancetype)initWithView: (UIView*) view andArray: (NSArray*) array
{
    self = [super init];
    if (self) {
        
        //Дополнительный переменные---------------
        isBool = YES;
        mArrayForPushButton = [NSMutableArray new];
        countFor = 0.f;
        buttonsNumber = 9;
        buttonsArray = [NSMutableArray new];
        imageArray = [NSMutableArray new];
        soundDict = [NSMutableDictionary new];
        buttonImageChange = NO;
        dictaBool = NO;
        integetButtonPlay = 0;
        
        integerButtonName = 0;
        
        
        
        
        
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        mainScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        [self addSubview:mainScrollView];
        
        //Получаем ответ в виде нотификации с обектом--
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationSentImage:) name:NOTIFICATION_SEND_IMAGE_FOR_DUSCUSSIONS_VIEW object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateActionWithParams:) name:@"updateNotificationWithParams" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testNotificationMethod:) name:@"proverkaPeredachiZvuka" object:nil];
        
        
#pragma mark - Chat
        
        //Вью чата--------------------------------------------------------------------
        viewScrollChat = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, self.frame.size.height - 60)];
        [mainScrollView addSubview:viewScrollChat];
        //Загружаем данные------------------------------------------------------------
        [self sendMessageWithArray:array andSend:NO];
        
        //Скрытие клавиатуры тапом----------------------------------
        UITapGestureRecognizer * tapOnBackground = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self action:@selector(tapOnBackgroundAction)];
        [self addGestureRecognizer:tapOnBackground];
        
#pragma mark - Push Message
        
        //Раздел для ввода данных-----
        UIView * mainViewPush = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50)];
        [mainScrollView addSubview:mainViewPush];
        
        //Ввод текста----------------
        inputText = [[UIView alloc] initWithFrame:CGRectMake(64, 10, 248, 32)];
        if (isiPhone6) {
            inputText.frame = CGRectMake(60, 10, 236, 28);
        } else if (isiPhone5) {
            inputText.frame = CGRectMake(40, 15, 220, 24);
        }
        inputText.backgroundColor = nil;
        inputText.layer.borderColor = [UIColor colorWithHexString:@"c7c7cc"].CGColor;
        inputText.layer.borderWidth = 0.4f;
        inputText.layer.cornerRadius = 5;
        [mainViewPush addSubview:inputText];
        
        //Ввод телефона-----------------------------------------------------------------
        textFieldChat = [[UITextView alloc] initWithFrame:CGRectMake(16, 0, 210, 32)];
        textFieldChat.delegate = self;
        textFieldChat.tag = 1001;
        textFieldChat.autocorrectionType = UITextAutocorrectionTypeNo;
        textFieldChat.font = [UIFont fontWithName:FONTLITE size:19];
        if (isiPhone6) {
            textFieldChat.font = [UIFont fontWithName:FONTLITE size:16];
        } else if (isiPhone5) {
            textFieldChat.font = [UIFont fontWithName:FONTLITE size:14];
            textFieldChat.frame = CGRectMake(16, 5, 216, 16);
        }
        textFieldChat.textColor = [UIColor colorWithHexString:@"c7c7cc"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationLabelChat:) name:UITextViewTextDidChangeNotification object:textFieldChat];
        [inputText addSubview:textFieldChat];
        
        //Плэйс холдер телефона----------------------------------------------------------
        labelPlaceHolderChat = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 216, 16)];
        labelPlaceHolderChat.tag = 1002;
        labelPlaceHolderChat.text = @"Сообщение";
        labelPlaceHolderChat.textColor = [UIColor colorWithHexString:@"c7c7cc"];
        labelPlaceHolderChat.font = [UIFont fontWithName:FONTLITE size:19];
        if (isiPhone6) {
            labelPlaceHolderChat.font = [UIFont fontWithName:FONTLITE size:16];
        } else if (isiPhone5) {
            labelPlaceHolderChat.font = [UIFont fontWithName:FONTLITE size:14];
            labelPlaceHolderChat.frame = CGRectMake(16, 4, 216, 16);
            
        }
        [inputText addSubview:labelPlaceHolderChat];
        
        //Кнопка отправить---------------------------------------------------------------
        UIButton * pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
        pushButton.frame = CGRectMake(320, 8, 38, 38);
        if (isiPhone6) {
            pushButton.frame = CGRectMake(302, 10, 32, 32);
        } else if (isiPhone5) {
            pushButton.frame = CGRectMake(263, 16, 25, 25);
        }
        pushButton.layer.cornerRadius = 16;
        UIImage * imageButtonPush = [UIImage imageNamed:@"pushMessageImage.png"];
        [pushButton setImage:imageButtonPush forState:UIControlStateNormal];
        [pushButton addTarget:self action:@selector(pushButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [mainViewPush addSubview:pushButton];
        
        //Кнопка создания аудио дорожки---------------------------------------------------
        UIButton * soundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        soundButton.frame = CGRectMake(363, 8, 38, 38);
        if (isiPhone6) {
            soundButton.frame = CGRectMake(340, 10, 32, 32);
        } else if (isiPhone5) {
            soundButton.frame = CGRectMake(292, 16, 25, 25);
        }
        soundButton.layer.cornerRadius = 16;
        UIImage * imageSoundButton = [UIImage imageNamed:@"soundButton.png"];
        [soundButton setImage:imageSoundButton forState:UIControlStateNormal];
        [soundButton addTarget:self action:@selector(soundButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [mainViewPush addSubview:soundButton];
        
        //Кнопка отправки фото------------------------------------------------------------
        UIButton * cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cameraButton.frame = CGRectMake(18, 12, 38, 25);
        if (isiPhone6) {
            cameraButton.frame = CGRectMake(18, 12, 32, 20);
        } else if (isiPhone5) {
            cameraButton.frame = CGRectMake(7, 16, 27, 18);
        } 
        UIImage * cameraButtonButton = [UIImage imageNamed:@"buttonCameraImage.png"];
        [cameraButton setImage:cameraButtonButton forState:UIControlStateNormal];
        [cameraButton addTarget:self action:@selector(cameraButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [mainViewPush addSubview:cameraButton];
        
        
        imageFullView = [[UIImageView alloc] initWithFrame:self.frame];
        imageFullView.alpha = 0.f;
        imageFullView.userInteractionEnabled = YES;
        imageFullView.backgroundColor = [UIColor whiteColor];
        imageFullView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageFullView];
        
        imageFull = [[UIImageView alloc] initWithFrame:self.frame];
        imageFull.contentMode = UIViewContentModeScaleAspectFit;
        [imageFullView addSubview:imageFull];
        
        UIButton * buttonCanselImage = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonCanselImage.frame = CGRectMake(imageFull.frame.size.width - 70, 10, 50, 50);
        buttonCanselImage.layer.cornerRadius = 25;
        UIImage * imageButtonCansel = [UIImage imageNamed:@"imageCancel.png"];
        [buttonCanselImage setImage:imageButtonCansel forState:UIControlStateNormal];
        [buttonCanselImage addTarget:self action:@selector(buttonCanselImageAction) forControlEvents:UIControlEventTouchUpInside];
        [imageFullView addSubview:buttonCanselImage];
        
#pragma mark - Dictaphone
        
        dictaphoneView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 200)];
        [view addSubview:dictaphoneView];
        
        self.labelTest = [[UILabel alloc] initWithFrame:CGRectMake(dictaphoneView.frame.size.width / 2 - 150, dictaphoneView.frame.size.height / 2 + 60, 100, 20)];
        self.labelTest.text = @"0:0";
        self.labelTest.textAlignment = NSTextAlignmentCenter;
        [dictaphoneView addSubview:self.labelTest];
        self.labelFloat = 0.00;
        self.progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(dictaphoneView.frame.size.width / 2 - 150, dictaphoneView.frame.size.height / 2 - 50, 100, 100)];
        self.progressView.trackTintColor = [UIColor colorWithHexString:@"77b3d4"];
        self.progressView.progressTintColor = [UIColor colorWithHexString:@"4f5d73"];
        self.progressView.thicknessRatio = 0.2;
        self.progressView.layer.borderColor = [UIColor blackColor].CGColor;
        self.progressView.layer.borderWidth = 1.f;
        self.progressView.layer.cornerRadius = 50.f;
        [dictaphoneView addSubview:self.progressView];
        
        UIButton * mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        mainButton.frame = CGRectMake(dictaphoneView.frame.size.width / 2 - 137, dictaphoneView.frame.size.height / 2 - 37, 74, 74);
        mainButton.layer.cornerRadius = 37.f;
        mainButton.layer.borderColor = [UIColor colorWithHexString:@"4f5d73"].CGColor;
        mainButton.layer.borderWidth = 3.f;
        [mainButton addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchDown];
        [mainButton addTarget:self action:@selector(stopAnimation) forControlEvents:UIControlEventTouchUpInside];
        UIImage * image = [UIImage imageNamed:@"mic.png"];
        [mainButton setImage:image forState:UIControlStateNormal];
        [dictaphoneView addSubview:mainButton];
        
        //Кнопка Отправить--------------------------------------
        buttonSend = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSend.frame = CGRectMake(165, dictaphoneView.frame.size.height / 2 - 24, 200, 48);
        buttonSend.backgroundColor = nil;
        buttonSend.layer.cornerRadius = 24;
        if (isiPhone5) {
            buttonSend.frame = CGRectMake(155, dictaphoneView.frame.size.height / 2 - 24, 150, 36);
            buttonSend.layer.cornerRadius = 18;
        }
        buttonSend.layer.borderColor = [UIColor colorWithHexString:@"4babe4"].CGColor;
        buttonSend.layer.borderWidth = 1.f;
        [buttonSend setTitle:@"ОТПРАВИТЬ" forState:UIControlStateNormal];
        [buttonSend setTitleColor:[UIColor colorWithHexString:@"4babe4"] forState:UIControlStateNormal];
        buttonSend.titleLabel.font = [UIFont fontWithName:FONTLITE size:16];
        [buttonSend addTarget:self action:@selector(buttonSendAction) forControlEvents:UIControlEventTouchUpInside];
        buttonSend.alpha = 0.4;
        buttonSend.userInteractionEnabled = NO;
        [dictaphoneView addSubview:buttonSend];
        
        
    }
    return self;
}

#pragma mark - DictaphoneMethods
- (void) progressChange
{
    CGFloat progress = self.progressView.progress + 0.001673f;
    [self.progressView setProgress:progress animated:YES];
    if (self.progressView.progress >= 1.0f && [self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
        [self.timerLabel invalidate];
        self.timerLabel = nil;
    }
}

- (void) progressTimerLabel
{
    self.labelFloat += 0.05;
    self.labelTest.text = [NSString stringWithFormat:@"%.1f", self.labelFloat];
}

- (void)startAnimation
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                  target:self
                                                selector:@selector(progressChange)
                                                userInfo:nil
                                                 repeats:YES];
    self.timerLabel = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                       target:self
                                                     selector:@selector(progressTimerLabel)
                                                     userInfo:nil
                                                      repeats:YES];
    self.labelFloat = 0.00;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_AUDIO_START_RECORD object:nil];
}

- (void) stopAnimation
{
    [self.timer invalidate];
    self.timer = nil;
    [self.timerLabel invalidate];
    self.timerLabel = nil;
    [self.progressView setProgress:0.f animated:YES];
    if (buttonSend.userInteractionEnabled == NO) {
        [UIView animateWithDuration:0.3 animations:^{
            buttonSend.userInteractionEnabled = YES;
            buttonSend.alpha = 1.f;
        }];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_AUDIO_STOP_RECORD object:nil];
    
}

#pragma mark - main Method send Message

//Метод Отправки сообщения---------------
- (void) sendMessageWithArray: (NSArray*) array andSend: (BOOL) send
{
    for (int i = 0; i < array.count; i++) {
        NSDictionary * dictChat = [array objectAtIndex:i];
        
        
        
        if ([[dictChat objectForKey:@"id_user"] integerValue] == 0) {
            integerButtonName += 1;
            // Имя пользователя---------------
            UIButton * buttonUser = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonUser.frame = CGRectMake(viewScrollChat.frame.size.width - 32 - 38, 8 + countFor, 88, 12);
            buttonUser.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [buttonUser setTitleColor:[UIColor colorWithHexString:@"8e8e93"] forState:UIControlStateNormal];
            buttonUser.titleLabel.font = [UIFont fontWithName:FONTBOND size:12];
            if (isiPhone5) {
                buttonUser.titleLabel.font = [UIFont fontWithName:FONTBOND size:10];
            }
            [buttonUser setTitle:@"Ксения" forState:UIControlStateNormal];
            buttonUser.tag = integerButtonName;
            [buttonUser addTarget:self action:@selector(addUserNameOnTextView:) forControlEvents:UIControlEventTouchUpInside];
            [viewScrollChat addSubview:buttonUser];

            //Если приходит текст-------------------------------------------
            if ([[dictChat objectForKey:@"type"] isEqualToString:@"message"]) {
                
               
                
                //Текст сообщения------------------
                UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(viewScrollChat.frame.size.width - 24, 32 + countFor, 300, 12)];
                labelText.numberOfLines = 0;
                labelText.textColor = [UIColor whiteColor];
                labelText.text = [dictChat objectForKey:@"message"];
                labelText.font = [UIFont fontWithName:FONTLITE size:18];
                if (isiPhone6) {
                    labelText.font = [UIFont fontWithName:FONTLITE size:16];
                } else if (isiPhone5) {
                    labelText.font = [UIFont fontWithName:FONTLITE size:12];
                    labelText.frame = CGRectMake(viewScrollChat.frame.size.width - 24, 28 + countFor, 200, 12);
                }
                [labelText sizeToFit];
                labelText.frame = CGRectMake((viewScrollChat.frame.size.width - labelText.frame.size.width) - 32, labelText.frame.origin.y, labelText.frame.size.width, labelText.frame.size.height);
                
                //Вью сообщения----------------------
                viewMessage = [[UIView alloc] initWithFrame:CGRectMake(labelText.frame.origin.x - 10, labelText.frame.origin.y - 5, labelText.frame.size.width + 20, labelText.frame.size.height + 10)];
                if (isiPhone6) {
                    viewMessage.frame = CGRectMake(labelText.frame.origin.x - 10, labelText.frame.origin.y - 3, labelText.frame.size.width + 20, labelText.frame.size.height + 6);
                } else if (isiPhone5) {
                    viewMessage.frame = CGRectMake(labelText.frame.origin.x - 10, labelText.frame.origin.y - 3, labelText.frame.size.width + 20, labelText.frame.size.height + 6);
                }
                viewMessage.backgroundColor = [UIColor colorWithHexString:@"f69679"];
                viewMessage.layer.cornerRadius = 7.f;
                [viewScrollChat addSubview:viewMessage];
                [viewScrollChat addSubview:labelText];
                
                //Создаем хвостик--------------------
                UIImageView * bubbleView = [[UIImageView alloc] initWithFrame:CGRectMake(viewMessage.frame.origin.x + viewMessage.frame.size.width - 9, viewMessage.frame.origin.y + viewMessage.frame.size.height - 7, 16, 8)];
                bubbleView.image = [UIImage imageNamed:@"bubble.png"];
                [viewScrollChat addSubview:bubbleView];
                
            //Если приходит картинка----------------------------------------
            } else if ([[dictChat objectForKey:@"type"] isEqualToString:@"image"]) {
                
                
                //Создаем картинку--------------------
                imageViewChat = [UIButton buttonWithType:UIButtonTypeCustom];
                buttonsNumber += 1;
                imageViewChat.tag = buttonsNumber;
                
                
                imageViewChat.frame = CGRectMake(viewScrollChat.frame.size.width - 282, 32 + countFor, 250, 200);
                if (isiPhone5) {
                    imageViewChat.frame = CGRectMake(viewScrollChat.frame.size.width - 222, 32 + countFor, 200, 150);
                }
                if (send) {
                    [imageViewChat setImage:[dictChat objectForKey:@"message"] forState:UIControlStateNormal];
                    [imageViewChat addTarget:self action:@selector(imageLocalViewChatAction:) forControlEvents:UIControlEventTouchUpInside];
                } else {
                    ViewSectionTable * urlViewChat = [[ViewSectionTable alloc] initImageChatWithImageURL:[dictChat objectForKey:@"message"] andContentMode:UIViewContentModeScaleAspectFill];
                    urlViewChat.userInteractionEnabled = NO;
                    urlViewChat.exclusiveTouch = NO;
                    
                    [imageViewChat addSubview:urlViewChat];
                    [imageArray addObject:[dictChat objectForKey:@"message"]];
                    [imageViewChat addTarget:self action:@selector(imageViewChatAction:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                
                
                [viewScrollChat addSubview:imageViewChat];
                
                [buttonsArray addObject:imageViewChat];

            //Если приходит аудиофайл---------------------------------------
            } else if ([[dictChat objectForKey:@"type"] isEqualToString:@"audio"]) {
                
                viewMessage = [[UIView alloc] initWithFrame:CGRectMake(viewScrollChat.frame.size.width - 112, 32 + countFor, 80, 20)];
                viewMessage.backgroundColor = [UIColor colorWithHexString:@"f69679"];
                viewMessage.layer.cornerRadius = 7.f;
                [viewScrollChat addSubview:viewMessage];
                
                //Создаем хвостик--------------------
                UIImageView * bubbleView = [[UIImageView alloc] initWithFrame:CGRectMake(viewMessage.frame.origin.x + viewMessage.frame.size.width - 9, viewMessage.frame.origin.y + viewMessage.frame.size.height - 7, 16, 8)];
                bubbleView.image = [UIImage imageNamed:@"bubble.png"];
                [viewScrollChat addSubview:bubbleView];
                NSURL * url = [NSURL URLWithString:[dictChat objectForKey:@"message"]];
                NSString * integetButtonPlayString = [NSString stringWithFormat:@"%li",integetButtonPlay];
                [soundDict setObject:url forKey:integetButtonPlayString];
                
               
                UIButton * buttonPlay = [UIButton buttonWithType:UIButtonTypeSystem];
                buttonPlay.frame = CGRectMake(5, 5, 10, 10);
                buttonPlay.backgroundColor = [UIColor blackColor];
                buttonPlay.tag = integetButtonPlay;
                [buttonPlay addTarget:self action:@selector(buttonPlayAction:) forControlEvents:UIControlEventTouchUpInside];
                [viewMessage addSubview:buttonPlay];
                
                integetButtonPlay += 1;
                
              
                
            //Ошибка------------------------------------------------
            } else {
                NSLog(@"Error");
            }
            
            //Лейбл даты-----------------------
            UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(viewScrollChat.frame.size.width - 32 - 40, viewMessage.frame.origin.y + viewMessage.frame.size.height + 5, 40, 12)];
            if ([[dictChat objectForKey:@"type"] isEqualToString:@"image"]) {
                labelData.frame = CGRectMake(viewScrollChat.frame.size.width - 32 - 40, imageViewChat.frame.origin.y + imageViewChat.frame.size.height + 5, 40, 12);
            }
            labelData.textColor = [UIColor colorWithHexString:@"8e8e93"];
            labelData.font = [UIFont fontWithName:FONTLITE size:12];
            if (isiPhone5) {
                labelData.font = [UIFont fontWithName:FONTLITE size:10];
            }
            labelData.text = [dictChat objectForKey:@"inserted"];
            [labelData sizeToFit];
            labelData.frame = CGRectMake(viewScrollChat.frame.size.width - 24 - labelData.frame.size.width, labelData.frame.origin.y, labelData.frame.size.width, labelData.frame.size.height);
            [viewScrollChat addSubview:labelData];
            
            //Создаем отступ-------------------
            if ([[dictChat objectForKey:@"type"] isEqualToString:@"message"]) {
                countFor += viewMessage.frame.size.height + 50;
            } else if ([[dictChat objectForKey:@"type"] isEqualToString:@"image"]) {
                countFor += imageViewChat.frame.size.height + 50;
            } else if ([[dictChat objectForKey:@"type"] isEqualToString:@"audio"]) {
                countFor += viewMessage.frame.size.height + 50;
            }
            
        } else {
            integerButtonName += 1;
            // Имя пользователя---------------
            UIButton * buttonUser = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonUser.frame = CGRectMake(28, 8 + countFor, 120, 12);
            buttonUser.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [buttonUser setTitleColor:[UIColor colorWithHexString:@"8e8e93"] forState:UIControlStateNormal];
            buttonUser.titleLabel.font = [UIFont fontWithName:FONTBOND size:12];
            if (isiPhone5) {
                buttonUser.titleLabel.font = [UIFont fontWithName:FONTBOND size:10];
            }
            if (send) {
                if ([[[SingleTone sharedManager] userName] isEqual: [NSNull null]]) {
                    [buttonUser setTitle:[NSString stringWithFormat:@"гость %@", [dictChat objectForKey:@"id_user"]] forState:UIControlStateNormal];
                } else {
                    [buttonUser setTitle:[[SingleTone sharedManager] userName] forState:UIControlStateNormal];
                }
            } else {
                [buttonUser setTitle:[NSString stringWithFormat:@"%@", [dictChat objectForKey:@"name"]] forState:UIControlStateNormal];
            }

            buttonUser.tag = integerButtonName;
            [buttonUser addTarget:self action:@selector(addUserNameOnTextView:) forControlEvents:UIControlEventTouchUpInside];
            [viewScrollChat addSubview:buttonUser];
            
            //Если приходит текст-------------------------------------------
            if ([[dictChat objectForKey:@"type"] isEqualToString:@"message"]) {
            
                UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(38, 32 + countFor, 300, 12)];
                labelText.numberOfLines = 0;
                labelText.text = [dictChat objectForKey:@"message"];
                labelText.font = [UIFont fontWithName:FONTLITE size:18];
                if (isiPhone6) {
                    labelText.font = [UIFont fontWithName:FONTLITE size:16];
                } else if (isiPhone5) {
                    labelText.font = [UIFont fontWithName:FONTLITE size:12];
                    labelText.frame = CGRectMake(38, 28 + countFor, 200, 12);
                }
                [labelText sizeToFit];
                
                //Вью Сообщения---------------------
                viewMessage = [[UIView alloc] initWithFrame:CGRectMake(labelText.frame.origin.x - 10, labelText.frame.origin.y - 5, labelText.frame.size.width + 20, labelText.frame.size.height + 10)];
                if (isiPhone6) {
                    viewMessage.frame = CGRectMake(labelText.frame.origin.x - 10, labelText.frame.origin.y - 3, labelText.frame.size.width + 20, labelText.frame.size.height + 6);
                } else if (isiPhone5) {
                    viewMessage.frame = CGRectMake(labelText.frame.origin.x - 10, labelText.frame.origin.y - 3, labelText.frame.size.width + 20, labelText.frame.size.height + 6);
                }
                viewMessage.backgroundColor = [UIColor colorWithHexString:@"e5e5ea"];
                viewMessage.layer.cornerRadius = 7.f;
                [viewScrollChat addSubview:viewMessage];
                [viewScrollChat addSubview:labelText];
                
                //Создаем хвостик------------------
                UIImageView * bubbleView = [[UIImageView alloc] initWithFrame:CGRectMake(32 - 7, viewMessage.frame.origin.y + viewMessage.frame.size.height - 7, 16, 8)];
                bubbleView.image = [UIImage imageNamed:@"bubble - gray.png"];
                [viewScrollChat addSubview:bubbleView];
                
                //Если приходит картинка----------------------------------------
            } else if ([[dictChat objectForKey:@"type"] isEqualToString:@"image"]) {
               
                //Создаем картинку--------------------
                imageViewChat = [UIButton buttonWithType:UIButtonTypeCustom];
                imageViewChat.frame = CGRectMake(32, 32 + countFor, 250, 200);
                if (isiPhone5) {
                    imageViewChat.frame = CGRectMake(32, 32 + countFor, 200, 150);
                }
                buttonsNumber += 1;
            
                imageViewChat.tag = buttonsNumber;
                
                if (send) {
                    [imageViewChat setImage:[dictChat objectForKey:@"message"] forState:UIControlStateNormal];
                    [imageViewChat addTarget:self action:@selector(imageLocalViewChatAction:) forControlEvents:UIControlEventTouchUpInside];
                } else {
                    ViewSectionTable * urlViewChat = [[ViewSectionTable alloc] initImageChatWithImageURL:[dictChat objectForKey:@"message"] andContentMode:UIViewContentModeScaleAspectFill];
                    urlViewChat.userInteractionEnabled = NO;
                    urlViewChat.exclusiveTouch = NO;
                   
                    [imageViewChat addSubview:urlViewChat];
                    [imageArray addObject:[dictChat objectForKey:@"message"]];
                    [imageViewChat addTarget:self action:@selector(imageViewChatAction:) forControlEvents:UIControlEventTouchUpInside];
                }
                
              
                
                [viewScrollChat addSubview:imageViewChat];
                
                [buttonsArray addObject:imageViewChat];
             
                
               
                
                
                //Если приходит аудиофайл---------------------------------------
            } else if ([[dictChat objectForKey:@"type"] isEqualToString:@"audio"]) {
                
                viewMessage = [[UIView alloc] initWithFrame:CGRectMake(32, 32 + countFor, 80, 40)];
                viewMessage.backgroundColor = [UIColor colorWithHexString:@"e5e5ea"];
                viewMessage.layer.cornerRadius = 7.f;
                [viewScrollChat addSubview:viewMessage];
                
                //Создаем хвостик------------------
                UIImageView * bubbleView = [[UIImageView alloc] initWithFrame:CGRectMake(32 - 7, viewMessage.frame.origin.y + viewMessage.frame.size.height - 7, 16, 8)];
                bubbleView.image = [UIImage imageNamed:@"bubble - gray.png"];
                [viewScrollChat addSubview:bubbleView];
                
                NSURL * url = [NSURL URLWithString:[dictChat objectForKey:@"message"]];
                NSString * integetButtonPlayString = [NSString stringWithFormat:@"%li",integetButtonPlay];
                [soundDict setObject:url forKey:integetButtonPlayString];
                
               
                
                UIButton * buttonPlay = [UIButton buttonWithType:UIButtonTypeCustom];
                buttonPlay.frame = CGRectMake(5, 5, 30, 30);
                UIImage *btnImage = [UIImage imageNamed:@"play_t.png"];
                [buttonPlay setImage:btnImage forState:UIControlStateNormal];
//                buttonPlay.backgroundColor = [UIColor blackColor];
                buttonPlay.tag = integetButtonPlay;
                [buttonPlay addTarget:self action:@selector(buttonPlayAction:) forControlEvents:UIControlEventTouchUpInside];
                [viewMessage addSubview:buttonPlay];
                
                UIActivityIndicatorView * activitiView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(35, 5, 30, 30)];
                activitiView.tag = 20+integetButtonPlay;
                
                activitiView.backgroundColor = [UIColor clearColor];
                activitiView.color = [UIColor blackColor];
                activitiView.alpha = 0.f;
                [viewMessage addSubview:activitiView];
                
                integetButtonPlay += 1;
                
                
                
                //Ошибка------------------------------------------------
            } else {
                NSLog(@"Error444");
            }
            
            //Лейбл даты-----------------------
            UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(28, viewMessage.frame.origin.y + viewMessage.frame.size.height + 5, 100, 12)];
            if ([[dictChat objectForKey:@"type"] isEqualToString:@"image"]) {
                labelData.frame = CGRectMake(28, imageViewChat.frame.origin.y + imageViewChat.frame.size.height + 5, 60, 12);
            }
            labelData.textColor = [UIColor colorWithHexString:@"8e8e93"];
            labelData.font = [UIFont fontWithName:FONTLITE size:12];
            if (isiPhone5) {
                labelData.font = [UIFont fontWithName:FONTLITE size:10];
            }
            labelData.text = [dictChat objectForKey:@"inserted"];
            [labelData sizeToFit];
            [viewScrollChat addSubview:labelData];
            
            //Создаем отступ-------------------
            if ([[dictChat objectForKey:@"type"] isEqualToString:@"message"]) {
                countFor += viewMessage.frame.size.height + 50;
            } else if ([[dictChat objectForKey:@"type"] isEqualToString:@"image"]) {
                countFor += imageViewChat.frame.size.height + 50;
            } else if ([[dictChat objectForKey:@"type"] isEqualToString:@"audio"]) {
                countFor += viewMessage.frame.size.height + 50;
            }
        }
        
        viewScrollChat.contentSize = CGSizeMake(self.frame.size.width, 20 + countFor);
        viewScrollChat.contentOffset =
        CGPointMake(0, viewScrollChat.contentSize.height - viewScrollChat.frame.size.height);
        
        //ОТСТУП
        countFor += 20;
    }
}


- (void) buttonPlayAction: (UIButton*) button
{
    
     NSURL * url = [soundDict objectForKey:[NSString stringWithFormat:@"%li",button.tag]];
    
    self.player = [[CustomPlayer alloc] initWithURL:url];
    self.player.customTag = button.tag;

    self.player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.player currentItem]];
    UIActivityIndicatorView * activitiView = [mainScrollView viewWithTag:20+button.tag];
    [activitiView setAlpha:1.0f];
    [activitiView startAnimating];
    
    [self.player play];
   
    
}

- (void)moviePlayDidEnd:(NSNotification *)notification {
        NSLog(@"Play end");
    
    [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        NSLog(@"Конец аудио");
    }];
}


#pragma mark - DEALLOC

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


//Анимация Лейблов при вводе Телефона------------------------
- (void) animationLabelChat: (NSNotification*) notification
{
    UITextField * testField = notification.object;

    if (testField.text.length != 0 && isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderChat.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderChat.frame = rect;
            labelPlaceHolderChat.alpha = 0.f;
            isBool = NO;
        }];
    } else if (testField.text.length == 0 && !isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderChat.frame;
            rect.origin.x = rect.origin.x - 100.f;
            labelPlaceHolderChat.frame = rect;
            labelPlaceHolderChat.alpha = 1.f;
            isBool = YES;
        }];
    }
    
    
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.3 animations:^{
        mainScrollView.contentOffset = (CGPoint){
            0, // ось x нас не интересует
            230 // Скроллим скролл к верхней границе текстового поля - Вы можете настроить эту величину по своему усмотрению
        };
        CGRect rect = viewScrollChat.frame;
        rect.origin.y += 230;
        rect.size.height -= 230;
        viewScrollChat.frame = rect;
        CGPoint point = viewScrollChat.contentOffset;
        point.y += 230;
        viewScrollChat.contentOffset = point;
        
        if (dictaBool) {
            
            CGRect rectDict = dictaphoneView.frame;
            CGRect rectSelf = self.frame;
            rectDict.origin.y += 200;
            rectSelf.origin.y += 200;
            dictaphoneView.frame = rectDict;
            self.frame = rectSelf;
            
            dictaBool = NO;
        }
        
    }];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{

    [UIView animateWithDuration:0.3 animations:^{
        mainScrollView.contentOffset = (CGPoint){0, 0}; // Возвращаем скролл в начало, так как редактирование текстового поля закончено
        CGRect rect = viewScrollChat.frame;
        rect.origin.y -= 230;
        rect.size.height += 230;
        viewScrollChat.frame = rect;
    }];
    return YES;
}


- (void)setFrameToTextSize:(CGRect)txtFrame textView:(UITextView *)textView
{

    
    if(txtFrame.size.height > 38.187500)
    {
       
        CGRect newFrame = inputText.frame;
        newFrame.size.height = 42;
        txtFrame.size.height = 32;
        if (isiPhone6) {
            newFrame.size.height = 48;
        } else if (isiPhone5) {
            newFrame.size.height = 44;
           
        }
        newFrame.origin.y=-15;
        [inputText setFrame:newFrame];
        
        //OK, the new frame is to large. Let's use scroll
        
        textView.scrollEnabled = YES;
        txtFrame.origin.y = 10;
        
        
        
       
        [textView scrollRangeToVisible:NSMakeRange([textView.text length], 0)];
    }
    else
    {
        
        
        txtFrame.size.height = 32;
        txtFrame.origin.y=0;
        CGRect newFrame = inputText.frame;
        newFrame.origin.y=10;
        inputText.frame = CGRectMake(64, 10, 248, 32);
        if (isiPhone6) {
            inputText.frame = CGRectMake(60, 10, 236, 28);
            
        } else if (isiPhone5) {
            inputText.frame = CGRectMake(40, 15, 220, 24);
           
        }
        
        

    }
    //set the frame
    
    textView.frame = txtFrame;
}

- (void)setframeToTextSize:(UITextView *)textView animated:(BOOL)animated
{
    //get current height
    CGRect txtFrame = textView.frame;
    
    txtFrame.size.height =[[NSString stringWithFormat:@"%@\n ",textView.text]
                           boundingRectWithSize:CGSizeMake(txtFrame.size.width, CGFLOAT_MAX)
                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:[NSDictionary dictionaryWithObjectsAndKeys:textView.font,NSFontAttributeName, nil] context:nil].size.height;
    
    if (animated) {
        //set the new frame, animated for a more nice transition
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut |UIViewAnimationOptionAllowAnimatedContent animations:^{
            [self setFrameToTextSize:txtFrame textView:textView];
        } completion:nil];
        
        
    }
    else
    {
        [self setFrameToTextSize:txtFrame textView:textView];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self setframeToTextSize:textView animated:YES];
}

#pragma mark - Action Methods


- (void)playerItemDidReachEnd:(NSNotification *)notification {

    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
    
    [self performSelector:@selector(stopPlayer) withObject:nil afterDelay:0.2];
}

- (void) stopPlayer
{

    UIActivityIndicatorView * activitiView = [mainScrollView viewWithTag:20+self.player.customTag];
    [activitiView setAlpha:0.0f];
    [activitiView stopAnimating];
    [self.player pause];
}

//Отправить запись--------------------
- (void) buttonSendAction
{
  
    [UIView animateWithDuration:(0.3) animations:^{
        buttonSend.alpha = 0.4;
        buttonSend.userInteractionEnabled = NO;
        self.labelTest.text = @"0.0";
    } completion:^(BOOL finished) {

        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_AUDIO_POST object:nil];
        
    }];
}

//Действие кнопки отправить сообщение---
- (void) pushButtonAction
{
    if (textFieldChat.text.length == 0) {
        NSLog(@"Введите текст");
    } else {
        
        //Создание даты-----------------------------------
        NSDate * date = [NSDate date];
        NSDateFormatter * inFormatDate = [[NSDateFormatter alloc] init];
        [inFormatDate setDateFormat:@"dd.MM.YYYY HH.mm"];
        NSString *strDate = [inFormatDate stringFromDate:date];
        
        NSDictionary * dictPushText = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [[SingleTone sharedManager] userID], @"id_user",
                                       textFieldChat.text, @"message",
                                       strDate, @"inserted", @"message", @"type", nil];
        
        [mArrayForPushButton addObject:dictPushText];
        [self sendMessageWithArray:mArrayForPushButton andSend:YES];
        
        NSString * textString = textFieldChat.text;
        textFieldChat.text = nil;
        
        //После отправки восстановить размеры
       
        inputText.frame = CGRectMake(64, 10, 248, 32);
        if (isiPhone6) {
            inputText.frame = CGRectMake(60, 10, 236, 28);
            
        } else if (isiPhone5) {
            inputText.frame = CGRectMake(40, 15, 220, 24);
            
        }
        //
    
        textFieldChat.frame =CGRectMake(16, 0, 210, 32);
        
        
        if (textFieldChat.text.length == 0) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect rect;
                rect = labelPlaceHolderChat.frame;
                rect.origin.x = rect.origin.x - 100.f;
                labelPlaceHolderChat.frame = rect;
                labelPlaceHolderChat.alpha = 1.f;
                isBool = YES;
            }];
        }

        [mArrayForPushButton removeAllObjects];
        NSDictionary * dictData = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [[SingleTone sharedManager] userID], @"id_user",
                                   [[SingleTone sharedManager] postID], @"id_post",
                                   textString, @"message",
                                   @"message", @"type", nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_POST_MESSAGE_IN_CHAT object:nil userInfo:dictData];
        
    }
}



//Действие кнопки загрузить фото---------
- (void) cameraButtonAction
{
    //Нотификация на запрос получения фото из галлереи---
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_REQUEST_IMAGE_FOR_DUSCUSSIONS object:nil];
}

//Загружаем фото а архив
- (void) notificationSentImage: (NSNotification*) notification
{
    //Создание даты-----------------------------------
    NSDate * date = [NSDate date];
    NSDateFormatter * inFormatDate = [[NSDateFormatter alloc] init];
    [inFormatDate setDateFormat:@"dd.MM.YYYY HH.mm"];
    NSString *strDate = [inFormatDate stringFromDate:date];
    
    
    NSDictionary * dictPushImage = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [[SingleTone sharedManager] userID], @"id_user",
                                   notification.object, @"message",
                                   strDate, @"inserted", @"image", @"type", nil];
    
    [mArrayForPushButton addObject:dictPushImage];
    [self sendMessageWithArray:mArrayForPushButton andSend:YES];
    [mArrayForPushButton removeAllObjects];
}

//Отправка Аудио Файла
- (void) testNotificationMethod: (NSNotification*) notification
{
    //Создание даты-----------------------------------
    NSDate * date = [NSDate date];
    NSDateFormatter * inFormatDate = [[NSDateFormatter alloc] init];
    [inFormatDate setDateFormat:@"dd.MM.YYYY HH.mm"];
    NSString *strDate = [inFormatDate stringFromDate:date];
    
    
    NSDictionary * dictPushText = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [[SingleTone sharedManager] userID], @"id_user",
                                   notification.object, @"message",
                                   strDate, @"inserted", @"audio", @"type", nil];
    
    [mArrayForPushButton addObject:dictPushText];
    [self sendMessageWithArray:mArrayForPushButton andSend:YES];
    [mArrayForPushButton removeAllObjects];
}

//Действие на тап картинки------------------------------
- (void) imageViewChatAction: (UIButton*) button
{
  
    
    for (int i = 0; i < imageArray.count; i++) {
        
        if (button.tag == 10 + i) {
            
            ViewSectionTable * urlViewChat = [[ViewSectionTable alloc] initImageChatWithImageURL:[imageArray objectAtIndex:i] andContentMode:UIViewContentModeScaleAspectFit andImageView:mainScrollView];
            
            [imageFull addSubview:urlViewChat];
//
            
//                imageFull.image = button.imageView.image;
//            
            
                [UIView animateWithDuration:0.3 animations:^{
                    imageFullView.alpha = 1.f;
                } completion:^(BOOL finished) {

                }];
        }    }
}
- (void) imageLocalViewChatAction: (UIButton*) button
{

    
    for (int i = 0; i < buttonsArray.count; i++) {
        
        if (button.tag == 10 + i) {
            
            //[imageFull addSubview:button.imageView];
            
            imageFull.image=button.imageView.image;
            
            
            
            
            [UIView animateWithDuration:0.3 animations:^{
                imageFullView.alpha = 1.f;
            } completion:^(BOOL finished) {
                
            }];
        }    }
}

//Действие кнопки загрузить аудиозапись--
- (void) soundButtonAction
{
    [UIView animateWithDuration:0.3 animations:^{
        
        [textFieldChat resignFirstResponder];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            if (!dictaBool) {
                CGRect rectDict = dictaphoneView.frame;
                CGRect rectSelf = self.frame;
                rectDict.origin.y -= 200;
                rectSelf.origin.y -= 200;
                dictaphoneView.frame = rectDict;
                self.frame = rectSelf;
                
                dictaBool = YES;
            } else {
                CGRect rectDict = dictaphoneView.frame;
                CGRect rectSelf = self.frame;
                rectDict.origin.y += 200;
                rectSelf.origin.y += 200;
                dictaphoneView.frame = rectDict;
                self.frame = rectSelf;
                
                dictaBool = NO;
            }
            
        } completion:^(BOOL finished) {
        }];

    }];
    }

- (void) buttonCanselImageAction
{
    [UIView animateWithDuration:0.3 animations:^{
        imageFullView.alpha = 0.f;
        
        for (UIView* b in imageFull.subviews)
        {
            [b removeFromSuperview];
        }
        
    } completion:^(BOOL finished) {

    }];
}

//Действие тапа на скрытие клавиатуры------------------------------------------
- (void) tapOnBackgroundAction
{
    [textFieldChat resignFirstResponder];
}

- (void) updateActionWithParams: (NSNotification*) notification
{
    [viewScrollChat.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    countFor = 0.f;
    
    if ([[notification.userInfo objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
        NSArray * arrayMainResponce = [NSArray arrayWithArray:[notification.userInfo objectForKey:@"data"]];
        
        [self sendMessageWithArray:arrayMainResponce andSend:NO];
    }
}

- (void) addUserNameOnTextView: (UIButton*) button
{
    NSString * stringText;
    for (int i = 1; i <= integerButtonName; i++) {
        if (button.tag == i) {
            stringText = [NSString stringWithFormat:@"%@[%@]", textFieldChat.text, button.titleLabel.text];
            textFieldChat.text = stringText;
        }
        
    }
    if (isBool) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect;
            rect = labelPlaceHolderChat.frame;
            rect.origin.x = rect.origin.x + 100.f;
            labelPlaceHolderChat.frame = rect;
            labelPlaceHolderChat.alpha = 0.f;
            isBool = NO;
            textFieldChat.text = stringText;
        }];
    }
}




@end
