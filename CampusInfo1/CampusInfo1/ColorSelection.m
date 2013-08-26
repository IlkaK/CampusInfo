//
//  ColorSelection.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 26.08.13.
//
//

#import "ColorSelection.h"

@implementation ColorSelection

@synthesize _zhawOriginalBlue;

-(id) init
{
    self = [super init];
    if (self)
    {
        self._zhawOriginalBlue  = [UIColor colorWithRed:1.0/255.0 green:100.0/255.0 blue:167.0/255.0 alpha:1.0];
    }
    return self;
}

@end
