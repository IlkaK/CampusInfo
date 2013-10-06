/*
 ServiceTimePeriodDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ServiceTimePeriodDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the service time period data in MensaOverviewDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives the start and end date, id, lunch time and opening time plan to be initally set or a dictionary to browse the data itself. </li>
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

@class LunchTimePlanDto;
@class OpeningTimePlanDto;

@interface ServiceTimePeriodDto : NSObject
{
    /*! @var _startsOn Holds the start date of the service time period */
    NSDate              *_startsOn;
    /*! @var _endsOn Holds the end date of the service time period */
    NSDate              *_endsOn;
    /*! @var _serviceTimePeriodId Stores the id of the service time period */
    int                 _serviceTimePeriodId;
    /*! @var _lunchTimePlan Holds the lunch time plan of the service time period */
    LunchTimePlanDto    *_lunchTimePlan;
    /*! @var _openingTimePlan Holds the opening time plan of the service time period */
    OpeningTimePlanDto  *_openingTimePlan;
    
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation       *_dateFormatter;
}

@property (nonatomic, retain) NSDate                *_startsOn;
@property (nonatomic, retain) NSDate                *_endsOn;
@property (nonatomic, assign) int                   _serviceTimePeriodId;
@property (nonatomic, retain) LunchTimePlanDto      *_lunchTimePlan;
@property (nonatomic, retain) OpeningTimePlanDto    *_openingTimePlan;
@property (nonatomic, retain) DateFormation         *_dateFormatter;

/*!
 @function init
 Initializes ServiceTimePeriodDto.
 @param newStartsOn
 @param newEndsOn
 @param newServiceTimePeriodId
 @param newLunchTimePlan
 @param newOpeningTimePlan
 */
-(id)                  init: (NSDate *) newStartsOn
                 withEndsOn: (NSDate *) newEndsOn
    withServiceTimePeriodId: (int) newServiceTimePeriodId
          withLunchTimePlan: (LunchTimePlanDto *)newLunchTimePlan
        withOpeningTimePlan: (OpeningTimePlanDto *)newOpeningTimePlan;

/*!
 @function getServiceTimePeriod
 Is called when a new ServiceTimePeriodDto instance should be created based on the dictionary information.
 @param serviceTimePeriodDictionary
 */
- (ServiceTimePeriodDto *)getServiceTimePeriod:(NSDictionary *)serviceTimePeriodDictionary;

@end