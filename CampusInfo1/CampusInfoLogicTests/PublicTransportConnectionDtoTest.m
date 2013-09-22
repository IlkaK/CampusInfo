//
//  PublicTransportConnectionDtoTest.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 22.09.13.
//
//

#import "PublicTransportConnectionDtoTest.h"

#import "PrognosisDto.h"
#import "FromOrToDto.h"
#import "ServiceDto.h"
#import "JourneyDto.h"
#import "SectionDto.h"
#import "ConnectionDto.h"
#import "ConnectionArrayDto.h"

#import "PublicTransportDtoTestConstants.h"
#import "MensaDtoTestConstants.h"
#import "TimeTableDtoTestConstants.h"
#import "DateFormation.h"


@implementation PublicTransportConnectionDtoTest


- (CoordinateDto *)coordinateDto1
{
    CoordinateDto *_oneCoordinate = [[CoordinateDto alloc]init:coordinateType1 withX:coordinateX1 withY:coordinateY1];
    STAssertEquals(_oneCoordinate._type, coordinateType1,  @"coordinate1 type %@ = %@", _oneCoordinate._type, coordinateType1);
    STAssertEquals(_oneCoordinate._x, coordinateX1,  @"coordinate1 x %@ = %@", _oneCoordinate._x, coordinateX1);
    STAssertEquals(_oneCoordinate._y, coordinateY1,  @"coordinate1 y %@ = %@", _oneCoordinate._y, coordinateY1);
    return _oneCoordinate;
}

- (CoordinateDto *)coordinateDto2
{
    CoordinateDto *_oneCoordinate = [[CoordinateDto alloc]init:coordinateType2 withX:coordinateX2 withY:coordinateY2];
    STAssertEquals(_oneCoordinate._type, coordinateType2,  @"coordinate2 type %@ = %@", _oneCoordinate._type, coordinateType2);
    STAssertEquals(_oneCoordinate._x, coordinateX2,  @"coordinate2 x %@ = %@", _oneCoordinate._x, coordinateX2);
    STAssertEquals(_oneCoordinate._y, coordinateY2,  @"coordinate2 y %@ = %@", _oneCoordinate._y, coordinateY2);
    return _oneCoordinate;
}

- (StationDto *)stationDto1:(CoordinateDto *)coordinate1
{
    StationDto *_oneStation = [[StationDto alloc]init:stationId1 withScore:stationScore1 withName:stationName1 withDistance:stationDistance1 withCoordinate:coordinate1];

    STAssertEquals(_oneStation._stationId, stationId1, @"station1 id %@ = %@", _oneStation._stationId, stationId1);
    STAssertEquals(_oneStation._score, stationScore1, @"station1 score %@ = %@", _oneStation._score, stationScore1);
    STAssertEquals(_oneStation._name, stationName1, @"station1 name %@ = %@", _oneStation._name, stationName1);
    STAssertEquals(_oneStation._distance, stationDistance1, @"station1 distance %@ = %@", _oneStation._distance, stationDistance1);
    STAssertEquals(_oneStation._coordinate._x, coordinateX1, @"station1 coordinate x %@ = %@", _oneStation._coordinate._x, coordinateX1);
    
    return _oneStation;
}


- (StationDto *)stationDto2:(CoordinateDto *)coordinate1
{
    StationDto *_oneStation = [[StationDto alloc]init:stationId2 withScore:stationScore2 withName:stationName2 withDistance:stationDistance2 withCoordinate:coordinate1];
    
    STAssertEquals(_oneStation._stationId, stationId2, @"station2 id %@ = %@", _oneStation._stationId, stationId2);
    STAssertEquals(_oneStation._score, stationScore2, @"station2 score %@ = %@", _oneStation._score, stationScore2);
    STAssertEquals(_oneStation._name, stationName2, @"station2 name %@ = %@", _oneStation._name, stationName2);
    STAssertEquals(_oneStation._distance, stationDistance2, @"station2 distance %@ = %@", _oneStation._distance, stationDistance2);
    STAssertEquals(_oneStation._coordinate._x, coordinateX2, @"station2 coordinate x %@ = %@", _oneStation._coordinate._x, coordinateX2);
    
    return _oneStation;
}

