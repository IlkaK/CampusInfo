/*
 SlotDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header SlotDto.m
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

#import "SlotDto.h"


@implementation SlotDto

@synthesize _startTime, _endTime;
@synthesize _dateFormatter;

/*!
 @function init
 Needs to be called initally, when instance of SlotDto is created.
 @param newStartTime
 @param newEndTime
 */
-(id) init : (NSDate         *) newStartTime
           : (NSDate         *) newEndTime

{
    self = [super init];
    if (self)
    {
        self._startTime   = newStartTime;
        self._endTime     = newEndTime;
    }
    _dateFormatter  = [[DateFormation alloc] init]; 
    return self;
}

/*!
 @function getSlot
 Is called when a new SlotDto instance should be created based on the dictionary information.
 @param slotDictionary
 */
- (SlotDto *) getSlot:(NSDictionary *)slotDictionary
{
    SlotDto        *_localSlot;
    NSDate         *_slotStartTime;
    NSDate         *_slotEndTime;
    NSString       *_slotStartTimeString;
    NSString       *_slotEndTimeString;
    
    for (id slotKey in slotDictionary)
    {
        if ([slotKey isEqualToString:@"startTime"])
        {
            // 2012-04-04T08:00:00+02:00
            //[str substringWithRange:NSMakeRange(3, [str length]-3)];
            
            _slotStartTimeString = [slotDictionary objectForKey:slotKey];
            _slotStartTimeString = [_slotStartTimeString substringWithRange:NSMakeRange(11, 5)];
            _slotStartTime       = [[_dateFormatter _timeFormatter]  dateFromString:_slotStartTimeString];
            //NSLog(@"_slotStartTimeString: %@",_slotStartTime);
        }
        if ([slotKey isEqualToString:@"endTime"])
        {
            _slotEndTimeString = [slotDictionary objectForKey:slotKey];
            _slotEndTimeString = [_slotEndTimeString substringWithRange:NSMakeRange(11, 5)];
            _slotEndTime       = [[_dateFormatter _timeFormatter]  dateFromString:_slotEndTimeString];
            //NSLog(@"_slotEndTimeString: %@",_slotEndTimeString);
        }
    } 
    
    _localSlot = [[SlotDto alloc]init: _slotStartTime :_slotEndTime];
    return _localSlot;
}


@end

