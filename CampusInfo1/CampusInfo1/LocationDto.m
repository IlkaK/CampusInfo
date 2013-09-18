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
        self._locationId    = newLocationId;
        self._name          = newName;
        self._version       = newVersion;
    }
    return self;
}


- (LocationDto *)getLocation:(NSDictionary *)locationDictionary
{
    int _localLocationId;
    NSString *_localVersion;
    NSString *_localName;
    
    LocationDto *_localLocation = [[LocationDto alloc]init:0 withName:nil withVersion:nil];
    
    for (id locationKey in locationDictionary)
    {
        if ([locationKey isEqualToString:@"id"])
        {
            _localLocationId = [[locationDictionary objectForKey:locationKey] intValue];
            //NSLog(@"location id: %i", _localLocationId);
        }
        if ([locationKey isEqualToString:@"version"])
        {
            _localVersion = [locationDictionary objectForKey:locationKey];
            //NSLog(@"location version: %@", _localVersion);
        }
        if ([locationKey isEqualToString:@"name"])
        {
            _localName = [locationDictionary objectForKey:locationKey];
            //NSLog(@"location name: %@", _localName);
        }
    }
    _localLocation = [[LocationDto alloc]init:_localLocationId withName:_localName withVersion:_localVersion];
    return _localLocation;
}


@end
