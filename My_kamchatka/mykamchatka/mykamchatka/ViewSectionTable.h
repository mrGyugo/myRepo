//
//  ViewSectionTable.h
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

//инициализация картинки в ячейке--------------------


#import <UIKit/UIKit.h>

@interface ViewSectionTable : UIView

- (instancetype)initWithImageURL: (NSString*) imageUrl andView: (UIView*) view
                  andContentMode: (UIViewContentMode) contentMode;
- (instancetype)initSharesWithImageURL: (NSString*) imageUrl andView: (UIView*) view
                        andContentMode: (UIViewContentMode) contentMode;

@end
