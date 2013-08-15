//
//  NewsItemDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 15.08.13.
//
//

#import "NewsItemDto.h"

@implementation NewsItemDto
@synthesize _title;
@synthesize _link;
@synthesize _description;
@synthesize _category;
@synthesize _content;
@synthesize _pubDate;

-(id) init : (NSString *) newTitle
           : (NSString *) newLink
           : (NSString *) newDescription
           : (NSString *) newContent
           : (NSString *) newCategory
           : (NSDate   *) newPubDate
{
    self = [super init];
    if (self)
    {
        self._title           = newTitle;
        self._link            = newLink;
        self._description     = newDescription;
        self._content         = newContent;
        self._category        = newCategory;
        self._pubDate         = newPubDate;
    }
    return self;
}

@end
