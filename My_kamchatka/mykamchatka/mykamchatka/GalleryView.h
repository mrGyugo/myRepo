//
//  GalleryView.h
//  mykamchatka
//
//  Created by Viktor on 18.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryView : UIView

- (instancetype)initBackgroundWithView: (UIView*) view;
- (instancetype)initWithView: (UIView*) view ansArrayGallery: (NSArray*) array andFirst: (BOOL) first;

@end
