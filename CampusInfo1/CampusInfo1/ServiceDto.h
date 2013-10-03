/*
 ServiceDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ServiceDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the service data for PublicTransportConnectionDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives regular and irregular to be initally set or a dictionary to browse the data itself. </li>
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

@interface ServiceDto : NSObject
{
    /*! @var _regular Stores regular of Service */
    NSString        *_regular;
    /*! @var _irregular Stores irregular of Service */
    NSString        *_irregular;
}

@property (nonatomic, retain) NSString          *_regular;
@property (nonatomic, retain) NSString          *_irregular;

/*!
 @function init
 Needs to be called initally, when instance of ServiceDto is created.
 @param newRegular
 @param newIrregular
 */
-(id)                     init: (NSString *)newRegular
                 withIrregular: (NSString *)newIrregular;

/*!
 @function getService
 Is called when a new ServiceDto instance should be created based on the dictionary information.
 @param serviceDictionary
 */
- (ServiceDto *)getService:(NSDictionary *)serviceDictionary;

@end
