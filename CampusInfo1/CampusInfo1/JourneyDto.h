/*
 JourneyDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header JourneyDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds journey data for PublicTransportConnectionDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives name, category, category code, journey number, operator, to, pass list, first and second capacity to be initally set or a dictionary to browse the data itself. </li>
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
#import "FromOrToDto.h"

@interface JourneyDto : NSObject
{
    /*! @var _name Stores the name of the journey */
    NSString        *_name;
    /*! @var _category Stores the category of the journey */
    NSString        *_category;
    /*! @var _categoryCode Stores the category code of the journey */
    int             _categoryCode;
    /*! @var _journeyNumber Stores the journey number of the journey */
    NSString        *_journeyNumber;
    /*! @var _operator Stores the operator of the journey */
    NSString        *_operator;
    /*! @var _to Stores the destination (to) of the journey */
    NSString        *_to;
    /*! @var _passList Stores the pass list of the journey */
    NSMutableArray  *_passList;
    /*! @var _capacity1st Stores the first capacity of the journey */
    int             _capacity1st;
    /*! @var _capacity2nd Stores the second capacity of the journey */
    int             _capacity2nd;
}

@property (nonatomic, retain) NSString          *_name;
@property (nonatomic, retain) NSString          *_category;
@property (nonatomic, assign) int               _categoryCode;
@property (nonatomic, retain) NSString          *_journeyNumber;
@property (nonatomic, retain) NSString          *_operator;
@property (nonatomic, retain) NSString          *_to;
@property (nonatomic, retain) NSMutableArray    *_passList;
@property (nonatomic, assign) int               _capacity1st;
@property (nonatomic, assign) int               _capacity2nd;

/*!
 @function init
 Needs to be called initally, when instance of JourneyDto is created.
 @param newName
 @param newCategory
 @param newCategoryCode
 @param newJourneyNumber
 @param newOperator
 @param newTo
 @param newPassList
 @param newCapacity1st
 @param newCapacity2nd
 */
-(id)                   init: (NSString *)newName
                withCategory: (NSString *)newCategory
            withCategoryCode: (int)newCategoryCode
           withJourneyNumber: (NSString *)newJourneyNumber
                withOperator: (NSString *)newOperator
                      withTo: (NSString *)newTo
                withPassList: (NSMutableArray *)newPassList
             withCapacity1st: (int) newCapacity1st
             withCapacity2nd: (int) newCapacity2nd;

/*!
 @function getJourney
 Is called when a new JourneyDto instance should be created based on the dictionary information.
 @param journeyDictionary
 */
- (JourneyDto *)getJourney:(NSDictionary *)journeyDictionary;

@end
