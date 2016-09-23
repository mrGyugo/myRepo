//
//  ViewSectionTable.m
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

//Создание изображения товара

#import "ViewSectionTable.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "UIImage+Resize.h"//Ресайз изображения
#import "Macros.h"


@implementation ViewSectionTable

- (instancetype)initWithImageURL: (NSString*) imageUrl andView: (UIView*) view andContentMode: (UIViewContentMode) contentMode
{
    self = [super init];
    if (self) {
            self.frame = CGRectMake(0, 0, 96, 96);
        if (isiPhone6) {
            self.frame = CGRectMake(0, 0, 88, 88);
        } else if (isiPhone5) {
            self.frame = CGRectMake(0, 0, 78, 78);
        }
        

        self.clipsToBounds = NO;
        
        
                __block UIImageView * imageViewChat = [[UIImageView alloc] initWithFrame:CGRectMake(16, 0, 96, 96)];
        if (isiPhone6) {
            imageViewChat.frame = CGRectMake(0, 0, 88, 88);
        } else if (isiPhone5) {
            imageViewChat.frame = CGRectMake(0, 0, 78, 78);        }

                NSURL *imgURL = [NSURL URLWithString:imageUrl];
        
                //SingleTone с ресайз изображения
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                [manager downloadImageWithURL:imgURL
                                      options:0
                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                         // progression tracking code
                                     }
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                        if(image){
        
                                            [UIView transitionWithView:imageViewChat duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                                imageViewChat.image = image;
                                                imageViewChat.contentMode=contentMode;
                                                imageViewChat.layer.masksToBounds = YES;
                                            } completion:nil];
                                        }
                                    }];
                [self addSubview:imageViewChat];
    }
    return self;
}

- (instancetype)initWithImageURL: (NSString*) imageUrl andView: (UIView*) view andImageView: (UIImageView*) imageView
                  andContentMode: (UIViewContentMode) contentMode
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 96, 96);
        if (isiPhone6) {
            self.frame = CGRectMake(0, 0, 88, 88);
        } else if (isiPhone5) {
            self.frame = CGRectMake(0, 0, 78, 78);
        }
        
        
        self.clipsToBounds = NO;
        
    
        
        NSURL *imgURL = [NSURL URLWithString:imageUrl];
        
        //SingleTone с ресайз изображения
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:imgURL
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if(image){
                                    
                                    [UIView transitionWithView:imageView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                        imageView.image = image;
                                        imageView.contentMode=contentMode;
                                        imageView.layer.masksToBounds = YES;
                                    } completion:nil];
                                }
                            }];
        [self addSubview:imageView];
    }
    return self;
}

//Картинка на алерт
+ (UIImageView*) createWithImageAlertURL: (NSString*) imageUrl andView: (UIView*) view andContentMode: (UIViewContentMode) contentMode andBoolMoney: (BOOL) boolMoney
{
    
    __block UIImageView * imageViewChat = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    if (isiPhone5) {
        imageViewChat.frame = CGRectMake(view.frame.size.width / 2 - 20, 16, 40, 40);
    }
    
    if (boolMoney) {
        
        imageViewChat.image = [UIImage imageNamed:@"imageMoney.png"];
        
    } else {
        
        
        NSURL *imgURL = [NSURL URLWithString:imageUrl];
        
        //SingleTone с ресайз изображения
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:imgURL
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if(image){
                                    
                                    [UIView transitionWithView:imageViewChat duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                        imageViewChat.image = image;
                                   
                                        imageViewChat.contentMode=contentMode;
                                        imageViewChat.layer.cornerRadius = 20.f;
                                        imageViewChat.layer.masksToBounds = YES;
                                    } completion:nil];
                                }
                            }];
    }
    return imageViewChat;
    
}


//Картинка под раскрытие поста--------
- (instancetype)initWithPostImageURL: (NSString*) imageUrl andView: (UIView*) view andContentMode: (UIViewContentMode) contentMode
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, 160);
        if (isiPhone5) {
            self.frame = CGRectMake(0, 0, view.frame.size.width, 110);
        }
        
        
        self.clipsToBounds = NO;
        
        
        __block UIImageView * imageViewChat = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 160)];
        if (isiPhone5) {
            imageViewChat.frame = CGRectMake(0, 0, view.frame.size.width, 110);
        }
        
        NSURL *imgURL = [NSURL URLWithString:imageUrl];
        
        //SingleTone с ресайз изображения
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:imgURL
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if(image){
                                    
                                    [UIView transitionWithView:imageViewChat duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                        imageViewChat.image = image;
                                        imageViewChat.contentMode=contentMode;
                                        imageViewChat.layer.masksToBounds = YES;
                                    } completion:nil];
                                }
                            }];
        [self addSubview:imageViewChat];
    }
    return self;
}

//Картинка для чата
- (instancetype)initImageChatWithImageURL: (NSString*) imageUrl
                           andContentMode: (UIViewContentMode) contentMode
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 250, 200);
        if (isiPhone5) {
            self.frame = CGRectMake(0, 0, 200, 150);
        }
        
        
        self.clipsToBounds = NO;
        
        
        __block UIImageView * imageViewChat = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 200)];
        if (isiPhone5) {
            imageViewChat.frame = CGRectMake(0, 0, 200, 150);
        }
        
        NSURL *imgURL = [NSURL URLWithString:imageUrl];
        
        //SingleTone с ресайз изображения
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:imgURL
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if(image){
                                    
                                    [UIView transitionWithView:imageViewChat duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                        imageViewChat.image = image;
                                        imageViewChat.contentMode=contentMode;
                                        imageViewChat.layer.masksToBounds = YES;
                                    } completion:nil];
                                }
                            }];
        [self addSubview:imageViewChat];
    }
    return self;
}

//Картинка для чата большая
- (instancetype)initImageChatWithImageURL: (NSString*) imageUrl
                           andContentMode: (UIViewContentMode) contentMode
                             andImageView: (UIScrollView *) scrollView
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, scrollView.bounds.size.width, scrollView.bounds.size.height);
        if (isiPhone5) {
            self.frame = CGRectMake(0, 0, 200, 150);
        }
        
        
        self.clipsToBounds = NO;
        
        __block UIImageView * imageViewChat = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
        
        
        
        NSURL *imgURL = [NSURL URLWithString:imageUrl];
        
        //SingleTone с ресайз изображения
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:imgURL
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if(image){
                                    
                                    [UIView transitionWithView:imageViewChat duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                        imageViewChat.image = image;
                                        imageViewChat.contentMode=contentMode;
                                        imageViewChat.layer.masksToBounds = YES;
                                    } completion:nil];
                                }
                            }];
        [self addSubview:imageViewChat];
    }
    return self;
}





@end
