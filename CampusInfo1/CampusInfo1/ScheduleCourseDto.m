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



@end
