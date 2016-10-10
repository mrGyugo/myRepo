//
//  ViewController.m
//  Сheckers
//
//  Created by Виктор Мишустин on 05.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIView * viewBoard; //Отображение достки
@property (strong, nonatomic) NSMutableArray * arrayActiveBoxes; //Массив активных ячеек
@property (strong, nonatomic) NSMutableArray * arrayMyCheckers; //Массив моих шашек
@property (strong, nonatomic) NSMutableArray * arrayEnemyCheckers; //Массив вражеских шашек


//ForActiveBoxs

@property (assign, nonatomic) CGFloat lengthAvtiveBox; //Длинна активного квадрата

//Draggin

@property (weak, nonatomic) UIView * dragginView; //Вью которое мы двигаем
@property (assign, nonatomic) CGPoint touchOffcet; //Отступ для правильно анимации тача
@property (assign, nonatomic) CGPoint corrction; //Конечная точка перемещения объекта

@property (assign, nonatomic) CGPoint startPoint; //Стартовое положение фишки
@property (assign, nonatomic) BOOL activeBox; //Попали в активный бокс или нет
@property (assign, nonatomic) CGPoint startPoints;

@property (strong, nonatomic) NSMutableArray * arrayAllCkeckers; //Массив всех шашек;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Инициализация массивов
    self.arrayActiveBoxes = [NSMutableArray array];
    self.arrayMyCheckers = [NSMutableArray array];
    self.arrayEnemyCheckers = [NSMutableArray array];
    self.arrayAllCkeckers = [NSMutableArray array];
    
    //Отображение визуальных объектов-----------------------------------
    //Отображение доски
    self.viewBoard = [self createBoardWithMainView:self.view];
    self.lengthAvtiveBox = CGRectGetWidth(self.viewBoard.bounds) / 8;
    
    //Отображение активных боксов
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            if (i % 2 - j % 2 == 0) {
                UIView * viewActiveBox = [self createActiveBoxViewWithMainView:self.viewBoard
                                                                   andPosition:CGPointMake(self.lengthAvtiveBox * i,
                                                                                           self.lengthAvtiveBox * j)];
                [self.arrayActiveBoxes addObject:viewActiveBox];
            }
        }
    }
    
    //Отображение шашек
    for (UIView * view in self.arrayActiveBoxes) {
        if (CGRectGetMinY(view.frame) / CGRectGetWidth(view.frame) > 4) { //Отображение наших шашек
            UIView * viewChecker = [self createCheckerViewWithMainView:self.viewBoard andForWhom:YES];
            viewChecker.center = view.center;
            [self.arrayMyCheckers addObject:viewChecker];
        } else if (CGRectGetMinY(view.frame) / CGRectGetWidth(view.frame) < 3) { //Отображение вражеских шашек
            UIView * viewChecker = [self createCheckerViewWithMainView:self.viewBoard andForWhom:NO];
            viewChecker.center = view.center;
            [self.arrayEnemyCheckers addObject:viewChecker];
        }
    }
    
    //Создание общего массива шашек
    [self.arrayAllCkeckers addObjectsFromArray:self.arrayMyCheckers];
    [self.arrayAllCkeckers addObjectsFromArray:self.arrayEnemyCheckers];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Creation Views

- (UIView*) createBoardWithMainView: (UIView*) mainView {
    UIView * boardView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, CGRectGetWidth(mainView.frame) - 60,
                                                                    CGRectGetWidth(mainView.frame) - 60)];
    boardView.center = mainView.center;
    boardView.layer.borderColor = [UIColor blackColor].CGColor;
    boardView.layer.borderWidth = 2;
    boardView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    boardView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin    |
                            UIViewAutoresizingFlexibleRightMargin   |
                            UIViewAutoresizingFlexibleTopMargin     |
                            UIViewAutoresizingFlexibleBottomMargin;
    [mainView addSubview:boardView];
    
    return boardView;
}

- (UIView*) createActiveBoxViewWithMainView: (UIView*) mainView andPosition: (CGPoint) position {
    UIView * activeBoxView = [[UIView alloc] initWithFrame:CGRectMake(position.x, position.y,
                                                                      CGRectGetWidth(mainView.bounds) / 8,
                                                                      CGRectGetWidth(mainView.bounds) / 8)];
    activeBoxView.backgroundColor = [UIColor darkGrayColor];
    [mainView addSubview:activeBoxView];
    
    return activeBoxView;
    
}

