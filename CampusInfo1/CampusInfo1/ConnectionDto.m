//
//  ConnectionDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.09.13.
//
//

#import "ConnectionDto.h"
#import "SectionDto.h"


@implementation ConnectionDto
@synthesize _capacity1st;
@synthesize _capacity2nd;
@synthesize _duration;
@synthesize _from;
@synthesize _products;
@synthesize _sections;
@synthesize _service;
@synthesize _to;
@synthesize _transfers;

-(id)                   init: (FromOrToDto *)newFrom
                      withTo: (FromOrToDto *)newTo
                withDuration: (NSString *)newDuration
               withTransfers: (int) newTransfers
                 withService: (ServiceDto *)newService
                withProducts: (NSMutableArray *)newProducts
             withCapacity1st: (int) newCapacity1st
             withCapacity2nd: (int) newCapacity2nd
                withSections: (NSMutableArray *)newSections
{
    self = [super init];
    if (self)
    {
        self._from              = newFrom;
        self._to                = newTo;
        self._duration          = newDuration;
        self._transfers         = newTransfers;
        self._service           = newService;
        self._products          = newProducts;
        self._capacity1st       = newCapacity1st;
        self._capacity2nd       = newCapacity2nd;
        self._sections          = newSections;
    }
    return self;
}

- (ConnectionDto *)getConnection:(NSDictionary *)connectionDictionary
{
    ConnectionDto *_localConnection = [[ConnectionDto alloc]init:nil withTo:nil withDuration:nil withTransfers:nil withService:nil withProducts:nil withCapacity1st:nil withCapacity2nd:nil withSections:nil];
    
    FromOrToDto     *_localFrom = [[FromOrToDto alloc]init:nil withLocation:nil withPrognosis:nil withDelay:nil withArrival:nil withDeparture:nil withPlatform:nil];
    
    FromOrToDto     *_localTo = [[FromOrToDto alloc]init:nil withLocation:nil withPrognosis:nil withDelay:nil withArrival:nil withDeparture:nil withPlatform:nil];
    
    NSString        *_localDuration;
    int             _localTransfers;
    ServiceDto      *_localService = [[ServiceDto alloc]init:nil withIrregular:nil];
    
    NSMutableArray  *_localProducts  = [[NSMutableArray alloc] init];
    NSArray         *_productArray;
    
    int             _localCapacity1st;
    int             _localCapacity2nd;
    
    NSMutableArray  *_localSections  = [[NSMutableArray alloc] init];
    NSArray         *_sectionArray;
    
    for (id connectionKey in connectionDictionary)
    {
        if ([connectionDictionary objectForKey:connectionKey] != [NSNull null])
        {
            NSLog(@"connectionDictionary key: %@", connectionKey);
            
            if ([connectionKey isEqualToString:@"from"])
            {
                _localFrom = [_localFrom getFromOrTo:[connectionDictionary objectForKey:connectionKey]];
                NSLog(@"ConnectionDto _localFrom: %@", _localFrom._platform);
            }
            
            if ([connectionKey isEqualToString:@"to"])
            {
                _localTo = [_localTo getFromOrTo:[connectionDictionary objectForKey:connectionKey]];
                NSLog(@"ConnectionDto _localTo: %@", _localTo._platform);
            }
            
            if ([connectionKey isEqualToString:@"duration"])
            {
                _localDuration = [connectionDictionary objectForKey:connectionKey];
                NSLog(@"ConnectionDto _localDuration: %@", _localDuration);
            }
            
            if ([connectionKey isEqualToString:@"transfers"])
            {
                _localTransfers = [[connectionDictionary objectForKey:connectionKey] intValue];
                NSLog(@"ConnectionDto _localTransfers: %i", _localTransfers);
            }
            
            if ([connectionKey isEqualToString:@"service"])
            {
                _localService = [_localService getService:[connectionDictionary objectForKey:connectionKey]];
                NSLog(@"ConnectionDto _localService: %@", _localService._regular);
            }
            
            if ([connectionKey isEqualToString:@"products"])
            {
                _productArray = [connectionDictionary objectForKey:connectionKey];
                int _productArrayI;
                
                NSLog(@"before count of _productArray: %i", [_productArray count]);
                
                NSString *_oneProduct;
                
                for (_productArrayI = 0; _productArrayI < [_productArray count]; _productArrayI++)
                {
                    _oneProduct = [_productArray objectAtIndex:_productArrayI];
                    [_localProducts addObject:_oneProduct];
                }
                NSLog(@"after count of _productArray: %i", [_localProducts count]);
                
                
            }
            
            if ([connectionKey isEqualToString:@"capacity1st"])
            {
                _localCapacity1st = [[connectionDictionary objectForKey:connectionKey] intValue];
                NSLog(@"ConnectionDto _localCapacity1st: %i", _localCapacity1st);
            }
            
            if ([connectionKey isEqualToString:@"capacity2nd"])
            {
                
                _localCapacity2nd = [[connectionDictionary objectForKey:connectionKey] intValue];
                NSLog(@"ConnectionDto _localCapacity2nd: %i", _localCapacity1st);
            }
            
            if ([connectionKey isEqualToString:@"passList"])
            {
                _sectionArray = [connectionDictionary objectForKey:connectionKey];
                int _sectionArrayI;
                
                NSLog(@"before count of _sectionArray: %i", [_sectionArray count]);
                
                SectionDto *_localSection = [[SectionDto alloc]init:nil withWalk:nil withDeparture:nil withArrival:nil];
                
                for (_sectionArrayI = 0; _sectionArrayI < [_sectionArray count]; _sectionArrayI++)
                {
                    _localSection = [_localSection getSection:[_sectionArray objectAtIndex:_sectionArrayI]];
                    [_localSections addObject:_localSection];
                }
                NSLog(@"after count of _sectionArray: %i", [_localSections count]);

            }
        }
    }    
    return _localConnection;
}


@end
