/*
 SlotDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header SlotDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds data for Slot in TimeTableDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives start time and end time to be initally set or a dictionary to browse the data itself. </li>
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

@interface SlotDto : NSObject
{

    /*! @var _startTime Stores the start time of the slot */
    NSDate         *_startTime;
    /*! @var _endTime Stores the end time of the slot */
    NSDate         *_endTime;
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation  *_dateFormatter;
}

@property (nonatomic, retain) NSDate         *_startTime;
@property (nonatomic, retain) NSDate         *_endTime;
@property (nonatomic, retain) DateFormation  *_dateFormatter;

/*!
 @function init
 Needs to be called initally, when instance of SlotDto is created.
 @param newStartTime
 @param newEndTime
 */
-(id) init : (NSDate         *) newStartTime
           : (NSDate         *) newEndTime;

/*!
 @function getSlot
 Is called when a new SlotDto instance should be created based on the dictionary information.
 @param slotDictionary
 */
- (SlotDto *) getSlot:(NSDictionary *)slotDictionary;

@end
