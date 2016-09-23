//
//  DiscussionsController.m
//  PsychologistIOS
//
//  Created by Viktor on 07.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "DiscussionsController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"
#import "Macros.h"
#import "DiscussionsView.h"
#import "OpenSubjectModel.h"
#import <AVFoundation/AVFoundation.h>
#import "APIGetClass.h"
#import "SingleTone.h"
#import "ViewNotification.h"
#import "NotificationController.h"

const float MAX_HEIGHT_MESSAGE_TEXTBOX = 80;
const float MIN_HEIGHT_MESSAGE_TEXTBOX = 30;


@interface DiscussionsController () <AVAudioSessionDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@end

@implementation DiscussionsController
{
    NSURL *temporaryRecFile;
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
    NSData *audioData;
    NSDictionary * dictResponse;
    NSString * myURL;
    
    NSDictionary * dictResponseMessage;
    
    //Для подъема вверх
    CGFloat testFloat;
    CGFloat mainFloat;
}

- (void) viewDidLoad
{
#pragma mark - Header
    
    //Заголовок-----------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"ОБСУЖДЕНИЯ"];
    self.navigationItem.titleView = title;
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"d46559"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
#pragma mark - Post Messages NOTIFICATION
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postMessageText:) name:NOTIFICATION_POST_MESSAGE_IN_CHAT object:nil];
    
