//
//  DishDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 23.07.13.
//
//

#import <Foundation/Foundation.h>

@interface DishDto : NSObject
{
    int             _dishId;
    double          _externalPrice;
    double          _internalPrice;
    double          _priceForPartners;
    NSString        *_label;
    NSString        *_name;
    NSString        *_version;
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

-(id)   init              : (int) newDishId
        withExternalPrice : (double) newExternalPrice
        withInternalPrice : (double) newInternalPrice
      withPriceForPartners: (double) newPriceForPartners
                withLabel : (NSString *)newLabel
                  withName: (NSString *)newName
               withVersion: (NSString *)newVersion
            withSideDishes: (NSMutableArray *) newSideDishes;

- (DishDto *)getDish:(NSDictionary *)dishDictionary;

@end
