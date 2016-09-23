//
//  ViewNotification.h
//  PsychologistIOS
//
//  Created by Виктор Мишустин on 19.05.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewNotification : UIView

- (instancetype)initWithView: (UIView*) view andIDDel: (id) object
               andTitleLabel: (NSString*) title andText: (NSString*) text;

@end
