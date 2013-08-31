//
//  ServiceDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 31.08.13.
//
//

#import <Foundation/Foundation.h>

@interface ServiceDto : NSObject
{
    NSString        *_regular;
    NSString        *_irregular;
}

@property (nonatomic, retain) NSString          *_regular;
@property (nonatomic, retain) NSString          *_irregular;

-(id)                     init: (NSString *)newRegular
                 withIrregular: (NSString *)newIrregular;


- (ServiceDto *)getService:(NSDictionary *)serviceDictionary;

@end
