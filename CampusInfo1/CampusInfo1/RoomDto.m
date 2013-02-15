//
//  RoomDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RoomDto.h"


@implementation RoomDto
@synthesize _name;

-(id) init : (NSString  *) newName
{
    self = [super init];
    if (self) {
        self._name = newName;
    }
    return self;
}

-(void) dealloc {
    self._name = nil;
    [super dealloc];
}

@end
