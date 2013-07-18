//
//  LocationDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 18.07.13.
//
//

#import "LocationDto.h"

@implementation LocationDto
@synthesize _locationId;
@synthesize _name;
@synthesize _version;

-(id)                   init: (int) newLocationId
                    withName: (NSString *)newName
                 withVersion: (NSString *)newVersion
{
    self = [super init];
    if (self)
    {
        self._locationId = newLocationId;
        self._name = newName;
        self._version = newVersion;
    }
    return self;
}

@end
