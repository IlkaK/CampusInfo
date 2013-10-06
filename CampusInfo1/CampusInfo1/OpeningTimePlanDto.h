/*
 OpeningTimePlanDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header OpeningTimePlanDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the opening time plan data in MensaOverviewDto model. </li>
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

@interface OpeningTimePlanDto : NSObject
{
    /*! @var _weekdays Holds an array of weekdays of the opening time plan */
    NSMutableArray   *_weekdays;
    /*! @var _planType Holds the plan type of the opening time plan */
    NSString         *_planType;
}

@property (nonatomic, retain) NSMutableArray    *_weekdays;
@property (nonatomic, retain) NSString          *_planType;

/*!
 @function init
 Initializes OpeningTimePlanDto.
 @param newWeekdays
 @param newPlanType
 */
-(id)           init: (NSMutableArray  *) newWeekdays
        withPlanType: (NSString *)newPlanType;

/*!
 @function getOpeningTimePlan
 Is called when a new OpeningTimePlanDto instance should be created based on the dictionary information.
 @param openingTimePlanDictionary
 */
- (OpeningTimePlanDto *)getOpeningTimePlan:(NSDictionary *)openingTimePlanDictionary;


@end