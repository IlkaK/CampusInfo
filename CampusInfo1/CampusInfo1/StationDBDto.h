//
//  StationDBDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 16.09.13.
//
//

#import <Foundation/Foundation.h>

@interface StationDBDto : NSObject
{
    NSString         *_stationDBId;
    NSString         *_name;
    double           *_lat;
    double           *_lon;
}

@property (nonatomic, retain) NSString          *_stationDBId;
@property (nonatomic, retain) NSString          *_name;
@property (nonatomic, assign) double            _lat;
@property (nonatomic, assign) double            _lon;


-(id)                   init: (NSString *) _stationDBId
                    withName: (NSString *)newName
                     withLat: (double)newLat
                     withLon: (double)newLon;


//- (StationDBDto *)getStationDB;

@end


