/*
 MenuDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header MenuDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the menu data in MensaMenuDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives menu id, dishes, offered on date and version to be initally set or a dictionary to browse the data itself. </li>
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
#import "DateFormation.h"

@interface MenuDto : NSObject
{
    /*! @var _menuId Stores the id of the menu */
    int             _menuId;
    /*! @var _dishes Holds an array of dishes of the menu */
    NSMutableArray  *_dishes;
    /*! @var _offeredOn Holds the date when the menu is offered */
    NSDate          *_offeredOn;
    /*! @var _version Holds the version when the menu is offered */
    NSString        *_version;
    
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation   *_dateFormatter;
}

@property (nonatomic, assign) int               _menuId;
@property (nonatomic, retain) NSMutableArray    *_dishes;
@property (nonatomic, retain) NSDate            *_offeredOn;
@property (nonatomic, retain) NSString          *_version;
@property (nonatomic, retain) DateFormation     *_dateFormatter;

/*!
 @function init
 Initializes MenuDto.
 @param newMenuId
 @param newDishes
 @param newOfferedOn
 @param newVersion
 */
-(id)         init:(int) newMenuId
        withDishes:(NSMutableArray *) newDishes
     withOfferedOn:(NSDate *)newOfferedOn
       withVersion:(NSString *)newVersion;

/*!
 @function getMenuWeek
 Is called when a new MenuDto instance should be created based on the dictionary information.
 @param menuDictionary
 */
- (MenuDto *)getMenuWeek:(NSDictionary *)menuDictionary;

@end