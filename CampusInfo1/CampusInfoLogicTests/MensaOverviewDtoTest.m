//
//  MensaOverviewDtoTest.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 21.09.13.
//
//

#import "MensaOverviewDtoTest.h"
#import "DateFormation.h"
#import "TimeTableDtoTestConstants.h"
#import "UIConstantStrings.h"
#import "GastronomicFacilityArrayDto.h"
#import "HolidayDto.h"
#import "LocationDto.h"
#import "OpeningTimePlanDto.h"
#import "LunchTimePlanDto.h"
#import "ServiceTimePeriodDto.h"
#import "GastronomicFacilityDto.h"
#import "WeekdayDto.h"
#import "MensaDtoTestConstants.h"


@implementation MensaOverviewDtoTest


- (WeekdayDto *)weekdayDto1:(DateFormation *)dateFormater
{
    WeekdayDto *_oneWeekday = [[WeekdayDto alloc]init:MondayEnglish
                                         withFromTime:[[dateFormater _timeFormatter] dateFromString:startTime1]
                                            withToTime:[[dateFormater _timeFormatter] dateFromString:endTime2 ]
                                    withTimeplanType:nil];
    
    NSString *_startTime = [[dateFormater _timeFormatter] stringFromDate:_oneWeekday._fromTime ];
    NSString *_endTime = [[dateFormater _timeFormatter] stringFromDate:_oneWeekday._toTime ];
    
    STAssertTrue([_startTime isEqualToString: startTime1], @"weekday1 startTime %@ = %@",_startTime, startTime1);
    STAssertTrue([_endTime isEqualToString: endTime2], @"weekday1 endTime %@ = %@",_endTime, endTime2);
    
    STAssertEquals(_oneWeekday._weekdayType, MondayEnglish, @"weekday1 weekdayType %@ = %@",_oneWeekday._weekdayType, MondayEnglish);
    return _oneWeekday;
}

- (WeekdayDto *)weekdayDto2:(DateFormation *)dateFormater
{
    WeekdayDto *_oneWeekday = [[WeekdayDto alloc]init:TuesdayEnglish
                                         withFromTime:[[dateFormater _timeFormatter] dateFromString:startTime3]
                                           withToTime:[[dateFormater _timeFormatter] dateFromString:endTime4 ]
                                     withTimeplanType:nil];

    NSString *_startTime = [[dateFormater _timeFormatter] stringFromDate:_oneWeekday._fromTime ];
    NSString *_endTime = [[dateFormater _timeFormatter] stringFromDate:_oneWeekday._toTime ];
    
    STAssertTrue([_startTime isEqualToString: startTime3], @"weekday2 startTime %@ = %@",_startTime, startTime3);
    STAssertTrue([_endTime isEqualToString: endTime4], @"weekday2 endTime %@ = %@",_endTime, endTime4);
    
    STAssertTrue([_oneWeekday._weekdayType isEqualToString: TuesdayEnglish], [NSString stringWithFormat: @"weekday2 weekdayType %@ = %@",_oneWeekday._weekdayType, TuesdayEnglish]);
    return _oneWeekday;
}


- (LocationDto *)locationDto1
{
    LocationDto *_oneLocation = [[LocationDto alloc]init:id1
                                                withName:locationName1
                                             withVersion:version10];

    STAssertEquals(_oneLocation._locationId, id1, @"location1 id %i = %i",_oneLocation._locationId, id1);
    STAssertEquals(_oneLocation._name, locationName1, @"location1 name %@ = %@",_oneLocation._name, locationName1);
    STAssertEquals(_oneLocation._version, version10, @"location1 version %@ = %@",_oneLocation._version, version10);
    return _oneLocation;
}

-(HolidayDto *)holidayDto1:(DateFormation *)dateFormater
{
    HolidayDto *_oneHoliday = [[HolidayDto alloc]init:id1
                                        withName:holidayName1
                                    withVersion:version10
                                    withStartsAt:[[dateFormater _englishDayFormatter] dateFromString:day1 ]
                                        withEndsAt:[[dateFormater _englishDayFormatter] dateFromString:day1 ]
                                ];
    STAssertEquals(_oneHoliday._holidayId, id1, @"holiday1 id %i = %i",_oneHoliday._holidayId, id1);
    STAssertEquals(_oneHoliday._name, holidayName1, @"holiday1 name %@ = %@",_oneHoliday._name, holidayName1);
    STAssertEquals(_oneHoliday._version, version10, @"holiday1 version %@ = %@",_oneHoliday._version, version10);
    
    NSString *_startDay = [[dateFormater _englishDayFormatter] stringFromDate:_oneHoliday._startsAt ];
    NSString *_endDay = [[dateFormater _englishDayFormatter] stringFromDate:_oneHoliday._endsAt ];
    
    STAssertTrue([_startDay isEqualToString: day1], @"holiday1 startDay %@ = %@",_startDay, day1);
    STAssertTrue([_endDay isEqualToString: day1], @"holiday1 endDay %@ = %@",_endDay, day1);
    return _oneHoliday;
}

