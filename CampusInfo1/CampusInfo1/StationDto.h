/*
 StationDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header StationDto.h
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

#import <Foundation/Foundation.h>
#import "CoordinateDto.h"

@end

@interface StationDto : NSObject
{
    /*! @var _stationId Stores the id of the station */
    NSString         *_stationId;
    /*! @var _score Stores the score of the station */
    int               _score;
    /*! @var _name Stores the name of the station */
    NSString         *_name;
    /*! @var _distance Stores the distance of the station */
    NSString         *_distance;
    /*! @var _coordinate Stores the coordinates of the station */
    CoordinateDto    *_coordinate;
}

@property (nonatomic, retain) NSString          *_stationId;
@property (nonatomic, assign) int               _score;
@property (nonatomic, retain) NSString          *_name;
@property (nonatomic, retain) NSString          *_distance;
@property (nonatomic, retain) CoordinateDto     *_coordinate;

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
              withCoordinate: (CoordinateDto *)newCoordinate;

/*!
 @function getStation
 Is called when a new StationDto instance should be created based on the stationDictionary information.
 @param stationDictionary
 */
- (StationDto *)getStation:(NSDictionary *)stationDictionary;

@end
