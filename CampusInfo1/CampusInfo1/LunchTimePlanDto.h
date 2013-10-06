/*
 LunchTimePlanDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header LunchTimePlanDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the lunch time plan data in MensaOverviewDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives an array of week days and plan type to be initally set or a dictionary to browse the data itself. </li>
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

@interface LunchTimePlanDto : NSObject
{
    /*! @var _weekdays Holds an array of weekdays of the lunch time plan */
    NSMutableArray   *_weekdays;
    /*! @var _planType Holds the plan type of the lunch time plan */
    NSString         *_planType;
}

@property (nonatomic, retain) NSMutableArray    *_weekdays;
@property (nonatomic, retain) NSString          *_planType;

/*!
 @function init
 Initializes LunchTimePlanDto.
 @param newWeekdays
 @param newPlanType
 */
-(id)           init: (NSMutableArray  *) newWeekdays
        withPlanType: (NSString *)newPlanType;

/*!
 @function getLunchTimePlan
 Is called when a new LunchTimePlanDto instance should be created based on the dictionary information.
 @param lunchTimePlanDictionary
 */
- (LunchTimePlanDto *)getLunchTimePlan:(NSDictionary *)lunchTimePlanDictionary;

@end