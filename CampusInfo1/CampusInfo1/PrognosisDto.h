/*
 PrognosisDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header PrognosisDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds prognosis data for PublicTransportConnectionDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives platform, arrival, departure and capacity ids to be initally set or a dictionary to browse the data itself. </li>
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
#import "DateFormation.h"

@interface PrognosisDto : NSObject
{
    /*! @var _platform Stores the platform of the prognosis */
    NSString        *_platform;
    /*! @var _arrival Stores the arrival of the prognosis */
    NSDate          *_arrival;
    /*! @var _departure Stores the departure of the prognosis */
    NSDate          *_departure;
    /*! @var _capacity1st Stores the first capacity of the prognosis */
    int               _capacity1st;
    /*! @var _capacity2nd Stores the second capacity of the prognosis */
    int               _capacity2nd;
    
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation   *_dateFormatter;
}

@property (nonatomic, retain) NSString          *_platform;
@property (nonatomic, retain) NSDate            *_arrival;
@property (nonatomic, retain) NSDate            *_departure;
@property (nonatomic, assign) int               _capacity1st;
@property (nonatomic, assign) int               _capacity2nd;

@property (nonatomic, retain) DateFormation     *_dateFormatter;

/*!
 @function init
 Needs to be called initally, when instance of PrognosisDto is created.
 @param newPlatform
 @param newArrival
 @param newDeparture
 @param newCapacity1st
 @param newCapacity2nd
 */
-(id)                   init: (NSString *)newPlatform
                 withArrival: (NSDate *)  newArrival
               withDeparture: (NSDate *)  newDeparture
             withCapacity1st: (int) newCapacity1st
             withCapacity2nd: (int) newCapacity2nd;

/*!
 @function getPrognosis
 Is called when a new PrognosisDto instance should be created based on the dictionary information.
 @param prognosisDictionary
 */
- (PrognosisDto *)getPrognosis:(NSDictionary *)prognosisDictionary;

@end
