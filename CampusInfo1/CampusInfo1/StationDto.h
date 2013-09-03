//
//  StationDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 28.08.13.
//
//

#import <Foundation/Foundation.h>
#import <CoordinateDto.h>

@end

@interface StationDto : NSObject
{
    NSString         *_stationId;
    int               _score;    
    NSString         *_name;
    NSString         *_distance;
    CoordinateDto    *_coordinate;
}

@property (nonatomic, retain) NSString          *_stationId;
@property (nonatomic, assign) int               _score;
@property (nonatomic, retain) NSString          *_name;
@property (nonatomic, retain) NSString          *_distance;
@property (nonatomic, retain) CoordinateDto     *_coordinate;

-(id)                   init: (NSString *) newStationId
                   withScore: (int) newScore
                    withName: (NSString *)newName
                withDistance: (NSString *)newDistance
              withCoordinate: (CoordinateDto *)newCoordinate;


- (StationDto *)getStation:(NSDictionary *)stationDictionary;

@end
