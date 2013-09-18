//
//  DishDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 23.07.13.
//
//

#import "DishDto.h"
#import "SideDishDto.h"

@implementation DishDto
@synthesize _version;
@synthesize _name;
@synthesize _dishId;
@synthesize _externalPrice;
@synthesize _internalPrice;
@synthesize _label;
@synthesize _priceForPartners;
@synthesize _sideDishes;


-(id)   init              : (int) newDishId
        withExternalPrice : (double) newExternalPrice
        withInternalPrice : (double) newInternalPrice
      withPriceForPartners: (double) newPriceForPartners
                withLabel : (NSString *)newLabel
                  withName: (NSString *)newName
               withVersion: (NSString *)newVersion
            withSideDishes: (NSMutableArray *) newSideDishes
{
    self = [super init];
    if (self)
    {
        self._dishId            = newDishId;
        self._externalPrice     = newExternalPrice;
        self._internalPrice     = newInternalPrice;
        self._priceForPartners  = newPriceForPartners;
        self._label             = newLabel;
        self._name              = newName;
        self._version           = newVersion;
        self._sideDishes        = newSideDishes;
    }
    return self;
}


- (DishDto *)getDish:(NSDictionary *)dishDictionary
{
    DishDto *_localDish = [[DishDto alloc]init:0 withExternalPrice:0 withInternalPrice:0 withPriceForPartners:0 withLabel:nil withName:nil withVersion:nil withSideDishes:nil];
    
    int             _localDishId;
    double          _localExternalPrice;
    double          _localInternalPrice;
    double          _localPriceForPartners;
    NSString        *_localDishLabel;
    NSString        *_localDishName;
    NSString        *_localDishVersion;
    NSMutableArray  *_localSideDishes  = [[NSMutableArray alloc] init];
    
    NSMutableArray  *_sideDishArray;
    int             _sideDishArrayI;
    SideDishDto     *_localSideDish = [[SideDishDto alloc]init:0 withName:nil withVersion:nil];

    for (id dishKey in dishDictionary)
    {
        //NSLog(@"dishKey key: %@", dishKey);
        if ([dishKey isEqualToString:@"id"])
        {
            _localDishId = [[dishDictionary objectForKey:dishKey] intValue];
            //NSLog(@"_localDishId: %i", _localDishId);
        }   
        if ([dishKey isEqualToString:@"externalPrice"])
        {
            _localExternalPrice = [[dishDictionary objectForKey:dishKey] doubleValue];
            //NSLog(@"_localExternalPrice: %g", _localExternalPrice);
        }
        if ([dishKey isEqualToString:@"internalPrice"])
        {
            _localInternalPrice = [[dishDictionary objectForKey:dishKey] doubleValue];
            //NSLog(@"_localExternalPrice: %g", _localInternalPrice);
        }
        if ([dishKey isEqualToString:@"priceForPartners"])
        {
            _localPriceForPartners = [[dishDictionary objectForKey:dishKey] doubleValue];
            //NSLog(@"_localPriceForPartners: %g", _localPriceForPartners);
        }
        if ([dishKey isEqualToString:@"label"])
        {
            _localDishLabel = [dishDictionary objectForKey:dishKey];
            //NSLog(@"_localDishLabel: %@", _localDishLabel);
        }
        if ([dishKey isEqualToString:@"name"])
        {
            _localDishName = [dishDictionary objectForKey:dishKey];
            //NSLog(@"_localDishName: %@", _localDishName);
        }
        if ([dishKey isEqualToString:@"version"])
        {
            _localDishVersion = [dishDictionary objectForKey:dishKey];
            //NSLog(@"_localDishVersion: %@", _localDishVersion);
        }
        if ([dishKey isEqualToString:@"sideDishes"])
        {
            _sideDishArray = [dishDictionary objectForKey:dishKey];
            
            if([_sideDishArray lastObject] != nil)
            {
            
                for (_sideDishArrayI = 0; _sideDishArrayI < [_sideDishArray count]; _sideDishArrayI++)
                {
                    _localSideDish = [_localSideDish getSideDish:[_sideDishArray objectAtIndex:_sideDishArrayI]];
                    [_localSideDishes addObject:_localSideDish];
                }
            }
        }
    }
    _localDish = [_localDish init:_localDishId
                withExternalPrice:_localExternalPrice
                withInternalPrice:_localInternalPrice
             withPriceForPartners:_localPriceForPartners
                        withLabel:_localDishLabel
                         withName:_localDishName
                      withVersion:_localDishVersion
                   withSideDishes:_localSideDishes
                  ];
    
    return _localDish;

}


@end
