//
//  TextHeight.h
//  Lesson7HW
//
//  Created by Кирилл Ковыршин on 05.10.15.
//  Copyright © 2015 datastore24. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface TextAndImageHeight : NSObject

- (CGFloat)getHeightForText:(NSString*)text textWith:(CGFloat)textWith withFont: (UIFont *) font;
- (CGFloat) getHeightForImageViewWithTargetWidth: (CGFloat) targetWidth imageWith:(CGFloat) imageWith imageHeight:(CGFloat ) imageHeight;


@end
