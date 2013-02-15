//
//  DayDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DayDto : NSObject 
{
    NSDate         *_date;
    NSMutableArray *_events;
    NSMutableArray *_slots;
}

@property (nonatomic, retain) NSDate         *_date;
@property (nonatomic, retain) NSMutableArray *_events;
@property (nonatomic, retain) NSMutableArray *_slots;


-(id) init : (NSDate         *) newDate
           : (NSMutableArray *) newEvents
           : (NSMutableArray *) newSlots;
           

@end
