//
//  ScheduleEventDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 07.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleEventDto.h"
#import "ScheduleEventRealizationDto.h"
#import "SlotDto.h"

@implementation ScheduleEventDto


@synthesize _description, _startTime, _endTime, _name, _slots, _type, _scheduleEventRealizations;
@synthesize _dateFormatter;

-(id) init : (NSString       *) newDescription
           : (NSDate         *) newStartTime
           : (NSDate         *) newEndTime
           : (NSString       *) newName   
           : (NSMutableArray *) newSlots
           : (NSString       *) newType
           : (NSMutableArray *) newScheduleEventRealizations

{
    self = [super init];
    if (self)
    {
        self._description               = newDescription;
        self._startTime                 = newStartTime;
        self._endTime                   = newEndTime;
        self._name                      = newName;
        self._slots                     = newSlots;
        self._type                      = newType;
        self._scheduleEventRealizations = newScheduleEventRealizations;
    }
    _dateFormatter  = [[DateFormation alloc] init]; 
    return self;
}

- (ScheduleEventDto *) getEvent:(NSDictionary *)eventDictionary
{
    ScheduleEventDto  *_localScheduleEvent;
    NSDate            *_eventStartTime;
    NSDate            *_eventEndTime;
    NSString          *_eventDescription;
    NSString          *_eventType;
    NSString          *_eventName;
    NSMutableArray    *_slotArrayToStore      = [[NSMutableArray alloc]init];
    NSMutableArray    *_eventRealizationArray = [[NSMutableArray alloc]init];
    _dateFormatter  = [[DateFormation alloc] init];
    
    NSString *_eventStartTimeString;
    NSString *_eventEndTimeString;
    
    for (id eventKey in eventDictionary)
    {
        //NSLog(@"eventKey: %@",eventKey);
        
        // get start time of event
        if ([eventKey isEqualToString:@"startTime"])
        {
            // 2012-04-04T08:00:00+02:00
            //[str substringWithRange:NSMakeRange(3, [str length]-3)];
            _eventStartTimeString = [eventDictionary objectForKey:eventKey];
            _eventStartTimeString = [_eventStartTimeString substringWithRange:NSMakeRange(11, 5)];
            _eventStartTime       = [[_dateFormatter _timeFormatter]  dateFromString:_eventStartTimeString];
            //NSLog(@"_eventStartTime: %@",_eventStartTimeString);
        }
        
        // get end time of event
        if ([eventKey isEqualToString:@"endTime"])
        {
            _eventEndTimeString = [eventDictionary objectForKey:eventKey];
            _eventEndTimeString = [_eventEndTimeString substringWithRange:NSMakeRange(11, 5)];
            _eventEndTime       = [[_dateFormatter _timeFormatter]  dateFromString:_eventEndTimeString];
            //NSLog(@"_eventEndTime: %@",_eventEndTimeString);
        }
        
        // get description of event
        if ([eventKey isEqualToString:@"description"])
        {
            _eventDescription = [eventDictionary objectForKey:eventKey];
            //NSLog(@"_eventDescription: %@",_eventDescription);
        }
        
        // get name of event
        if ([eventKey isEqualToString:@"name"])
        {
            _eventName = [eventDictionary objectForKey:eventKey];
            //NSLog(@"_eventName: %@",_eventName);
        }
        
        // get type of event
        if ([eventKey isEqualToString:@"type"])
        {
            _eventType = [eventDictionary objectForKey:eventKey];
            //NSLog(@"_eventType: %@",_eventType);
        }
        
        // get eventRealization
        if ([eventKey isEqualToString:@"eventRealizations"])
        {
            NSArray *_eventArray = [eventDictionary objectForKey:eventKey];
            
            if ((NSNull *)_eventArray != [NSNull null])
            {
                //NSLog(@"_eventArray count: %i",[_eventArray count]);
                
                // loop over slots
                int  eventArrayI;
                ScheduleEventRealizationDto *_realization = [[ScheduleEventRealizationDto alloc]init:nil :nil :nil];
                for (eventArrayI = 0; eventArrayI < [_eventArray count]; eventArrayI++)
                {
                    _realization = [_realization getEventRealization:[_eventArray objectAtIndex:eventArrayI]];
                    //NSLog(@"_realization._room._name: %@",_realization._room._name);
                    [_eventRealizationArray addObject:_realization];
                }
            }
            
        }
        // get time slots
        if ([eventKey isEqualToString:@"slots"])
        {
            NSArray  *_slotArray = [eventDictionary objectForKey:eventKey];
            
            //NSLog(@"_slotArray count: %i",[_slotArray count]);
            
            // loop over slots
            int slotArrayI;
            SlotDto *_localSlot = [[SlotDto alloc]init:nil :nil];
            SlotDto *_lastSlot  = [[SlotDto alloc]init:nil :nil];
            
            for (slotArrayI = 0; slotArrayI < [_slotArray count]; slotArrayI++)
            {
                if (slotArrayI > 0)
                {
                    _lastSlot = _localSlot;
                }
                _localSlot = [_localSlot getSlot:[_slotArray objectAtIndex:slotArrayI]];
                
                // always take first slot, but not the ones following, if start and end time are the same
                if (!
                    (    slotArrayI > 0
                     && [_lastSlot._startTime   isEqualToDate:_localSlot._startTime ]
                     && [_lastSlot._endTime     isEqualToDate:_localSlot._endTime   ]
                     )
                    )
                {
                    [_slotArrayToStore addObject:_localSlot];
                }
            }
        }
    }
    
    _localScheduleEvent = [[ScheduleEventDto alloc]init:_eventDescription
                                                       :_eventStartTime
                                                       :_eventEndTime
                                                       :_eventName
                                                       :_slotArrayToStore
                                                       :_eventType
                                                       :_eventRealizationArray];
    //NSLog(@"_localScheduleEvent._name: %@ with %i slots", _localScheduleEvent._name, [_slotArrayToStore count]);
    return _localScheduleEvent;
}


@end