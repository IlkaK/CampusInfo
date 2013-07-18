//
//  LunchTimePlanDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 18.07.13.
//
//

#import <Foundation/Foundation.h>

@interface LunchTimePlanDto : NSObject
{
    NSMutableArray   *_weekdays;
    NSString         *_planType;
}

@property (nonatomic, retain) NSMutableArray    *_weekdays;
@property (nonatomic, retain) NSString          *_planType;

-(id)           init: (NSMutableArray  *) newWeekdays
        withPlanType: (NSString *)newPlanType;

- (LunchTimePlanDto *)getLunchTimePlan:(NSDictionary *)lunchTimePlanDictionary;

@end