-(HolidayDto *)holidayDto2:(DateFormation *)dateFormater
{
    HolidayDto *_oneHoliday = [[HolidayDto alloc]init:id2
                                             withName:holidayName2
                                          withVersion:version11
                                         withStartsAt:[[dateFormater _englishDayFormatter] dateFromString:day2 ]
                                           withEndsAt:[[dateFormater _englishDayFormatter] dateFromString:day2 ]
                               ];
    STAssertEquals(_oneHoliday._holidayId, id2, @"holiday2 id %i = %i",_oneHoliday._holidayId, id2);
    STAssertEquals(_oneHoliday._name, holidayName2, @"holiday2 name %@ = %@",_oneHoliday._name, holidayName2);
    STAssertEquals(_oneHoliday._version, version11, @"holiday2 version %@ = %@",_oneHoliday._version, version11);
    
    NSString *_startDay = [[dateFormater _englishDayFormatter] stringFromDate:_oneHoliday._startsAt ];
    NSString *_endDay = [[dateFormater _englishDayFormatter] stringFromDate:_oneHoliday._endsAt ];
    
    STAssertTrue([_startDay isEqualToString: day2], @"holiday2 startDay %@ = %@",_startDay, day2);
    STAssertTrue([_endDay isEqualToString: day2], @"holiday2 endDay %@ = %@",_endDay, day2);
    return _oneHoliday;
}


- (LunchTimePlanDto *)lunchTimePlanDto1:(WeekdayDto *)weekd1
                            withWeekday2:(WeekdayDto *)weekd2
{
    NSMutableArray *_weekdayArray = [[NSMutableArray alloc]init];
    [_weekdayArray addObject:weekd1];
    [_weekdayArray addObject:weekd2];
    LunchTimePlanDto *_oneLunchTimePlan = [[LunchTimePlanDto alloc]init:_weekdayArray withPlanType:planType1];

    int cnt = [_oneLunchTimePlan._weekdays count];
    STAssertEquals(cnt, 2, @"lunchTimePlan1 weekday count @i = @i", cnt, 2);
    STAssertTrue([_oneLunchTimePlan._planType isEqualToString: planType1], @"lunchTimePlan1 plan type %@ = %@",_oneLunchTimePlan._planType, planType1);
    
    return _oneLunchTimePlan;
}


- (LunchTimePlanDto *)lunchTimePlanDto2:(WeekdayDto *)weekd1
{
    NSMutableArray *_weekdayArray = [[NSMutableArray alloc]init];
    [_weekdayArray addObject:weekd1];
    LunchTimePlanDto *_oneLunchTimePlan = [[LunchTimePlanDto alloc]init:_weekdayArray withPlanType:planType2];
    
    int cnt = [_oneLunchTimePlan._weekdays count];
    STAssertEquals(cnt, 1, @"lunchTimePlan2 weekday count @i = @i", cnt, 1);
    STAssertTrue([_oneLunchTimePlan._planType isEqualToString: planType2], @"lunchTimePlan2 plan type %@ = %@",_oneLunchTimePlan._planType, planType2);
    
    return _oneLunchTimePlan;
}


- (OpeningTimePlanDto *)openingTimePlanDto1:(WeekdayDto *)weekd1
                            withWeekday2:(WeekdayDto *)weekd2
{
    NSMutableArray *_weekdayArray = [[NSMutableArray alloc]init];
    [_weekdayArray addObject:weekd1];
    [_weekdayArray addObject:weekd2];
    OpeningTimePlanDto *_oneOpeningTimePlan = [[OpeningTimePlanDto alloc]init:_weekdayArray withPlanType:planType1];
    
    int cnt = [_oneOpeningTimePlan._weekdays count];
    STAssertEquals(cnt, 2, @"openingTimePlan1 weekday count @i = @i", cnt, 2);
    STAssertTrue([_oneOpeningTimePlan._planType isEqualToString: planType1], @"openingTimePlan1 plan type %@ = %@",_oneOpeningTimePlan._planType, planType1);
    
    return _oneOpeningTimePlan;
}

