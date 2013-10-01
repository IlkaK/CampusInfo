//
//  MensaMenuDtoTest.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 22.09.13.
//
//

#import "MensaMenuDtoTest.h"

#import "DateFormation.h"
#import "SideDishDto.h"
#import "DishDto.h"
#import "MenuPlanDto.h"
#import "CalendarWeekDto.h"
#import "MenuDto.h"
#import "MenuPlanArrayDto.h"

#import "TestConstants.h"

@implementation MensaMenuDtoTest


- (SideDishDto *)sideDishDto1
{
    SideDishDto *_oneSideDish = [[SideDishDto alloc]init:id1
                                                withName:sideDishName1
                                             withVersion:version10];
    STAssertEquals(_oneSideDish._sideDishId, id1, @"sideDish1 id %@ = %@",_oneSideDish._sideDishId, id1);
    STAssertEquals(_oneSideDish._name, sideDishName1, @"sideDish1 name %@ = %@",_oneSideDish._name, sideDishName1);
    STAssertEquals(_oneSideDish._version, version10, @"sideDish1 version %@ = %@",_oneSideDish._version, version10);
    return _oneSideDish;
}


- (SideDishDto *)sideDishDto2
{
    SideDishDto *_oneSideDish = [[SideDishDto alloc]init:id2
                                                withName:sideDishName2
                                             withVersion:version11];
    STAssertEquals(_oneSideDish._sideDishId, id2, @"sideDish2 id %@ = %@",_oneSideDish._sideDishId, id2);
    STAssertEquals(_oneSideDish._name, sideDishName2, @"sideDish2 name %@ = %@",_oneSideDish._name, sideDishName2);
    STAssertEquals(_oneSideDish._version, version11, @"sideDish2 version %@ = %@",_oneSideDish._version, version11);
    return _oneSideDish;
}


- (DishDto *)dishDto1:(SideDishDto *)sideDish1
withSideDish2:(SideDishDto *)sideDish2
{
    NSMutableArray *_sideDishArray = [[NSMutableArray alloc]init];
    [_sideDishArray addObject:sideDish1];
    [_sideDishArray addObject:sideDish2];
    
    DishDto *_oneDish = [[DishDto alloc]init:id1
                            withExternalPrice:price1
                            withInternalPrice:price2
                        withPriceForPartners:price3
                            withLabel:dishLabel1
                            withName:dishName1
                            withVersion:version10
                        withSideDishes:_sideDishArray];
   
    STAssertEquals(_oneDish._dishId, id1, @"dish1 id %@ = %@",_oneDish._dishId, id1);
    STAssertEquals(_oneDish._name, dishName1, @"dish1 name %@ = %@",_oneDish._name, dishName1);
    STAssertEquals(_oneDish._version, version10, @"dish1 version %@ = %@",_oneDish._version, version10);
    STAssertEquals(_oneDish._externalPrice, price1, @"dish1 external price %@ = %@",_oneDish._externalPrice, price1);
    STAssertEquals(_oneDish._internalPrice, price2, @"dish1 internal price %@ = %@",_oneDish._internalPrice, price2);
    STAssertEquals(_oneDish._priceForPartners, price3, @"dish1 partner price %@ = %@",_oneDish._priceForPartners, price3);
    int cnt = [_oneDish._sideDishes count];
    STAssertEquals(cnt, 2, @"dish1 side dish count %i = %i",cnt, 2);
    return _oneDish;
}

- (DishDto *)dishDto2:(SideDishDto *)sideDish1
{
    NSMutableArray *_sideDishArray = [[NSMutableArray alloc]init];
    [_sideDishArray addObject:sideDish1];
    
    DishDto *_oneDish = [[DishDto alloc]init:id2
                           withExternalPrice:price4
                           withInternalPrice:price5
                        withPriceForPartners:price6
                                   withLabel:dishLabel2
                                    withName:dishName2
                                 withVersion:version11
                              withSideDishes:_sideDishArray];
    
    STAssertEquals(_oneDish._dishId, id2, @"dish2 id %@ = %@",_oneDish._dishId, id2);
    STAssertEquals(_oneDish._name, dishName2, @"dish2 name %@ = %@",_oneDish._name, dishName2);
    STAssertEquals(_oneDish._version, version11, @"dish2 version %@ = %@",_oneDish._version, version11);
    STAssertEquals(_oneDish._externalPrice, price4, @"dish2 external price %@ = %@",_oneDish._externalPrice, price4);
    STAssertEquals(_oneDish._internalPrice, price5, @"dish2 internal price %@ = %@",_oneDish._internalPrice, price5);
    STAssertEquals(_oneDish._priceForPartners, price6, @"dish2 partner price %@ = %@",_oneDish._priceForPartners, price6);
    int cnt = [_oneDish._sideDishes count];
    STAssertEquals(cnt, 1, @"dish2 side dish count %i = %i",cnt, 1);
    return _oneDish;
}


