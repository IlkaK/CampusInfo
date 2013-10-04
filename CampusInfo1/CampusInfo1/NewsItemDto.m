/*
 NewsItemDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header NewsItemDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds data for news item in NewsDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives a title, link, description, content, category, start date, start date and publishing date to be initally set. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It returns itself when called. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

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

/*!
 @function init
 Needs to be called initally, when instance of NewsItemDto is created.
 @param newTitle
 @param newLink
 @param newDescription
 @param newContent
 @param newStartdateString
 @param newStarttimeString
 @param newPubDate
 */
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