- (PrognosisDto *)prognosisDto1:(DateFormation *)dateFormater
{
    PrognosisDto *_onePrognosis = [[PrognosisDto alloc]init:platform1
                                                withArrival:[[dateFormater _englishDayFormatter] dateFromString:day1 ]
                                              withDeparture:[[dateFormater _englishDayFormatter] dateFromString:day2 ]
                                            withCapacity1st:id1
                                            withCapacity2nd:id2];
    
    NSString *_startDay = [[dateFormater _englishDayFormatter] stringFromDate:_onePrognosis._arrival ];
    NSString *_endDay = [[dateFormater _englishDayFormatter] stringFromDate:_onePrognosis._departure ];
    
    STAssertTrue([_startDay isEqualToString: day1], @"prognosis1 arrival %@ = %@",_startDay, day1);
    STAssertTrue([_endDay isEqualToString: day2], @"prognosis1 departure %@ = %@",_endDay, day2);
    STAssertEquals(_onePrognosis._platform, platform1, @"prognosis1 platform %@ = %@", _onePrognosis._platform, platform1);
    STAssertEquals(_onePrognosis._capacity1st, id1, @"prognosis1 1st capacity %@ = %@", _onePrognosis._capacity1st, id1);
    STAssertEquals(_onePrognosis._capacity2nd, id2, @"prognosis1 2nd capacity %@ = %@", _onePrognosis._capacity2nd, id2);
    
    return _onePrognosis;
}

- (PrognosisDto *)prognosisDto2:(DateFormation *)dateFormater
{
    PrognosisDto *_onePrognosis = [[PrognosisDto alloc]init:platform2
                                                withArrival:[[dateFormater _englishDayFormatter] dateFromString:day3 ]
                                              withDeparture:[[dateFormater _englishDayFormatter] dateFromString:day3 ]
                                            withCapacity1st:id3
                                            withCapacity2nd:id4];
    
    NSString *_startDay = [[dateFormater _englishDayFormatter] stringFromDate:_onePrognosis._arrival ];
    NSString *_endDay = [[dateFormater _englishDayFormatter] stringFromDate:_onePrognosis._departure ];
    
    STAssertTrue([_startDay isEqualToString: day3], @"prognosis2 arrival %@ = %@",_startDay, day3);
    STAssertTrue([_endDay isEqualToString: day3], @"prognosis2 departure %@ = %@",_endDay, day3);
    STAssertEquals(_onePrognosis._platform, platform2, @"prognosis2 platform %@ = %@", _onePrognosis._platform, platform2);
    STAssertEquals(_onePrognosis._capacity1st, id3, @"prognosis2 1st capacity %@ = %@", _onePrognosis._capacity1st, id3);
    STAssertEquals(_onePrognosis._capacity2nd, id4, @"prognosis2 2nd capacity %@ = %@", _onePrognosis._capacity2nd, id4);
    
    return _onePrognosis;
}



