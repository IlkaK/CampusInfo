//
//  MenuPlanDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 23.07.13.
//
//

#import <Foundation/Foundation.h>
#import <CalendarWeekDto.h>

@interface MenuPlanDto : NSObject
{
    int             _menuPlanId;
    NSString        *_version;
    CalendarWeekDto *_calendarWeek;
    NSMutableArray  *_gastronomyFacilityIds;
    NSMutableArray  *_menus;
}

@property (nonatomic, assign) int                       _menuPlanId;
@property (nonatomic, retain) CalendarWeekDto           *_calendarWeek;
@property (nonatomic, retain) NSMutableArray            *_gastronomyFacilityIds;
@property (nonatomic, retain) NSMutableArray            *_menus;
@property (nonatomic, retain) NSString                  *_version;


-(id)   init               : (int) newMenuPlanId
                withVersion: (NSString *) newVersion
           withCalendarWeek: (CalendarWeekDto *) newCalendarWeek
  withGastronomyFacilityIds: (NSMutableArray *)newGastronomyFacilityIds
                  withMenus: (NSMutableArray *)newMenus;


- (MenuPlanDto *)getMenuPlan:(NSDictionary *)menuPlanDictionary;

@end