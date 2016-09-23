//
//  CategoryView.h
//  PsychologistIOS
//
//  Created by Viktor on 01.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryView : UIView <UISearchBarDelegate>

- (instancetype)initWithBackgroundView: (UIView*) view;
- (instancetype)initWithContent: (UIView*) view andArray: (NSArray*) array;

@end
