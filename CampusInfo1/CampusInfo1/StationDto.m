/*
 StationDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header StationDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds station data for PublicTransportDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives station id, score, name, distance and coordinate to be initally set or a dictionary to browse the data itself. </li>
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


#import "StationDto.h"

@implementation StationDto

@synthesize _coordinate;
@synthesize _distance;
@synthesize _name;
@synthesize _score;
@synthesize _stationId;

/*!
 @function init
 Needs to be called initally, when instance of StationDto is created.
 @param newStationId
 @param newScore
 @param newName
 @param newDistance
 @param newCoordinate
 */
-(id)                   init: (NSString *) newStationId
                   withScore: (int) newScore
                    withName: (NSString *)newName
                withDistance: (NSString *)newDistance
              withCoordinate: (CoordinateDto *)newCoordinate
{
    self = [super init];
    if (self)
    {
        self._stationId     = newStationId;
        self._score         = newScore;
        self._name          = newName;
        self._distance      = newDistance;
        self._coordinate    = newCoordinate;
    }
    return self;
}

/*!
 @function getStation
 Is called when a new StationDto instance should be created based on the stationDictionary information.
 @param stationDictionary
 */
- (StationDto *)getStation:(NSDictionary *)stationDictionary
{
    NSString        *_localStationId;
    int             _localScore;
    NSString        *_localName;
    NSString        *_localDistance;
    CoordinateDto   *_localCoordinate   = [[CoordinateDto alloc]init:nil withX:0 withY:0];
    StationDto      *_localStation      = [[StationDto alloc]init:nil withScore:0 withName:nil withDistance:nil withCoordinate:nil];
    
    for (id stationKey in stationDictionary)
    {
        if ([stationDictionary objectForKey:stationKey] != [NSNull null])
        {
            
            if ([stationKey isEqualToString:@"id"])
            {
                _localStationId = [stationDictionary objectForKey:stationKey];
                //NSLog(@"StationDto _localStationId: %i", _localStationId);
            }

            if ([stationKey isEqualToString:@"score"])
            {
            
                _localScore = [[stationDictionary objectForKey:stationKey] intValue];
                //NSLog(@"StationDto _localScore: %i", _localScore);
            }
        
            if ([stationKey isEqualToString:@"name"])
            {
                _localName = [stationDictionary objectForKey:stationKey];
                //NSLog(@"StationDto _localName: %@", _localName);
            }

            if ([stationKey isEqualToString:@"distance"])
            {
                _localDistance = [stationDictionary objectForKey:stationKey];
                //NSLog(@"StationDto _localDistance: %@", _localDistance);
            }
        
            if ([stationKey isEqualToString:@"coordinate"])
            {
                _localCoordinate = [_localCoordinate getCoordinate:[stationDictionary objectForKey:stationKey]];
            }
        }
    }
    
     _localStation      = [[StationDto alloc]init:_localStationId
                                        withScore:_localScore
                                         withName:_localName
                                     withDistance:_localDistance
                                   withCoordinate:_localCoordinate];
    return _localStation;
}

@end
