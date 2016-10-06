//
//  VMStudent.h
//  BitwiseOperations
//
//  Created by Виктор Мишустин on 27.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    VMStudentSubjectTypeBiology             = 1 << 0,
    VMStudentSubjectTypeMath                = 1 << 1,
    VMStudentSubjectTypeDevelopment         = 1 << 2,
    VMStudentSubjectTypeEngineering         = 1 << 3,
    VMStudentSubjectTypeArt                 = 1 << 4,
    VMStudentSubjectTypePhycology           = 1 << 5,
    VMStudentSubjectTypeAnatomy             = 1 << 6,
    
} VMStudentSubjectType;

@interface VMStudent : NSObject


@property (assign, nonatomic) VMStudentSubjectType subjectType;

@end
