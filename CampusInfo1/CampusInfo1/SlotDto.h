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

@interface SlotDto : NSObject {
    
    NSDate         *_startTime;
    NSDate         *_endTime;
    DateFormation  *_dateFormatter;
}

@property (nonatomic, retain) NSDate         *_startTime;
@property (nonatomic, retain) NSDate         *_endTime;
@property (nonatomic, retain) DateFormation  *_dateFormatter;

-(id) init : (NSDate         *) newStartTime
           : (NSDate         *) newEndTime;

- (SlotDto *) getSlot:(NSDictionary *)slotDictionary;

@end
