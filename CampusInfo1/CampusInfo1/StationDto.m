//
//  StationDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 28.08.13.
//
//

#import "StationDto.h"

@implementation StationDto

@synthesize _coordinate;
@synthesize _distance;
@synthesize _name;
@synthesize _score;
@synthesize _stationId;

-(id)                   init: (int) newStationId
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


- (StationDto *)getStation:(NSDictionary *)stationDictionary
{
    int             _localStationId;
    int             _localScore;
    NSString        *_localName;
    NSString        *_localDistance;
    CoordinateDto   *_localCoordinate   = [[CoordinateDto alloc]init:nil withX:0 withY:0];
    StationDto      *_localStation      = [[StationDto alloc]init:nil withScore:nil withName:nil withDistance:nil withCoordinate:nil];
    
    for (id stationKey in stationDictionary)
    {
        if ([stationDictionary objectForKey:stationKey] != [NSNull null])
        {
            
            if ([stationKey isEqualToString:@"id"])
            {
                _localStationId = [[stationDictionary objectForKey:stationKey] intValue];
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
