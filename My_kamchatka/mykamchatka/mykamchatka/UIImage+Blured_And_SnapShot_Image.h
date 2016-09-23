//
//  UIImage+Blured_And_SnapShot_Image.h
//  ALCOMATH
//
//  Created by Lowtrack on 10.02.15.
//  Copyright (c) 2015 Vladimir Popov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blured_And_SnapShot_Image)
+ (UIImage *)blurBackgroundView:(UIView *)backgroundView Radius: (int) radius;
+ (UIImage *)takeSnapshotOfView:(UIView *)view;
+ (UIImage *)blurWithGPUImage:(UIImage *)sourceImage Radius: (int) radius Color: (UIColor *) tintColor;


@end
