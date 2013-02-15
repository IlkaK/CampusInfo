//
//  SchoolClassDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SchoolClassDto : NSObject {
    NSString  *_name; 
}

@property (nonatomic, retain) NSString  *_name;

-(id) init : (NSString  *) newName;

@end
