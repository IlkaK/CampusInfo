/*
 WeekdayDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header WeekdayDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the weekday data in MensaOverviewDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives a type, start and stop time and timeplan type to be initally set or a dictionary to browse the data itself. </li>
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

@interface WeekdayDto : NSObject
{
    /*! @var _weekdayType Holds the week day type of the week day */
    NSString        *_weekdayType;
    /*! @var _fromTime Holds the start time of the week day */
    NSDate          *_fromTime;
    /*! @var _toTime Holds the stop time of the week day */
    NSDate          *_toTime;
    /*! @var _timeplanType Holds the timeplan type of the week day */
    NSString        *_timeplanType;
    
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation   *_dateFormatter;
}

@property (nonatomic, retain) NSString          *_weekdayType;
@property (nonatomic, retain) NSDate            *_fromTime;
@property (nonatomic, retain) NSDate            *_toTime;
@property (nonatomic, retain) NSString          *_timeplanType;
@property (nonatomic, retain) DateFormation     *_dateFormatter;

/*!
 @function init
 Initializes WeekdayDto.
 @param newWeekdayType
 @param newFromTime
 @param newToTime
 @param newTimeplanType 
 */
-(id)   init : (NSString  *) newWeekdayType
 withFromTime: (NSDate *)newFromTime
   withToTime: (NSDate *)newToTime
withTimeplanType: (NSString *)newTimeplanType;

/*!
 @function getWeekday
 Is called when a new WeekdayDto instance should be created based on the dictionary information.
 @param weekdayDictionary
 @param weekdayType
 */
- (WeekdayDto *)getWeekday:(NSDictionary *)weekdayDictionary
           withWeekdayType:(NSString *)weekdayType;

@end