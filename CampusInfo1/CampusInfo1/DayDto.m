/*
 DayDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header DayDto.m
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

#import "DayDto.h"
#import "ScheduleEventDto.h"
#import "SlotDto.h"


@implementation DayDto
@synthesize _date, _events, _slots;
@synthesize _dateFormatter;

/*!
 @function init
 Needs to be called initally, when instance of DayDto is created.
 @param newDate
 @param newEvents
 @param newSlots
 */
-(id) init : (NSDate         *) newDate
           : (NSMutableArray *) newEvents
           : (NSMutableArray *) newSlots
{
    self = [super init];
    if (self)
    {
        self._date   = newDate;
        self._events = newEvents;
        self._slots  = newSlots;
    }
    _dateFormatter  = [[DateFormation alloc] init];
    return self;
}

/*!
 @function getDay
 Is called when a new DayDto instance should be created based on the dictionary information.
 @param dayDictionary
 */
- (DayDto *) getDay:(NSDictionary *)dayDictionary
{
    NSDate         *_dayDate;
    NSMutableArray *_slotArrayToStore  = [[NSMutableArray alloc]init];
    NSMutableArray *_eventArrayToStore = [[NSMutableArray alloc]init];
    _dateFormatter  = [[DateFormation alloc] init];
    
    //NSLog(@"start parsing day");
    for (id daykey in dayDictionary)
    {
        //NSLog(@"daykey: %@", daykey);
        
        if ([daykey isEqualToString:@"date"])
        {
            _dayDate = [_dateFormatter parseDate:[dayDictionary objectForKey:daykey]];
            //NSLog(@"dayDate: %@", [[_dateFormatter _englishDayFormatter] stringFromDate:_dayDate]);
        }
        
        // get event information
        if ([daykey isEqualToString:@"events"])
        {
            NSArray  *_eventArray = [dayDictionary objectForKey:daykey];
            
            //NSLog(@"events to parse count: %i",[_eventArray count]);
            
            int eventArrayI;
            ScheduleEventDto *_localEvent = [[ScheduleEventDto alloc] init:nil :nil :nil :nil :nil :nil :nil];
            for (eventArrayI = 0; eventArrayI < [_eventArray count]; eventArrayI++)
            {
                _localEvent = [_localEvent getEvent:[_eventArray objectAtIndex:eventArrayI]];
                [_eventArrayToStore addObject:_localEvent];
                //NSLog(@"%i localEvent: %@", eventArrayI,  _localEvent._name);
                
            }
            //NSLog(@"event array count: %i",[_eventArrayToStore count]);
        }
        
        // get slot information
        if ([daykey isEqualToString:@"slots"]) {
            
            NSArray  *_slotArray = [dayDictionary objectForKey:daykey];
            
            // loop over slots
            int slotArrayI;
            SlotDto *_localSlot = [[SlotDto alloc] init:nil :nil];
            for (slotArrayI = 0; slotArrayI < [_slotArray count]; slotArrayI++)
            {
                _localSlot = [_localSlot getSlot:[_slotArray objectAtIndex:slotArrayI]];
                [_slotArrayToStore addObject:_localSlot];
            }
            //NSLog(@"slot array count: %i",[_slotArrayToStore count]);
        }
    }
    //NSLog(@"end parsing day");
    return [[DayDto alloc]init: _dayDate : _eventArrayToStore: _slotArrayToStore ];
}


@end

