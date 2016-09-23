//
//  CustomView.h
//  Dolpirog
//
//  Created by Виктор Мишустин on 19/07/16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView

- (instancetype)initWithHeight: (CGFloat) height
                       andView: (UIView*) view
                      andColor: (NSString*) color;

@end
