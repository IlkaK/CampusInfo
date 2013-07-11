//
//  SlotDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DateFormation.h>

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
