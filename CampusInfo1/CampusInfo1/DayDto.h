//
//  DayDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateFormation.h"

@interface DayDto : NSObject 
{
    NSDate         *_date;
    NSMutableArray *_events;
    NSMutableArray *_slots;
    DateFormation  *_dateFormatter;
}

@property (nonatomic, retain) NSDate         *_date;
@property (nonatomic, retain) NSMutableArray *_events;
@property (nonatomic, retain) NSMutableArray *_slots;
@property (nonatomic, retain) DateFormation  *_dateFormatter;


-(id) init : (NSDate         *) newDate
           : (NSMutableArray *) newEvents
           : (NSMutableArray *) newSlots;
           
- (DayDto *) getDay:(NSDictionary *)dayDictionary;

@end