- (FromOrToDto *)fromOrToDto1:(StationDto *)station
                 withLocation:(StationDto *)location
                withPrognosis:(PrognosisDto *)prognosis
             withDateFormater:(DateFormation *)dateFormater
{
    FromOrToDto *_oneFromOrTo = [[FromOrToDto alloc]init:station
                                        withLocation:location
                                        withPrognosis:prognosis
                                            withDelay:delay1
                                        withArrivalDate:[[dateFormater _englishDayFormatter] dateFromString:day1 ]
                                        withArrivalTime:[[dateFormater _timeFormatter] dateFromString:startTime1 ]
                                        withDepartureDate:[[dateFormater _englishDayFormatter] dateFromString:day1 ]
                                        withDepartureTime:[[dateFormater _timeFormatter] dateFromString:endTime1 ]
                                            withPlatform:platform1];

    NSString *_startDay = [[dateFormater _englishDayFormatter] stringFromDate:_oneFromOrTo._arrivalDate ];
    NSString *_endDay = [[dateFormater _englishDayFormatter] stringFromDate:_oneFromOrTo._departureDate ];

    NSString *_startTime = [[dateFormater _timeFormatter] stringFromDate:_oneFromOrTo._arrivalTime ];
    NSString *_endTime = [[dateFormater _timeFormatter] stringFromDate:_oneFromOrTo._departureTime ];
    
    STAssertTrue([_startDay isEqualToString: day1], @"fromOrTo1 arrival date %@ = %@",_startDay, day1);
    STAssertTrue([_endDay isEqualToString: day1], @"fromOrTo1 departure date %@ = %@",_endDay, day1);
    STAssertTrue([_startTime isEqualToString: startTime1], @"fromOrTo1 arrival time %@ = %@",_startTime, startTime1);
    
    STAssertTrue([_endTime isEqualToString: endTime1], @"fromOrTo1 departure time %@ = %@",_endTime, endTime1);
    
    STAssertEquals(_oneFromOrTo._station._name, stationName1, @"fromOrTo1 station name %@ = %@", _oneFromOrTo._station._name, stationName1);
    STAssertEquals(_oneFromOrTo._location._name, stationName2, @"fromOrTo1 location name %@ = %@", _oneFromOrTo._location._name, stationName2);

    STAssertEquals(_oneFromOrTo._prognosis._platform, platform1, @"fromOrTo1 prognosis platform %@ = %@", _oneFromOrTo._prognosis._platform, platform1);
    STAssertEquals(_oneFromOrTo._delay, delay1, @"fromOrTo1 delay %@ = %@", _oneFromOrTo._delay, delay1);
    STAssertEquals(_oneFromOrTo._platform, platform1, @"fromOrTo1 platform %@ = %@", _oneFromOrTo._platform, platform1);
    
    return _oneFromOrTo;
}

- (FromOrToDto *)fromOrToDto2:(StationDto *)station
                 withLocation:(StationDto *)location
                withPrognosis:(PrognosisDto *)prognosis
             withDateFormater:(DateFormation *)dateFormater
{
    FromOrToDto *_oneFromOrTo = [[FromOrToDto alloc]init:station
                                            withLocation:location
                                           withPrognosis:prognosis
                                               withDelay:delay2
                                         withArrivalDate:[[dateFormater _englishDayFormatter] dateFromString:day2 ]
                                         withArrivalTime:[[dateFormater _timeFormatter] dateFromString:startTime2 ]
                                       withDepartureDate:[[dateFormater _englishDayFormatter] dateFromString:day2 ]
                                       withDepartureTime:[[dateFormater _timeFormatter] dateFromString:endTime2 ]
                                            withPlatform:platform2];
    
    NSString *_startDay = [[dateFormater _englishDayFormatter] stringFromDate:_oneFromOrTo._arrivalDate ];
    NSString *_endDay = [[dateFormater _englishDayFormatter] stringFromDate:_oneFromOrTo._departureDate ];
    
    NSString *_startTime = [[dateFormater _timeFormatter] stringFromDate:_oneFromOrTo._arrivalTime ];
    NSString *_endTime = [[dateFormater _timeFormatter] stringFromDate:_oneFromOrTo._departureTime ];
    
    STAssertTrue([_startDay isEqualToString: day2], @"fromOrTo2 arrival date %@ = %@",_startDay, day2);
    STAssertTrue([_endDay isEqualToString: day2], @"fromOrTo2 departure date %@ = %@",_endDay, day2);
    STAssertTrue([_startTime isEqualToString: startTime2], @"fromOrTo2 arrival time %@ = %@",_startTime, startTime2);
    
    STAssertTrue([_endTime isEqualToString: endTime2], @"fromOrTo2 departure time %@ = %@",_endTime, endTime2);
    
    STAssertEquals(_oneFromOrTo._station._name, stationName3, @"fromOrTo2 station name %@ = %@", _oneFromOrTo._station._name, stationName3);
    STAssertEquals(_oneFromOrTo._location._name, stationName4, @"fromOrTo2 location name %@ = %@", _oneFromOrTo._location._name, stationName4);
    
    STAssertEquals(_oneFromOrTo._prognosis._platform, platform2, @"fromOrTo2 prognosis platform %@ = %@", _oneFromOrTo._prognosis._platform, platform2);
    STAssertEquals(_oneFromOrTo._delay, delay2, @"fromOrTo2 delay %@ = %@", _oneFromOrTo._delay, delay2);
    STAssertEquals(_oneFromOrTo._platform, platform2, @"fromOrTo2 platform %@ = %@", _oneFromOrTo._platform, platform2);
    
    return _oneFromOrTo;
}



