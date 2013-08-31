//
//  PrognosisDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 31.08.13.
//
//

#import <Foundation/Foundation.h>

@interface PrognosisDto : NSObject
{
    NSString        *_platform;
    NSString        *_arrival;
    NSString        *_departure;
    int               _capacity1st;
    int               _capacity2nd;
}

@property (nonatomic, retain) NSString          *_platform;
@property (nonatomic, retain) NSString          *_arrival;
@property (nonatomic, retain) NSString          *_departure;
@property (nonatomic, assign) int               _capacity1st;
@property (nonatomic, assign) int               _capacity2nd;

-(id)                   init: (NSString *)newPlatform
                 withArrival: (NSString *)newArrival
               withDeparture: (NSString *)newDeparture
             withCapacity1st: (int) newCapacity1st
             withCapacity2nd: (int) newCapacity2nd;


- (PrognosisDto *)getPrognosis:(NSDictionary *)prognosisDictionary;

@end