- (MenuDto *)menuDto1:(DateFormation *)dateFormater
            withDish1:(DishDto *)dish1
            withDish2:(DishDto *)dish2
{
    NSMutableArray *_dishArray = [[NSMutableArray alloc]init];
    [_dishArray addObject:dish1];
    [_dishArray addObject:dish2];
    
    MenuDto *_oneMenu = [[MenuDto alloc]init:id1
                            withDishes:_dishArray
                            withOfferedOn:[[dateFormater _englishDayFormatter] dateFromString:day1 ]
                            withVersion:version10];

    STAssertEquals(_oneMenu._menuId, id1, @"menu id %@ = %@",_oneMenu._menuId, id1);
    
    int cnt = [_oneMenu._dishes count];
    STAssertEquals(cnt, 2, @"menu dish count %i = %i",cnt, 2);
    
    NSString *_startDay = [[dateFormater _englishDayFormatter] stringFromDate:_oneMenu._offeredOn ];
    STAssertTrue([_startDay isEqualToString: day1], @"menu offered on %@ = %@",_startDay, day1);
    
    STAssertEquals(_oneMenu._version, version10, @"menu version %@ = %@",_oneMenu._version, version10);
    return _oneMenu;
}

- (MenuDto *)menuDto2:(DateFormation *)dateFormater
            withDish1:(DishDto *)dish1
{
    NSMutableArray *_dishArray = [[NSMutableArray alloc]init];
    [_dishArray addObject:dish1];
    
    MenuDto *_oneMenu = [[MenuDto alloc]init:id2
                                  withDishes:_dishArray
                               withOfferedOn:[[dateFormater _englishDayFormatter] dateFromString:day2]
                                 withVersion:version11];
    
    STAssertEquals(_oneMenu._menuId, id2, @"menu id %@ = %@",_oneMenu._menuId, id2);
    
    int cnt = [_oneMenu._dishes count];
    STAssertEquals(cnt, 1, @"menu dish count %i = %i",cnt, 1);
    
    NSString *_startDay = [[dateFormater _englishDayFormatter] stringFromDate:_oneMenu._offeredOn ];
    STAssertTrue([_startDay isEqualToString: day2], @"menu offered on %@ = %@",_startDay, day2);
    
    STAssertEquals(_oneMenu._version, version11, @"menu version %@ = %@",_oneMenu._version, version11);
    return _oneMenu;
}


- (MenuPlanDto *)menuPlanDto1:(CalendarWeekDto *)calendarWeek
                 withMenu1:(MenuDto *)menu1
                 withMenu2:(MenuDto *)menu2
{
    NSMutableArray *_menuArray = [[NSMutableArray alloc]init];
    [_menuArray addObject:menu1];
    [_menuArray addObject:menu2];
    NSMutableArray *_gastroArray = [[NSMutableArray alloc]init];
    
    MenuPlanDto *_oneMenuPlan = [[MenuPlanDto alloc]init:id1
                                             withVersion:version10
                                        withCalendarWeek:calendarWeek
                               withGastronomyFacilityIds:_gastroArray
                                               withMenus:_menuArray];

    STAssertEquals(_oneMenuPlan._menuPlanId, id1, @"menu plan id %@ = %@",_oneMenuPlan._menuPlanId, id1);
    STAssertEquals(_oneMenuPlan._version, version10, @"menu plan version %@ = %@",_oneMenuPlan._version, version10);

    STAssertEquals(_oneMenuPlan._calendarWeek._week, week1, @"menu plan week %@ = %@",_oneMenuPlan._calendarWeek._week, week1);
    STAssertEquals(_oneMenuPlan._calendarWeek._year, year1, @"menu plan year %@ = %@",_oneMenuPlan._calendarWeek._year, year1);
    
    int cnt = [_oneMenuPlan._menus count];
    STAssertEquals(cnt, 2, @"menu plan menu count %i = %i",cnt, 2);
    cnt = [_oneMenuPlan._gastronomyFacilityIds count];
    STAssertEquals(cnt, 0, @"menu plan gastronomy facility count %i = %i",cnt, 0);
    
    return _oneMenuPlan;
}


- (CalendarWeekDto *)calendarWeekDto1
{
    CalendarWeekDto *_oneCalendarWeek = [[CalendarWeekDto alloc]init:week1 withYear:year1];
    STAssertEquals(_oneCalendarWeek._week, week1, @"dish1 week %i = %i",_oneCalendarWeek._week, week1);
    STAssertEquals(_oneCalendarWeek._year, year1, @"dish1 year %i = %i",_oneCalendarWeek._year, year1);
    return _oneCalendarWeek;
}


- (void) testMensaMenu
{
    DateFormation *_dateFormater = [[DateFormation alloc]init];

    SideDishDto *_sideDish1 = [self sideDishDto1];
    SideDishDto *_sideDish2 = [self sideDishDto2];
    SideDishDto *_sideDish3 = [[SideDishDto alloc]init:id3
                                              withName:sideDishName3
                                           withVersion:version20];
    
    DishDto *_dish1 = [self dishDto1:_sideDish1 withSideDish2:_sideDish2];
    DishDto *_dish2 = [self dishDto2:_sideDish3];
    
    CalendarWeekDto *_calendarWeek1 = [self calendarWeekDto1];
    
    MenuDto *_menu1 = [self menuDto1:_dateFormater withDish1:_dish1 withDish2:_dish2];
    MenuDto *_menu2 = [self menuDto2:_dateFormater withDish1:_dish2];
    
    MenuPlanDto *_menuPlan1 = [self menuPlanDto1:_calendarWeek1 withMenu1:_menu1 withMenu2:_menu2];
    
    NSMutableArray *_menuPlans = [[NSMutableArray alloc]init];
    [_menuPlans addObject:_menuPlan1];
    
    MenuPlanArrayDto *_menuPlanArray1 = [[MenuPlanArrayDto alloc]init:_menuPlans];

    int cnt = [_menuPlanArray1._menuPlans count];
    STAssertEquals(cnt, 1, @"menu plan array count %i = %i",cnt, 1);
    
}

@end
