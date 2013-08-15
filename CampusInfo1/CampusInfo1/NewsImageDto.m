//
//  NewsImageDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 15.08.13.
//
//

#import "NewsImageDto.h"

@implementation NewsImageDto
@synthesize _description;
@synthesize _height;
@synthesize _imgURL;
@synthesize _link;
@synthesize _title;
@synthesize _width;

-(id) init : (NSString *) newTitle
           : (NSString *) newLink
           : (NSString *) newDescription
           : (NSString *) newImgURL
           :(int)newWidth
           :(int)newHeight
{
    self = [super init];
    if (self)
    {
        self._title         = newTitle;
        self._link          = newLink;
        self._description   = newDescription;
        self._imgURL        = newImgURL;
        self._height        = newWidth;
        self._width         = newHeight;
    }
    return self;
}

@end
