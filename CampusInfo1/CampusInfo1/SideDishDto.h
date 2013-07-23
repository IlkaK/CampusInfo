//
//  SideDishDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 23.07.13.
//
//

#import <Foundation/Foundation.h>

@interface SideDishDto : NSObject
{
    int             _sideDishId;
    NSString        *_name;
    NSString        *_version;
}

@property (nonatomic, assign) int               _sideDishId;
@property (nonatomic, retain) NSString          *_name;
@property (nonatomic, retain) NSString          *_version;


-(id)   init : (int) newSideDishId
     withName: (NSString *)newName
  withVersion: (NSString *)newVersion;

- (SideDishDto *)getSideDish:(NSDictionary *)sideDishDictionary;

@end