- (OpeningTimePlanDto *)openingTimePlanDto2:(WeekdayDto *)weekd1
{
    NSMutableArray *_weekdayArray = [[NSMutableArray alloc]init];
    [_weekdayArray addObject:weekd1];
    OpeningTimePlanDto *_oneOpeningTimePlan = [[OpeningTimePlanDto alloc]init:_weekdayArray withPlanType:planType2];
    
    int cnt = [_oneOpeningTimePlan._weekdays count];
    STAssertEquals(cnt, 1, @"openingTimePlan2 weekday count @i = @i", cnt, 1);
    STAssertTrue([_oneOpeningTimePlan._planType isEqualToString: planType2], @"openingTimePlan2 plan type %@ = %@",_oneOpeningTimePlan._planType, planType2);
    
    return _oneOpeningTimePlan;
}


- (ServiceTimePeriodDto *)serviceTimePeriodDto1:(LunchTimePlanDto *)lunchTimePlan
                            withOpeningTimePlan:(OpeningTimePlanDto *)openingTimePlan
                              withDateFormatter:(DateFormation *)dateFormater
{
    ServiceTimePeriodDto *_oneService = [[ServiceTimePeriodDto alloc]init:[[dateFormater _englishDayFormatter] dateFromString:day3 ]
                                                               withEndsOn:[[dateFormater _englishDayFormatter] dateFromString:day4 ]
                                                  withServiceTimePeriodId:id1
                                                        withLunchTimePlan:lunchTimePlan
                                                      withOpeningTimePlan:openingTimePlan];
    
    NSString *_startDay = [[dateFormater _englishDayFormatter] stringFromDate:_oneService._startsOn ];
    NSString *_endDay = [[dateFormater _englishDayFormatter] stringFromDate:_oneService._endsOn ];
    
    STAssertTrue([_startDay isEqualToString: day3], @"serviceTimePeriod1 startDay %@ = %@",_startDay, day3);
    STAssertTrue([_endDay isEqualToString: day4], @"serviceTimePeriod1 endDay %@ = %@",_endDay, day4);
    
    STAssertEquals(_oneService._serviceTimePeriodId, id1, @"serviceTimePeriod1 id @i = @i", _oneService._serviceTimePeriodId, id1);
    STAssertTrue([_oneService._lunchTimePlan._planType isEqualToString: planType1], @"serviceTimePeriod1 lunchTimePlan plan type %@ = %@",_oneService._lunchTimePlan._planType, planType1);
    STAssertTrue([_oneService._openingTimePlan._planType isEqualToString: planType1], @"serviceTimePeriod1 openingTimePlan plan type %@ = %@",_oneService._openingTimePlan._planType, planType1);
    return _oneService;
}

- (ServiceTimePeriodDto *)serviceTimePeriodDto2:(LunchTimePlanDto *)lunchTimePlan
                            withOpeningTimePlan:(OpeningTimePlanDto *)openingTimePlan
                              withDateFormatter:(DateFormation *)dateFormater
{
    ServiceTimePeriodDto *_oneService = [[ServiceTimePeriodDto alloc]init:[[dateFormater _englishDayFormatter] dateFromString:day4 ]
                                                               withEndsOn:[[dateFormater _englishDayFormatter] dateFromString:day5 ]
                                                  withServiceTimePeriodId:id2
                                                        withLunchTimePlan:lunchTimePlan
                                                      withOpeningTimePlan:openingTimePlan];
    
    NSString *_startDay = [[dateFormater _englishDayFormatter] stringFromDate:_oneService._startsOn ];
    NSString *_endDay = [[dateFormater _englishDayFormatter] stringFromDate:_oneService._endsOn ];
    
    STAssertTrue([_startDay isEqualToString: day4], @"serviceTimePeriod2 startDay %@ = %@",_startDay, day4);
    STAssertTrue([_endDay isEqualToString: day5], @"serviceTimePeriod2 endDay %@ = %@",_endDay, day5);
    
    STAssertEquals(_oneService._serviceTimePeriodId, id2, @"serviceTimePeriod1 id @i = @i", _oneService._serviceTimePeriodId, id2);
    STAssertTrue([_oneService._lunchTimePlan._planType isEqualToString: planType2], @"serviceTimePeriod2 lunchTimePlan plan type %@ = %@",_oneService._lunchTimePlan._planType, planType2);
    STAssertTrue([_oneService._openingTimePlan._planType isEqualToString: planType2], @"serviceTimePeriod2 openingTimePlan plan type %@ = %@",_oneService._openingTimePlan._planType, planType2);
    
    return _oneService;
}



