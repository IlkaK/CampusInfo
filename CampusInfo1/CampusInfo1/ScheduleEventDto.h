/*
 ScheduleEventDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ScheduleEventDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds data for ScheduleEvent in TimeTableDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives description, startTime, endTime, name, slots, type and scheduleEventRealization to be initally set or a dictionary to browse the data itself. </li>
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

@interface ScheduleEventDto : NSObject
{
    /*! @var _description Stores the description of the ScheduleEvent */
    NSString       *_description;
    /*! @var _startTime Stores the start time of the ScheduleEvent */
    NSDate         *_startTime;
    /*! @var _endTime Stores the end time of the ScheduleEvent */
    NSDate         *_endTime;
    /*! @var _name Stores the name of the ScheduleEvent */
    NSString       *_name;
    /*! @var _slots Stores the Array of slots of the ScheduleEvent */
    NSMutableArray *_slots;
    /*! @var _type Stores the type of the ScheduleEvent */
    NSString       *_type;
    /*! @var _scheduleEventRealizations Stores the Array of scheduleEventRealitzations of the ScheduleEvent */
    NSMutableArray *_scheduleEventRealizations;
    
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation  *_dateFormatter;
}

@property (nonatomic, retain) NSString       *_description; 
@property (nonatomic, retain) NSDate         *_startTime;
@property (nonatomic, retain) NSDate         *_endTime;
@property (nonatomic, retain) NSString       *_name; 
@property (nonatomic, retain) NSMutableArray *_slots;
@property (nonatomic, retain) NSString       *_type; 
@property (nonatomic, retain) NSMutableArray *_scheduleEventRealizations;
@property (nonatomic, retain) DateFormation  *_dateFormatter;


/*!
 @function init
 Needs to be called initally, when instance of ScheduleEventDto is created.
 @param newDescription
 @param newStartTime
 @param newEndTime
 @param newName
 @param newSlots
 @param newType
 @param newScheduleEventRealizations
 */
-(id) init : (NSString       *) newDescription
           : (NSDate         *) newStartTime
           : (NSDate         *) newEndTime
           : (NSString       *) newName
           : (NSMutableArray *) newSlots
           : (NSString       *) newType
           : (NSMutableArray *) newScheduleEventRealizations;

/*!
 @function getEvent
 Is called when a new ScheduleEventDto instance should be created based on the dictionary information.
 @param eventDictionary
 */
- (ScheduleEventDto *) getEvent:(NSDictionary *)eventDictionary;

@end
