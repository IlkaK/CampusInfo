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
@synthesize _startdateString;
@synthesize _starttimeString;

-(id)           init : (NSString *) newTitle
             withLink: (NSString *) newLink
      withDescription: (NSString *) newDescription
          withContent: (NSString *) newContent
         withCategory: (NSString *) newCategory
  withStartdateString: (NSString *) newStartdateString
  withStarttimeString: (NSString *) newStarttimeString
          withPubDate: (NSDate   *) newPubDate
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
        self._starttimeString = newStarttimeString;
        self._startdateString = newStartdateString;
    }
    return self;
}

@end
