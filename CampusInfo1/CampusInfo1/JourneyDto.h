//
//  JourneyDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.09.13.
//
//

#import <Foundation/Foundation.h>
#import "FromOrToDto.h"

@interface JourneyDto : NSObject
{
    NSString        *_name;
    NSString        *_category;
    int             _categoryCode;
    NSString        *_journeyNumber;
    NSString        *_operator;
    NSString        *_to;
    NSMutableArray  *_passList;
    int             _capacity1st;
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

-(id)                   init: (NSString *)newName
                withCategory: (NSString *)newCategory
            withCategoryCode: (int)newCategoryCode
           withJourneyNumber: (NSString *)newJourneyNumber
                withOperator: (NSString *)newOperator
                      withTo: (NSString *)newTo
                withPassList: (NSMutableArray *)newPassList
             withCapacity1st: (int) newCapacity1st
             withCapacity2nd: (int) newCapacity2nd;


- (JourneyDto *)getJourney:(NSDictionary *)journeyDictionary;

@end
