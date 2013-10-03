/*
 ConnectionDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ConnectionDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds connection data for PublicTransportConnectionDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives from, to duration, transfers, service, products, first and second capacity, sections to be initally set or a dictionary to browse the data itself. </li>
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
#import "ServiceDto.h"


@interface ConnectionDto : NSObject
{
    /*! @var _from Stores the start (from) of the connection */
    FromOrToDto     *_from;
    /*! @var _to Stores the stop (to) of the connection */
    FromOrToDto     *_to;
    /*! @var _duration Stores the duration of the connection */
    NSString        *_duration;
    /*! @var _transfers Stores the transfer count of the connection */
    int             _transfers;
    /*! @var _service Stores the service of the connection */
    ServiceDto      *_service;
    /*! @var _products Stores the products used in the connection */
    NSMutableArray  *_products;
    /*! @var _capacity1st Stores the first capacity of the connection */
    int             _capacity1st;
    /*! @var _capacity2nd Stores the second capacity of the connection */
    int             _capacity2nd;
    /*! @var _sections Stores an array of sections of the connection */
    NSMutableArray  *_sections;
}

@property (nonatomic, retain) FromOrToDto       *_from;
@property (nonatomic, retain) FromOrToDto       *_to;
@property (nonatomic, retain) NSString          *_duration;
@property (nonatomic, assign) int               _transfers;
@property (nonatomic, retain) ServiceDto        *_service;
@property (nonatomic, retain) NSMutableArray    *_products;
@property (nonatomic, assign) int               _capacity1st;
@property (nonatomic, assign) int               _capacity2nd;
@property (nonatomic, retain) NSMutableArray    *_sections;

/*!
 @function init
 Needs to be called initally, when instance of ConnectionDto is created.
 @param newFrom
 @param newTo
 @param newDuration
 @param newTransfers
 @param newService
 @param newProducts
 @param newCapacity1st
 @param newCapacity2nd
 @param newSections
 */
-(id)                   init: (FromOrToDto *)newFrom
                      withTo: (FromOrToDto *)newTo
                withDuration: (NSString *)newDuration
               withTransfers: (int) newTransfers
                 withService: (ServiceDto *)newService
                withProducts: (NSMutableArray *)newProducts
             withCapacity1st: (int) newCapacity1st
             withCapacity2nd: (int) newCapacity2nd
                withSections: (NSMutableArray *)newSections;

/*!
 @function getConnection
 Is called when a new ConnectionDto instance should be created based on the dictionary information.
 @param connectionDictionary
 */
- (ConnectionDto *)getConnection:(NSDictionary *)connectionDictionary;

@end
