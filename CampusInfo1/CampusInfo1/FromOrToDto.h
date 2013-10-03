/*
 FromOrToDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header FromOrToDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds from or to data for PublicTransportConnectionDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives station, location, prognosis, delay, arrival date/time, departure date/time and platform to be initally set or a dictionary to browse the data itself. </li>
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
#import "StationDto.h"
#import "PrognosisDto.h"
#import "DateFormation.h"

@interface FromOrToDto : NSObject
{
    /*! @var _station Stores the station of FromOrTo */
    StationDto        *_station;
    /*! @var _location Stores the location of FromOrTo */
    StationDto        *_location;
    /*! @var _prognosis Stores the prognosis of FromOrTo */
    PrognosisDto      *_prognosis;
    /*! @var _delay Stores the delay of FromOrTo */
    NSString          *_delay;
    /*! @var _arrivalDate Stores the arrival date of FromOrTo */
    NSDate            *_arrivalDate;
    /*! @var _arrivalTime Stores the arrival time of FromOrTo */
    NSDate            *_arrivalTime;
    /*! @var _departureDate Stores the arrival date of FromOrTo */
    NSDate            *_departureDate;
    /*! @var _departureTime Stores the arrival time of FromOrTo */
    NSDate            *_departureTime;
    /*! @var _platform Stores the platform of FromOrTo */
    NSString          *_platform;

    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */    
    DateFormation       *_dateFormatter;
}

@property (nonatomic, retain) DateFormation     *_dateFormatter;

@property (nonatomic, retain) StationDto        *_station;
@property (nonatomic, retain) StationDto        *_location;
@property (nonatomic, retain) PrognosisDto      *_prognosis;
@property (nonatomic, retain) NSString          *_delay;
@property (nonatomic, retain) NSDate            *_arrivalDate;
@property (nonatomic, retain) NSDate            *_arrivalTime;
@property (nonatomic, retain) NSDate            *_departureDate;
@property (nonatomic, retain) NSDate            *_departureTime;
@property (nonatomic, retain) NSString          *_platform;

/*!
 @function init
 Needs to be called initally, when instance of FromOrToDto is created.
 @param newStation
 @param newLocation
 @param newPrognosis
 @param newDelay
 @param newArrivalDate
 @param newArrivalTime
 @param newDepartureDate
 @param newDepartureTime
 @param newPlatform
 */
-(id)                   init: (StationDto *)newStation
                withLocation: (StationDto *)newLocation
               withPrognosis: (PrognosisDto *)newPrognosis
                   withDelay: (NSString *)newDelay
             withArrivalDate: (NSDate *)newArrivalDate
             withArrivalTime: (NSDate *)newArrivalTime
           withDepartureDate: (NSDate *)newDepartureDate
           withDepartureTime: (NSDate *)newDepartureTime
                withPlatform: (NSString *)newPlatform;

/*!
 @function getFromOrTo
 Is called when a new FromOrToDto instance should be created based on the dictionary information.
 @param fromOrToDictionary
 */
- (FromOrToDto *)getFromOrTo:(NSDictionary *)fromOrToDictionary;

@end
