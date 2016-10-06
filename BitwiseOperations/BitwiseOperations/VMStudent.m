//
//  VMStudent.m
//  BitwiseOperations
//
//  Created by Виктор Мишустин on 27.09.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "VMStudent.h"

@implementation VMStudent

- (NSString*) description {
    
    return [NSString stringWithFormat:  @"Student studies:\n"
                                        "studiesBiology = %@\n"
                                        "studiesMath = %@\n"
                                        "studiesDevelopment = %@\n"
                                        "studiesEngineering = %@\n"
                                        "studiesArt = %@\n"
                                        "studiesPhycology = %@\n"
                                        "studiesAnatomy = %@\n",
            [self answerByType:VMStudentSubjectTypeBiology],
            [self answerByType:VMStudentSubjectTypeMath],
            [self answerByType:VMStudentSubjectTypeDevelopment],
            [self answerByType:VMStudentSubjectTypeEngineering],
            [self answerByType:VMStudentSubjectTypeArt],
            [self answerByType:VMStudentSubjectTypePhycology],
            [self answerByType:VMStudentSubjectTypeAnatomy]];
    
    
}


- (NSString*) answerByType: (VMStudentSubjectType) type {
    
    return self.subjectType & type ? @"yes" : @"no";
    
}


@end
