/*
 SideDishDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header SideDishDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the side dish data in MensaMenuDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives side dish id, name and version to be initally set or a dictionary to browse the data itself. </li>
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

@interface SideDishDto : NSObject
{
    /*! @var _sideDishId Stores the id of the side dish */
    int             _sideDishId;
    /*! @var _name Holds the name of the side dish */
    NSString        *_name;
    /*! @var _name Holds the version of the side dish */
    NSString        *_version;
}

@property (nonatomic, assign) int               _sideDishId;
@property (nonatomic, retain) NSString          *_name;
@property (nonatomic, retain) NSString          *_version;

/*!
 @function init
 Initializes SideDishDto.
 @param newSideDishId
 @param newVersion
 */
-(id)   init : (int) newSideDishId
     withName: (NSString *)newName
  withVersion: (NSString *)newVersion;

/*!
 @function getSideDish
 Is called when a new SideDishDto instance should be created based on the dictionary information.
 @param sideDishDictionary
 */
- (SideDishDto *)getSideDish:(NSDictionary *)sideDishDictionary;

@end