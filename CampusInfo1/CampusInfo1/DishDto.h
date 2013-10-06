/*
 DishDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header DishDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the dish data in MensaMenuDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives dish id, external, internal, partner price, label, name, version and an array of side dishes to be initally set or a dictionary to browse the data itself. </li>
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

@interface DishDto : NSObject
{
    /*! @var _dishId Stores the id of the dish */
    int             _dishId;
    /*! @var _externalPrice Holds the external price of the dish */
    double          _externalPrice;
    /*! @var _internalPrice Holds the internal price of the dish */
    double          _internalPrice;
    /*! @var _priceForPartners Holds the partner price of the dish */
    double          _priceForPartners;
    /*! @var _label Holds the label of the dish */
    NSString        *_label;
    /*! @var _name Holds the name of the dish */
    NSString        *_name;
    /*! @var _version Holds the version of the dish */
    NSString        *_version;
    /*! @var _sideDishes Holds an array of side dishes of the dish */
    NSMutableArray  *_sideDishes;
}

@property (nonatomic, assign) int               _dishId;
@property (nonatomic, assign) double            _externalPrice;
@property (nonatomic, assign) double            _internalPrice;
@property (nonatomic, assign) double            _priceForPartners;
@property (nonatomic, retain) NSString          *_label;
@property (nonatomic, retain) NSString          *_name;
@property (nonatomic, retain) NSString          *_version;
@property (nonatomic, retain) NSMutableArray    *_sideDishes;

/*!
 @function init
 Initializes DishDto.
 @param newDishId
 @param newExternalPrice
 @param newInternalPrice
 @param newPriceForPartners
 @param newLabel
 @param newName
 @param newVersion
 @param newSideDishes
 */
-(id)   init              : (int) newDishId
        withExternalPrice : (double) newExternalPrice
        withInternalPrice : (double) newInternalPrice
      withPriceForPartners: (double) newPriceForPartners
                withLabel : (NSString *)newLabel
                  withName: (NSString *)newName
               withVersion: (NSString *)newVersion
            withSideDishes: (NSMutableArray *) newSideDishes;

/*!
 @function getDish
 Is called when a new DishDto instance should be created based on the dictionary information.
 @param dishDictionary
 */
- (DishDto *)getDish:(NSDictionary *)dishDictionary;

@end
