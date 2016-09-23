//
//  GallaryDetailsView.h
//  mykamchatka
//
//  Created by Viktor on 24.03.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GallaryDetailsView : UIView

- (instancetype)initBackgroundWithView: (UIView*) view;
- (instancetype)initImageWithView: (UIView*) view andDict: (NSDictionary*) dict;

@end
