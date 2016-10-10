//
//  ViewController.m
//  MapOfEurope
//
//  Created by Виктор Мишустин on 09.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "AlertView.h"
#import "MKMapDimOverlay.h"
#import "MKOverlayRendererView.h"

@interface ViewController () <MKMapViewDelegate>

//Map

@property (strong, nonatomic) MKMapView * mapMain;
@property (strong, nonatomic) NSMutableDictionary * dictOverlay;

//HelpPropertys

@property (strong, nonatomic) NSMutableDictionary * dictColors;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Методы инициализации
    self.dictOverlay = [NSMutableDictionary dictionary];
    self.dictColors = [NSMutableDictionary dictionary];
    
    //Инициализация карты
    self.mapMain = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapMain.backgroundColor = [UIColor blueColor];
    CLLocationCoordinate2D noLocation = CLLocationCoordinate2DMake(63.47014475, 10.01953125);
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 3500000, 3500000);
    MKCoordinateRegion adjustedRegion = [self.mapMain regionThatFits:viewRegion];
    [self.mapMain setRegion:adjustedRegion animated:NO];
    self.mapMain.zoomEnabled = NO;
    self.mapMain.rotateEnabled = NO;
    self.mapMain.delegate = self;
    [self.view addSubview:self.mapMain];
    
    //Устанавливаем данные о полигонах в дикшенери
    [self countriesOverlays];
    
    //Создание GestuteTap для вывода алерта
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(showAlertCountry:)];
    tap.cancelsTouchesInView = NO;
    [self.mapMain addGestureRecognizer:tap];
    
    //Создаем полигоны для создания overlay размером со всю карту
    [self addDimOverlay];
    
    //Массив стран Европы
    NSArray * arrayCountriesEurope = [NSArray arrayWithObjects:
                                      @"Russia", @"Albania", @"Armenia", @"Austria", @"Azerbaijan",
                                      @"Belarus", @"Belgium", @"Bosnia and Herzegovina", @"Bulgaria", @"Croatia",
                                      @"Cyprus", @"Czech Republic", @"Denmark", @"Estonia", @"Finland",
                                      @"France", @"Georgia", @"Germany", @"Greece", @"Hungary",
                                      @"Iceland", @"Ireland", @"Italy", @"Kazakhstan", @"Kosovo",
                                      @"Latvia", @"Lithuania", @"Luxembourg", @"Macedonia",
                                      @"Malta", @"Moldova", @"Montenegro", @"Netherlands",
                                      @"Norway", @"Poland", @"Portugal", @"Romania",
                                      @"Republic of Serbia", @"Slovakia", @"Slovenia", @"Spain",
                                      @"Sweden", @"Switzerland", @"Turkey", @"Ukraine",
                                      @"United Kingdom", nil];
    //Нанисим overlays стран Европы
    for (NSString * nameCountry in arrayCountriesEurope) {
        [self.mapMain addOverlays:[self.dictOverlay objectForKey:nameCountry]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Initialization Overlay Dictionary

- (void)countriesOverlays {
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"gz_2010_us_040_00_500k"
                                                         ofType:@"json"];
    NSData *overlayData = [NSData dataWithContentsOfFile:fileName];
    NSArray *countries = [[NSJSONSerialization JSONObjectWithData:overlayData
                                                          options:NSJSONReadingAllowFragments error:nil]
                                                     objectForKey:@"features"];
    
    for (NSDictionary *country in countries) {
        NSMutableArray *overlays = [[NSMutableArray alloc] init];
        NSDictionary *geometry = country[@"geometry"];
        if ([geometry[@"type"] isEqualToString:@"Polygon"]) {
            MKPolygon *polygon = [ViewController overlaysFromPolygons:geometry[@"coordinates"]
                                                                   id:country[@"properties"][@"name"]];
            if (polygon) {
                [overlays addObject:polygon];
            }
            
            
        } else if ([geometry[@"type"] isEqualToString:@"MultiPolygon"]){
            for (NSArray *polygonData in geometry[@"coordinates"]) {
                MKPolygon *polygon = [ViewController overlaysFromPolygons:polygonData
                                                                       id:country[@"properties"][@"name"]];
                if (polygon) {
                    [overlays addObject:polygon];
                }
            }
        } else {
            NSLog(@"Unsupported type: %@", geometry[@"type"]);
        }
        [self.dictOverlay setObject:overlays forKey:country[@"properties"][@"name"]];
    }
}

//Инициализация полигонов для стран.
//Если страна имеет один континент
+ (MKPolygon *)overlaysFromPolygons:(NSArray *)polygons id:(NSString *)title
{
    NSMutableArray *interiorPolygons = [NSMutableArray arrayWithCapacity:[polygons count] - 1];
    for (int i = 1; i < [polygons count]; i++) {
        [interiorPolygons addObject:[ViewController polygonFromPoints:polygons[i] interiorPolygons:nil]];
    }
    MKPolygon *overlayPolygon = [ViewController polygonFromPoints:polygons[0] interiorPolygons:interiorPolygons];
    overlayPolygon.title = title;
    

    return overlayPolygon;
}

//Если страна имеет больше чем один континент
+ (MKPolygon *)polygonFromPoints:(NSArray *)points interiorPolygons:(NSArray *)polygons
{
    NSInteger numberOfCoordinates = [points count];
    CLLocationCoordinate2D *polygonPoints = malloc(numberOfCoordinates * sizeof(CLLocationCoordinate2D));
    NSInteger index = 0;
    for (NSArray *pointArray in points) {
        polygonPoints[index] = CLLocationCoordinate2DMake([pointArray[1] floatValue],
                                                          [pointArray[0] floatValue]);
        index++;
    }
    MKPolygon *polygon;
    
    if (polygons) {
        polygon = [MKPolygon polygonWithCoordinates:polygonPoints count:numberOfCoordinates
                                   interiorPolygons:polygons];
    } else {
        polygon = [MKPolygon polygonWithCoordinates:polygonPoints count:numberOfCoordinates];
    }
    free(polygonPoints);
    return polygon;
}

#pragma mark - MKMapViewDelegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isMemberOfClass:[MKMapDimOverlay class]]) {
        MKPolygon *polygonWorld = (MKPolygon *)overlay;
        MKOverlayRendererView * poligonWorldView = [[MKOverlayRendererView alloc] initWithPolygonView:polygonWorld];
        return poligonWorldView;
    } else if ([overlay isKindOfClass:[MKPolygon class]]) {
        MKPolygon *polygon = (MKPolygon *)overlay;
            MKPolygonRenderer *renderer = [[MKPolygonRenderer alloc] initWithPolygon:polygon];
            if ([self.dictColors objectForKey:polygon.title] == nil) {
                [self.dictColors setObject:[self randomColor] forKey:polygon.title];
            }
            renderer.fillColor = [[self.dictColors objectForKey:polygon.title] colorWithAlphaComponent:1.f];
            return renderer;
    }
    return nil;
}

