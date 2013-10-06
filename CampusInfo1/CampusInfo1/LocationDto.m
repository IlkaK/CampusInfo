/*
 LocationDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header LocationDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the location data in MensaOverviewDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives location id, name and version to be initally set or a dictionary to browse the data itself. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It returns itself when called. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "LocationDto.h"

@implementation LocationDto
@synthesize _locationId;
@synthesize _name;
@synthesize _version;

/*!
 @function init
 Initializes LocationDto.
 @param newLocationId
 @param newName
 @param newVersion
 */
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

/*!
 @function getLocation
 Is called when a new LocationDto instance should be created based on the dictionary information.
 @param locationDictionary
 */
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
