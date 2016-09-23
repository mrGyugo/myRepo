//
//  RecommendView.h
//  PsychologistIOS
//
//  Created by Viktor on 10.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendView : UIView <UITextFieldDelegate>

- (instancetype)initWithView: (UIView*) view andArray: (NSArray*) array;

@end
