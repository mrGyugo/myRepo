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
        if (!isiPhone5) {
            self.frame = CGRectMake(0, 0, 180, 180);
        } else {
           self.frame = CGRectMake(0, 0, 140, 140);
        }
        self.layer.cornerRadius = 5.0;
        self.clipsToBounds = NO;
        
        
                __block UIImageView * imageViewChat = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 180)];
        if (isiPhone5) {
            imageViewChat.frame = CGRectMake(0, 0, 140, 140);
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
                                                imageViewChat.layer.cornerRadius = 5.0;
                                                imageViewChat.layer.masksToBounds = YES;
                                            } completion:nil];
                                        }
                                    }];
                [self addSubview:imageViewChat];
    }
    return self;
}

- (instancetype)initSharesWithImageURL: (NSString*) imageUrl andView: (UIView*) view andContentMode: (UIViewContentMode) contentMode
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(20, 20, view.frame.size.width - 40, view.frame.size.height - 104);
        self.clipsToBounds = NO;
        
        __block UIImageView * imageViewChat = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, view.frame.size.width - 50, view.frame.size.height - 114)];
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
                                    
                                    [UIView transitionWithView:imageViewChat duration:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                                        imageViewChat.backgroundColor=[UIColor whiteColor];
                                        imageViewChat.image = image;
                                        imageViewChat.contentMode=contentMode;
                                        imageViewChat.layer.masksToBounds = YES;
                                        imageViewChat.frame = CGRectMake(5, 10, view.frame.size.width - 50, view.frame.size.height - 20);
                                        if (!isiPhone5) {
                                            
                                            
                                        }
 
                                    } completion:nil];
                                }

                            }];
        self.frame = CGRectMake(20, 20, imageViewChat.frame.size.width, imageViewChat.frame.size.height);
        [self addSubview:imageViewChat];
        
    }
    return self;
}

@end