- (ServiceDto *)serviceDto1
{
    ServiceDto *_oneService = [[ServiceDto alloc]init:serviceNo withIrregular:serviceYes];
    STAssertEquals(_oneService._regular, serviceNo, @"service regular %@ = %@", _oneService._regular, serviceNo);
    STAssertEquals(_oneService._irregular, serviceYes, @"service irregular %@ = %@", _oneService._irregular, serviceYes);

    return _oneService;
}



-(ConnectionDto *)connectionDto1:(FromOrToDto *)from
                          withTo:(FromOrToDto *)to
                     withService:(ServiceDto *)service
{
    NSMutableArray *_productArray = [[NSMutableArray alloc]init];
    NSMutableArray *_sectionArray = [[NSMutableArray alloc]init];
    
    ConnectionDto *_oneConnection = [[ConnectionDto alloc]init:from
                                                        withTo:to
                                                    withDuration:duration1
                                                withTransfers:id2
                                                withService:service
                                                withProducts:_productArray
                                                withCapacity1st:id1
                                                withCapacity2nd:id2
                                                withSections:_sectionArray];
    return _oneConnection;
}


- (void) testPublicTransportConnection
{
    DateFormation *_dateFormater = [[DateFormation alloc]init];

    CoordinateDto *_coordinate1 = [self coordinateDto1];
    CoordinateDto *_coordinate2 = [self coordinateDto2];
    CoordinateDto *_coordinate3 = [[CoordinateDto alloc]init:coordinateType1 withX:coordinateX3 withY:coordinateY3];
    CoordinateDto *_coordinate4 = [[CoordinateDto alloc]init:coordinateType2 withX:coordinateX4 withY:coordinateY4];
    
    PrognosisDto *_prognosis1 = [self prognosisDto1:_dateFormater];
    PrognosisDto *_prognosis2 = [self prognosisDto2:_dateFormater];
    
    StationDto *_station1 = [self stationDto1:_coordinate1];
    StationDto *_station2 = [self stationDto2:_coordinate2];

    StationDto *_station3 = [[StationDto alloc]init:stationId3
                                          withScore:stationScore3
                                           withName:stationName3
                                       withDistance:stationDistance3
                                     withCoordinate:_coordinate3];
    StationDto *_station4 = [[StationDto alloc]init:stationId4
                                          withScore:stationScore4
                                           withName:stationName4
                                       withDistance:stationDistance4
                                      withCoordinate:_coordinate4];
    
    FromOrToDto *_fromOrTo1 = [self fromOrToDto1:_station1
                                    withLocation:_station2
                                   withPrognosis:_prognosis1
                                withDateFormater:_dateFormater];
    
    FromOrToDto *_fromOrTo2 = [self fromOrToDto2:_station3
                                    withLocation:_station4
                                   withPrognosis:_prognosis2
                                withDateFormater:_dateFormater];
    
    ServiceDto *_oneService1 = [self serviceDto1];
    
    ConnectionDto *_oneConnection1 = [self connectionDto1:_fromOrTo1 withTo:_fromOrTo2 withService:_oneService1];
    
    NSMutableArray *_connectionArray = [[NSMutableArray alloc]init];
    [_connectionArray addObject:_oneConnection1];
    
    ConnectionArrayDto *_oneConnectionArray1 = [[ConnectionArrayDto alloc]init:_connectionArray];
    int cnt = [_oneConnectionArray1._connections count];
    STAssertEquals(cnt, 1, @"connection array count %i = %i", cnt, 1);
}

@end
