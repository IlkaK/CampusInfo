//
//  ConnectionDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.09.13.
//
//

#import <Foundation/Foundation.h>
#import "FromOrToDto.h"
#import "ServiceDto.h"


@interface ConnectionDto : NSObject
{
    FromOrToDto     *_from;
    FromOrToDto     *_to;
    NSString        *_duration;
    int             _transfers;
    ServiceDto      *_service;
    NSMutableArray  *_products;
    int             _capacity1st;
    int             _capacity2nd;
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


-(id)                   init: (FromOrToDto *)newFrom
                      withTo: (FromOrToDto *)newTo
                withDuration: (NSString *)newDuration
               withTransfers: (int) newTransfers
                 withService: (ServiceDto *)newService
                withProducts: (NSMutableArray *)newProducts
             withCapacity1st: (int) newCapacity1st
             withCapacity2nd: (int) newCapacity2nd
                withSections: (NSMutableArray *)newSections;

- (ConnectionDto *)getConnection:(NSDictionary *)connectionDictionary;

@end
