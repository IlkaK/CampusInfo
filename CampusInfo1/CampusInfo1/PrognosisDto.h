//
//  PrognosisDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 31.08.13.
//
//

#import <Foundation/Foundation.h>
#import "DateFormation.h"

@interface PrognosisDto : NSObject
{
    NSString        *_platform;
    NSDate          *_arrival;
    NSDate          *_departure;
    int               _capacity1st;
    int               _capacity2nd;

    DateFormation   *_dateFormatter;
}

@property (nonatomic, retain) NSString          *_platform;
@property (nonatomic, retain) NSDate            *_arrival;
@property (nonatomic, retain) NSDate            *_departure;
@property (nonatomic, assign) int               _capacity1st;
@property (nonatomic, assign) int               _capacity2nd;

@property (nonatomic, retain) DateFormation     *_dateFormatter;

-(id)                   init: (NSString *)newPlatform
                 withArrival: (NSDate *)  newArrival
               withDeparture: (NSDate *)  newDeparture
             withCapacity1st: (int) newCapacity1st
             withCapacity2nd: (int) newCapacity2nd;


- (PrognosisDto *)getPrognosis:(NSDictionary *)prognosisDictionary;

@end
