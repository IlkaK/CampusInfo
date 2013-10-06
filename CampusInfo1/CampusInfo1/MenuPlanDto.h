/*
 MenuPlanDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header MenuPlanDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the calendar menu plan data in MensaMenuDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives menu plan id, version, calendar week, gastronomy facility id and an array of menus to be initally set or a dictionary to browse the data itself. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It returns itself when called. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */


#import <Foundation/Foundation.h>
#import "CalendarWeekDto.h"


@interface MenuPlanDto : NSObject
{
    /*! @var _menuPlanId Stores the id of the menu plan */
    int                         _menuPlanId;
     /*! @var _version Holds the version of the menu plan */
    NSString                    *_version;
    /*! @var _calendarWeek Holds the calendar week of the menu plan */
    CalendarWeekDto             *_calendarWeek;
    /*! @var _version Holds an array of gastronomic facility ids, where the menu plan applies */
    NSMutableArray              *_gastronomyFacilityIds;
    /*! @var _menus Holds an array of menus of the menu plan */
    NSMutableArray              *_menus;
}


@property (nonatomic, assign) int                               _menuPlanId;
@property (nonatomic, retain) CalendarWeekDto                   *_calendarWeek;
@property (nonatomic, retain) NSMutableArray                    *_gastronomyFacilityIds;
@property (nonatomic, retain) NSMutableArray                    *_menus;
@property (nonatomic, retain) NSString                          *_version;


/*!
 @function init
 Initializes MenuPlanDto.
 @param newMenuPlanId
 @param newVersion
 @param newCalendarWeek
 @param newGastronomyFacilityIds
 @param newMenus 
 */
-(id)   init               : (int) newMenuPlanId
                withVersion: (NSString *) newVersion
           withCalendarWeek: (CalendarWeekDto *) newCalendarWeek
  withGastronomyFacilityIds: (NSMutableArray *)newGastronomyFacilityIds
                  withMenus: (NSMutableArray *)newMenus;

/*!
 @function getMenuPlan
 Is called when a new MenuPlanDto instance should be created based on the dictionary information.
 @param menuPlanDictionary
 */
- (MenuPlanDto *)getMenuPlan:(NSDictionary *)menuPlanDictionary;

@end