- (UIView*) createCheckerViewWithMainView: (UIView*) mainView
                               andForWhom: (BOOL) forWhom  { //Если YES шашки наши, если NO шашки противника
    UIView * checkerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(mainView.bounds) / 8 - 50, CGRectGetWidth(mainView.bounds) / 8 - 50)];
    checkerView.layer.cornerRadius = CGRectGetWidth(checkerView.frame) / 2;
    
    if (forWhom) {
        checkerView.backgroundColor = [UIColor whiteColor];
    } else {
        checkerView.backgroundColor = [UIColor blackColor];
    }
    [mainView addSubview:checkerView];
    return checkerView;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    UITouch * touch = [touches anyObject];
    CGPoint pointOnMainView = [touch locationInView:self.view];
    UIView * view = [self.view hitTest:pointOnMainView withEvent:event];
    
    if ([self checkObject:view inArray:self.arrayMyCheckers] || [self checkObject:view inArray:self.arrayEnemyCheckers]) {
        self.dragginView = view;
        
        self.startPoints = view.center;
        
        [self.viewBoard bringSubviewToFront:self.dragginView];
        
        CGPoint touchPoint = [touch locationInView:self.dragginView];
        
        self.touchOffcet = CGPointMake(CGRectGetMidX(self.dragginView.bounds) - touchPoint.x - CGRectGetMinX(self.viewBoard.frame),
                                       CGRectGetMidY(self.dragginView.bounds) - touchPoint.y - CGRectGetMinY(self.viewBoard.frame));
        
        [self.dragginView.layer removeAllAnimations];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.dragginView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            self.dragginView.alpha = 0.3;
        }];
    } else {
            self.dragginView = nil;
        }

    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    if (self.dragginView) {
        UITouch * touch = [touches anyObject];
        
        CGPoint pointOnMainView = [touch locationInView:self.view];
        self.corrction = CGPointMake(pointOnMainView.x + self.touchOffcet.x,
                                        pointOnMainView.y + self.touchOffcet.y);
        self.dragginView.center = self.corrction;
    }
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self cancelAnimation];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self cancelAnimation];
}

#pragma mark - Animation

- (void) cancelAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        for (UIView * view in self.arrayAllCkeckers) {
            view.userInteractionEnabled = NO;
        }
        CGPoint testPoint = [self checkCentreActiveBoxWithTouchPoint:self.corrction];
        self.dragginView.center = [self checkChekersWithPointTouchWithCGPoint:testPoint];
        self.dragginView.transform = CGAffineTransformMakeScale(1.f, 1.f);
        self.dragginView.alpha = 1.f;
    } completion:^(BOOL finished) {
        for (UIView * view in self.arrayAllCkeckers) {
            view.userInteractionEnabled = YES;
        }
    }];
}

#pragma mark - Help Methods

- (BOOL) checkObject: (id) object inArray: (NSMutableArray*) array {
    for (UIView * viewArray in array) {
        if ([object isEqual:viewArray]) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - Move Methods

- (CGPoint) checkCentreActiveBoxWithTouchPoint: (CGPoint) touchPoint {
    for (UIView * view in self.arrayActiveBoxes) {
        if (CGRectContainsPoint(view.frame, touchPoint)) {
            self.startPoint = view.center;
            self.activeBox = YES;
            return view.center;
        }
    }
    return [self checkCenterNonActiveBoxWithTouchPoint:touchPoint];
}

- (CGPoint) checkCenterNonActiveBoxWithTouchPoint: (CGPoint) touchPoint {
    CGPoint mainPoin = CGPointZero;
    CGFloat mainCentr = NSNotFound;
    
    for (UIView * view in self.arrayActiveBoxes) {
        CGFloat testfloat = [self distanceBetweenRect:view.frame andPoint:touchPoint];
        if (testfloat < mainCentr) {
            mainCentr = testfloat;
            mainPoin = view.center;
        }
    }
    self.startPoint = mainPoin;
    self.activeBox = NO;
    return mainPoin;
}

- (CGFloat)distanceBetweenRect:(CGRect)rect andPoint:(CGPoint)point
{
    // first of all, we check if point is inside rect. If it is, distance is zero
    if (CGRectContainsPoint(rect, point)) return 0.f;
    
    // next we see which point in rect is closest to point
    CGPoint closest = rect.origin;
    if (rect.origin.x + rect.size.width < point.x)
        closest.x += rect.size.width; // point is far right of us
    else if (point.x > rect.origin.x)
        closest.x = point.x; // point above or below us
    if (rect.origin.y + rect.size.height < point.y)
        closest.y += rect.size.height; // point is far below us
    else if (point.y > rect.origin.y)
        closest.y = point.y; // point is straight left or right
    
    // we've got a closest point; now pythagorean theorem
    // distance^2 = [closest.x,y - closest.x,point.y]^2 + [closest.x,point.y - point.x,y]^2
    // i.e. [closest.y-point.y]^2 + [closest.x-point.x]^2
    CGFloat a = powf(closest.y-point.y, 2.f);
    CGFloat b = powf(closest.x-point.x, 2.f);
    return sqrtf(a + b);
}

- (CGPoint) checkChekersWithPointTouchWithCGPoint: (CGPoint) tuochPoint {
    NSInteger counter;
    if (self.activeBox) {
        counter = 0;
    } else {
        counter = 1;
    }
    
    for (UIView * view in self.arrayAllCkeckers) {
        if (CGRectContainsPoint(view.frame, self.startPoint)) {
            counter += 1;
        }
    }
    if (counter > 1) {
        return self.startPoints;
    } else {
        return tuochPoint;
    }
};


@end