- (GastronomicFacilityDto *)gastronomicFacilityDto1:(HolidayDto *)holiday1
                                       withHoliday2:(HolidayDto *)holiday2
                                       withLocation:(LocationDto *)location
                             withServiceTimePeriod1:(ServiceTimePeriodDto *)serviceTimePeriod1
                             withServiceTimePeriod2:(ServiceTimePeriodDto *)serviceTimePeriod2
{
    NSMutableArray *_holidayArray = [[NSMutableArray alloc]init];
    [_holidayArray addObject:holiday1];
    [_holidayArray addObject:holiday2];
    
    NSMutableArray *_serviceTimeArray = [[NSMutableArray alloc]init];
    [_serviceTimeArray addObject:serviceTimePeriod1];
    [_serviceTimeArray addObject:serviceTimePeriod2];
    
    
    GastronomicFacilityDto *_oneGastronomy = [[GastronomicFacilityDto alloc]init:_holidayArray
                                                    withGastroId:id4
                                                    withLocation:location
                                                        withName:gastronomicFacilityName1
                                          withServiceTimePeriods:_serviceTimeArray
                                                        withType:gastronomicFacilityType1
                                                     withVersion:version10];

    STAssertEquals(_oneGastronomy._gastroId, id4, @"gastronomicFacility1 id @i = @i", _oneGastronomy._gastroId, id4);
    STAssertEquals(_oneGastronomy._location._name, locationName1, @"gastronomicFacility1 location name %@ = %@",_oneGastronomy._location._name, locationName1);
    STAssertEquals(_oneGastronomy._name, gastronomicFacilityName1, @"gastronomicFacility1 name %@ = %@",_oneGastronomy._name, gastronomicFacilityName1);
    STAssertEquals(_oneGastronomy._type, gastronomicFacilityType1, @"gastronomicFacility1 type %@ = %@",_oneGastronomy._type, gastronomicFacilityType1);
    STAssertEquals(_oneGastronomy._version, version10, @"gastronomicFacility1 type %@ = %@",_oneGastronomy._version, version10);
    
    int cnt = [_oneGastronomy._serviceTimePeriods count];
    STAssertEquals(cnt, 2, @"gastronomicFacility1 serviceTimePeriod count @i = @i", cnt, 2);
    cnt = [_oneGastronomy._holidays count];
    STAssertEquals(cnt, 2, @"gastronomicFacility1 holiday count @i = @i", cnt, 2);
    

    return _oneGastronomy;
}


- (void) testMensaOverview
{
    DateFormation *_dateFormater = [[DateFormation alloc]init];
    
    WeekdayDto *_weekday1 = [self weekdayDto1:_dateFormater];
    WeekdayDto *_weekday2 = [self weekdayDto2:_dateFormater];
    WeekdayDto *_weekday3 = [[WeekdayDto alloc]init:WednesdayEnglish
                                         withFromTime:[[_dateFormater _timeFormatter] dateFromString:startTime3]
                                           withToTime:[[_dateFormater _timeFormatter] dateFromString:endTime4 ]
                                     withTimeplanType:nil];
    
    
    LocationDto *_location1 = [self locationDto1];
    
    HolidayDto *_holiday1 = [self holidayDto1:_dateFormater];
    HolidayDto *_holiday2 = [self holidayDto2:_dateFormater];
    
    LunchTimePlanDto *_lunchTimePlan1 = [self lunchTimePlanDto1:_weekday1
                                                   withWeekday2:_weekday2];
    
    LunchTimePlanDto *_lunchTimePlan2 = [self lunchTimePlanDto2:_weekday3];
    
    OpeningTimePlanDto *_openingTimePlan1 = [self openingTimePlanDto1:_weekday1
                                                         withWeekday2:_weekday2];
    OpeningTimePlanDto *_openingTimePlan2 = [self openingTimePlanDto2:_weekday3];
    
    
    ServiceTimePeriodDto *_serviceTimePeriod1 = [self serviceTimePeriodDto1:_lunchTimePlan1
                                                        withOpeningTimePlan:_openingTimePlan1
                                                          withDateFormatter:_dateFormater];
    ServiceTimePeriodDto *_serviceTimePeriod2 = [self serviceTimePeriodDto2:_lunchTimePlan2
                                                        withOpeningTimePlan:_openingTimePlan2
                                                          withDateFormatter:_dateFormater];
    
    GastronomicFacilityDto *_gastro1 = [self gastronomicFacilityDto1:_holiday1
                                                        withHoliday2:_holiday2
                                                        withLocation:_location1
                                              withServiceTimePeriod1:_serviceTimePeriod1
                                              withServiceTimePeriod2:_serviceTimePeriod2];
    
    NSMutableArray *_gastronomicArray = [[NSMutableArray alloc]init];
    [_gastronomicArray addObject:_gastro1];
    
    GastronomicFacilityArrayDto *_gastronomicFacilityArray1 = [[GastronomicFacilityArrayDto alloc]init:_gastronomicArray];
    
    int cnt = [_gastronomicFacilityArray1._gastronomicFacilities count];
    STAssertEquals(cnt, 1, @"gastronomic facility count %i = %i",cnt, 1);
}

@end