#pragma mark - Initialization
    
    [super viewDidLoad];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    [recorder setDelegate:self];
    
    [self getAPIMessageWithBlock:^{
        if ([[dictResponseMessage objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            NSArray * arrayMainResponce = [NSArray arrayWithArray:[dictResponseMessage objectForKey:@"data"]];

            for (NSDictionary * dict in arrayMainResponce) {
                NSLog(@"%@", [dict objectForKey:@"name"]);
            }
            //Загрузка контента вью для контроллера---------------------
            DiscussionsView * contentDiscussions = [[DiscussionsView alloc] initWithView:self.view andArray:arrayMainResponce];
            [self.view addSubview:contentDiscussions];
        } else {
            DiscussionsView * contentDiscussions = [[DiscussionsView alloc] initWithView:self.view andArray:nil];
            [self.view addSubview:contentDiscussions];
        }
        
        
        NSString * stringText = @"У вас 5 новых уведомлений в разделе";
        NSString * stringTitle = @"\"Женские секреты\"";
        
        ViewNotification * viewNotification = [[ViewNotification alloc] initWithView:self.view andIDDel:self andTitleLabel:stringTitle andText:stringText];
        [self.view addSubview:viewNotification];
        
    }];
    
//    //   Временнй метод для симулятор, котоорый эмулирует нотификацию он новом сообщении
//            [NSTimer scheduledTimerWithTimeInterval:7.0f
//                                                 target:self selector:@selector(loadMoreDialog) userInfo:nil repeats:YES];
    
    
    

    
    //Диктофон--------------------------------------------------
    
    //Получаем нотификацию из вью о загрузке галереи------------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifictionActionChooseImage) name:NOTIFICATION_REQUEST_IMAGE_FOR_DUSCUSSIONS object:nil];
    
    //Нотификации записи микрофона------------------------------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startRecord) name:NOTIFICATION_AUDIO_START_RECORD object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopRecord) name:NOTIFICATION_AUDIO_STOP_RECORD object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postAudio) name:NOTIFICATION_AUDIO_POST object:nil];
    
    
}

- (void) startRecord
{
    NSError *error;
    // Recording settings
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings setValue: [NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [settings setValue: [NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];
    [settings setValue: [NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
    [settings setValue: [NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [settings setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [settings setValue: [NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    [settings setValue:  [NSNumber numberWithInt: AVAudioQualityMax] forKey:AVEncoderAudioQualityKey];
    NSArray *searchPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath_ = [searchPaths objectAtIndex: 0];
    NSString *pathToSave = [documentPath_ stringByAppendingPathComponent:[self dateString]];
    // File URL
    NSURL *url = [NSURL fileURLWithPath:pathToSave];//FILEPATH];
    //Save recording path to preferences
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setURL:url forKey:@"Test1"];
    [prefs synchronize];
    
    
    // Create recorder
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    [recorder prepareToRecord];
    [recorder record];
    
 
}

- (void) stopRecord
{
    [recorder stop];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    temporaryRecFile = [prefs URLForKey:@"Test1"];
}

- (void) postAudio
{
    [self getAPIWithBlock];
}

- (NSString *) dateString
{
    // return a formatted string for a file name
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"ddMMMYY_hhmmssa";
    return [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@".aif"];
}

#pragma mark - DEALLOC

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Post Messages ACTIONS
//Отправка на сервер текстового сообщения------------
- (void) postMessageText: (NSNotification*) notification
{
    APIGetClass * apiSendMessage = [APIGetClass new];
    [apiSendMessage getDataFromServerWithParams:notification.userInfo method:@"chat_add_message" complitionBlock:^(id response) {
        
        if ([[response objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"response %@", [response objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[response objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"%@", response);
 
        }
    }];
}
//Отправка картинки на сервер--------------------------
- (void) sendMessageImageWithURL: (NSString*) stringURL
{
    APIGetClass * apiSendImage = [APIGetClass new];
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             [[SingleTone sharedManager] userID], @"id_user",
                             [[SingleTone sharedManager] postID], @"id_post",
                             stringURL, @"message",
                             @"image", @"type", nil];
    
    [apiSendImage getDataFromServerWithParams:params method:@"chat_add_message" complitionBlock:^(id response) {
        if ([[response objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"response %@", [response objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[response objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"%@", response);
            
        }
    }];
}

- (void) pushNotificationWithNotification
{
    NotificationController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationController"];
    [self.navigationController pushViewController:detail animated:YES];
}

//Отправка аудио Файла в чат----------
- (void) sendMessageAudioWithURL: (NSString*) stringURL
{
    APIGetClass * apiSendAudio = [APIGetClass new];
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             [[SingleTone sharedManager] userID], @"id_user",
                             [[SingleTone sharedManager] postID], @"id_post",
                             stringURL, @"message",
                             @"audio", @"type", nil];
    
    [apiSendAudio getDataFromServerWithParams:params method:@"chat_add_message" complitionBlock:^(id response) {
        if ([[response objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"response %@", [response objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[response objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"%@", response);
            
        }
    }];
}

#pragma mark - IMAGE

//Метод нотификации о выборе картинки--------------------------
- (void) notifictionActionChooseImage
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        picker.allowsEditing = NO;
        [self presentViewController:picker animated:true completion:nil];
        
    }
    
}

// IMAGE PICKER DELEGATE =================
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SEND_IMAGE_FOR_DUSCUSSIONS_VIEW object:image];
    [self getAPIImageWithImage:image];
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - API
//Показать Все сообщения--------------------------
- (void) getAPIMessageWithBlock: (void (^)(void))block
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             [[SingleTone sharedManager]postID], @"id_post",
                             [[SingleTone sharedManager]userID], @"id_user",nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"chat_show_message" complitionBlock:^(id response) {
        
        dictResponseMessage = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            block();
        }
    }];
}

//Загрузка изображения
- (void) getAPIImageWithImage: (UIImage*) image
{
    NSLog(@"Загружаем картинку");
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys: @"image", @"type", nil];
    APIGetClass * apiPostImage = [APIGetClass new];
    
    
    [apiPostImage getDataFromServerWithImageParams:params andImage:image method:@"upload_media" complitionBlock:^(id response) {
        NSLog(@"response %@", response);
        
        if ([[response objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
        } else if ([[response objectForKey:@"error"] integerValue] == 0) {
            NSLog(@"Удачная отправка");
            [self sendMessageImageWithURL:[response objectForKey:@"url"]];
            NSLog(@"response %@", response);
        }
    }];
}

//Загрузка АУДИО файла на сервер--------------------
- (void) getAPIWithBlock
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys: @"audio", @"type", nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithAudioParams:params andAudioURL:temporaryRecFile method:@"upload_media" complitionBlock:^(id response) {
        dictResponse = (NSDictionary*) response;
        
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            [self sendMessageAudioWithURL:[response objectForKey:@"url"]];
            NSLog(@"Удачная отправка");            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"proverkaPeredachiZvuka" object:[dictResponse objectForKey:@"url"]];
            
        }
    }];
}

- (void) loadMoreDialog
{
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             [[SingleTone sharedManager]postID], @"id_post",
                             [[SingleTone sharedManager]userID], @"id_user",nil];
    
    APIGetClass * apiGallery = [APIGetClass new];
    [apiGallery getDataFromServerWithParams:params method:@"chat_show_message" complitionBlock:^(id response) {
        
        dictResponseMessage = (NSDictionary*) response;
        
        if ([[dictResponse objectForKey:@"error"] integerValue] == 1) {
            NSLog(@"%@", [dictResponse objectForKey:@"error_msg"]);
            //ТУТ UILabel когда нет фоток там API выдает
        } else if ([[dictResponse objectForKey:@"error"] integerValue] == 0) {
            
            NSDictionary * dictResp = response;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateNotificationWithParams" object:nil userInfo: dictResp];
        }
    }];

    
}


@end
