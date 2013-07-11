//
//  SlotDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SlotDto.h"


@implementation SlotDto

@synthesize _startTime, _endTime;
@synthesize _dateFormatter;

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
        
    } // end loop over slotDictionary
    
    _localSlot = [[SlotDto alloc]init: _slotStartTime :_slotEndTime];
    return _localSlot;
}


@end

