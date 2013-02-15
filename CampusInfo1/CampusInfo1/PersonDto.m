//
//  PersonDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PersonDto.h"


@implementation PersonDto

@synthesize _shortName, _firstName, _lastName, _type, _department;

-(id) init 
: (NSString      *) newShortName
: (NSString      *) newFirstName
: (NSString      *) newLastName
: (NSString      *) newType
: (DepartmentDto *) newDepartment
{
    self = [super init];
    if (self) {
        self._shortName  = newShortName;
        self._firstName  = newFirstName;
        self._lastName   = newLastName;
        self._type       = newType;
        self._department = newDepartment;

    }
    return self;
}

-(void) dealloc {
    self._shortName  = nil;
    self._firstName  = nil;
    self._lastName   = nil;
    self._type       = nil;
    self._department = nil;
    [super dealloc];
}

@end

