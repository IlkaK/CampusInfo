/*
 DayDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header DayDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds data for Day in TimeTableDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives date, array of events and array of slots to be initally set or a dictionary to browse the data itself. </li>
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

@interface DayDto : NSObject 
{
    /*! @var _date Stores the date of the day */
    NSDate         *_date;
    /*! @var _events Stores the schedule events of the day */
    NSMutableArray *_events;
    /*! @var _slots Stores the slots of the day */
    NSMutableArray *_slots;
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation  *_dateFormatter;
}

@property (nonatomic, retain) NSDate         *_date;
@property (nonatomic, retain) NSMutableArray *_events;
@property (nonatomic, retain) NSMutableArray *_slots;
@property (nonatomic, retain) DateFormation  *_dateFormatter;

/*!
 @function init
 Needs to be called initally, when instance of DayDto is created.
 @param newDate
 @param newEvents
 @param newSlots
 */
-(id) init : (NSDate         *) newDate
           : (NSMutableArray *) newEvents
           : (NSMutableArray *) newSlots;

/*!
 @function getDay
 Is called when a new DayDto instance should be created based on the dictionary information.
 @param dayDictionary
 */
- (DayDto *) getDay:(NSDictionary *)dayDictionary;

@end