#pragma mark - WorldOverlay
//Создание Overlay размером со всю карту
- (void)addDimOverlay {
    MKMapDimOverlay *dimOverlay = [[MKMapDimOverlay alloc] initWithMapView:self.mapMain];
    [self.mapMain addOverlay: dimOverlay];
}

#pragma mark - ActionMethods
//Действие тапа по стране
-(void)showAlertCountry:(UIGestureRecognizer*)tap{
    CGPoint tapPoint = [tap locationInView:self.mapMain];
    CLLocationCoordinate2D tapCoord = [self.mapMain convertPoint:tapPoint
                                            toCoordinateFromView:self.mapMain];
    MKMapPoint mapPoint = MKMapPointForCoordinate(tapCoord);
    CGPoint mapPointAsCGP = CGPointMake(mapPoint.x, mapPoint.y);
    for (id<MKOverlay> overlay in self.mapMain.overlays) {
        if([overlay isKindOfClass:[MKPolygon class]]){
            MKPolygon *polygon = (MKPolygon*) overlay;
            
            CGMutablePathRef mpr = CGPathCreateMutable();
            
            MKMapPoint *polygonPoints = polygon.points;
            
            for (int p=0; p < polygon.pointCount; p++){
                MKMapPoint mp = polygonPoints[p];
                if (p == 0)
                    CGPathMoveToPoint(mpr, NULL, mp.x, mp.y);
                else
                    CGPathAddLineToPoint(mpr, NULL, mp.x, mp.y);
            }
            
            if(CGPathContainsPoint(mpr , NULL, mapPointAsCGP, FALSE)){
                [AlertView showAlertViewWithCountry:polygon.title andColor:[self.dictColors objectForKey:polygon.title]];
            }
            
            CGPathRelease(mpr);
        }
    }
}

#pragma mark - Help Methods

- (UIColor*) randomColor {
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}


@end
