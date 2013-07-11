//
//  DayDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DayDto.h"
#import "ScheduleEventDto.h"
#import "SlotDto.h"


@implementation DayDto
@synthesize _date, _events, _slots;
@synthesize _dateFormatter;

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

- (NSDate *) parseDate:(NSString *)dateString
{
    NSDate   *_localDate;
    NSString *_localString;
    
    _localString = [dateString substringToIndex:10];
    //NSLog(@"_localString: %@",_localString);
    _localDate   = [[_dateFormatter _englishDayFormatter] dateFromString:_localString];
    //NSLog(@"_localDate: %@", [[_dateFormatter _englishDayFormatter] stringFromDate:_localDate]);
    return _localDate;
}

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
            _dayDate = [self parseDate:[dayDictionary objectForKey:daykey]];
            //NSLog(@"dayDate: %@", [[_dateFormatter _englishDayFormatter] stringFromDate:_dayDate]);
        }
        
        // get event information
        if ([daykey isEqualToString:@"events"])
        {
            NSArray  *_eventArray = [dayDictionary objectForKey:daykey];
            
            //NSLog(@"events to parse count: %i",[_eventArray count]);
            
            // loop over slots
            int eventArrayI;
            ScheduleEventDto *_localEvent = [[ScheduleEventDto alloc] init:nil :nil :nil :nil :nil :nil :nil];
            for (eventArrayI = 0; eventArrayI < [_eventArray count]; eventArrayI++)
            {
                _localEvent = [_localEvent getEvent:[_eventArray objectAtIndex:eventArrayI]];
                //NSLog(@"%i localEvent: %@", eventArrayI,  _localEvent._name);
                [_eventArrayToStore addObject:_localEvent];
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

