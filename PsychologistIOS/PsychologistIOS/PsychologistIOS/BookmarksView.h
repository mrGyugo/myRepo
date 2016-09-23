//
//  BookmarksView.h
//  PsychologistIOS
//
//  Created by Viktor on 12.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookmarksView : UIView

- (instancetype)initWithBackgroundView: (UIView*) view;

- (instancetype)initWithContent: (UIView*) view andArray: (NSArray*) array;

@end
