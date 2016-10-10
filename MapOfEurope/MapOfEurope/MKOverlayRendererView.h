//
//  MKOverlayRendererView.h
//  MapOfEurope
//
//  Created by Виктор Мишустин on 10.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKOverlayRendererView : MKOverlayRenderer

- (instancetype)initWithPolygonView:(id <MKOverlay>)overlay;


@property (nonatomic, strong) UIColor *overlayColor;

@property (nonatomic) CGFloat overlayAlpha;

@end
