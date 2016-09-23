//
//  ViewSectionTable.h
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

//инициализация картинки в ячейке--------------------


#import <UIKit/UIKit.h>

@interface ViewSectionTable : UIView

- (instancetype)initWithImageURL: (NSString*) imageUrl andView: (UIView*) view
                  andContentMode: (UIViewContentMode) contentMode;

- (instancetype)initWithImageURL: (NSString*) imageUrl andView: (UIView*) view andImageView: (UIImageView*) imageView
                  andContentMode: (UIViewContentMode) contentMode;

+ (UIImageView*)createWithImageAlertURL: (NSString*) imageUrl andView: (UIView*) view andContentMode: (UIViewContentMode) contentMode andBoolMoney: (BOOL) boolMoney;

- (instancetype)initWithPostImageURL: (NSString*) imageUrl andView: (UIView*) view andContentMode: (UIViewContentMode) contentMode;

- (instancetype)initImageChatWithImageURL: (NSString*) imageUrl
                           andContentMode: (UIViewContentMode) contentMode;

- (instancetype)initImageChatWithImageURL: (NSString*) imageUrl
                           andContentMode: (UIViewContentMode) contentMode
                             andImageView: (UIScrollView *) scrollView;

@end
