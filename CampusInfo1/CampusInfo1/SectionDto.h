/*
 SectionDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header SectionDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds section data for PublicTransportConnectionDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives journey, walk, departure and arrival to be initally set or a dictionary to browse the data itself. </li>
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
#import "JourneyDto.h"
#import "FromOrToDto.h"

@interface SectionDto : NSObject
{
    /*! @var _journey Stores the journey of the section */
    JourneyDto      *_journey;
    /*! @var _walk Stores the duration of walk of the section */
    NSDate        *_walkTime;
    /*! @var _departure Stores the departure of the section */
    FromOrToDto     *_departure;
    /*! @var _arrival Stores the arrival of the section */
    FromOrToDto     *_arrival;
    
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation       *_dateFormatter;
}

@property (nonatomic, retain) DateFormation     *_dateFormatter;

@property (nonatomic, retain) JourneyDto        *_journey;
@property (nonatomic, retain) NSDate            *_walkTime;
@property (nonatomic, retain) FromOrToDto       *_departure;
@property (nonatomic, retain) FromOrToDto       *_arrival;

/*!
 @function init
 Needs to be called initally, when instance of SectionDto is created.
 @param newJourney
 @param newWalk
 @param newDeparture
 @param newArrival
 */
-(id)                     init:(JourneyDto *)newJourney
                  withWalkTime:(NSDate *)newWalkTime
                 withDeparture:(FromOrToDto *)newDeparture
                   withArrival:(FromOrToDto *)newArrival;

/*!
 @function getSection
 Is called when a new SectionDto instance should be created based on the dictionary information.
 @param sectionDictionary
 */
- (SectionDto *)getSection:(NSDictionary *)sectionDictionary;

@end
