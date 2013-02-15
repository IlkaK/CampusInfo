//
//  SlotDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SlotDto : NSObject {
    
    NSDate         *_startTime;
    NSDate         *_endTime;

}

@property (nonatomic, retain) NSDate         *_startTime;
@property (nonatomic, retain) NSDate         *_endTime;

-(id) init : (NSDate         *) newStartTime
           : (NSDate         *) newEndTime;

@end
