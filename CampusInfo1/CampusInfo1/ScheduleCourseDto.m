//
//  ScheduleCourseDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 07.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleCourseDto.h"

@implementation ScheduleCourseDto

@synthesize _name, _description;


-(id) init 
: (NSString *) newName
: (NSString *) newDescription
{
    self = [super init];
    if (self) {
        self._name        = newName;
        self._description = newDescription;
    }
    return self;
}


- (ScheduleCourseDto *) getScheduleCourseWithDictionary:(NSDictionary *)dictionary withKey:(id) key
{
    ScheduleCourseDto *_localCourse       = nil;
    NSString          *_courseName        = nil;
    NSString          *_courseDescription = nil;
    NSDictionary      *_courseDictionary  = [dictionary objectForKey:key];
    
    if (_courseDictionary != (id)[NSNull null])
    {
        for (id courseKey in _courseDictionary)
        {
            if ([courseKey isEqualToString:@"name"])
            {
                _courseName        = [_courseDictionary objectForKey:courseKey];
            }
            if ([courseKey isEqualToString:@"description"])
            {
                _courseDescription = [_courseDictionary objectForKey:courseKey];
            }
            
        }
        _localCourse    = [[ScheduleCourseDto alloc]init:_courseName:_courseDescription];
    }
    return _localCourse;
}



@end
