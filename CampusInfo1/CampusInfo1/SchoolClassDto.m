//
//  SchoolClassDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SchoolClassDto.h"


@implementation SchoolClassDto 
@synthesize _name;

-(id) init  : (NSString  *) newName
{
     self = [super init];
     if (self) {
         self._name = newName;
     }
     return self;
}

@end
