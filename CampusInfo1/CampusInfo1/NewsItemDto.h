/*
 NewsItemDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header NewsItemDto.h
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

#import <Foundation/Foundation.h>

@interface NewsItemDto : NSObject
{
    /*! @var _title Stores the title of the item */
    NSString                    *_title;
    /*! @var _link Stores the link of the item */
    NSString                    *_link;
    /*! @var _description Stores the description of the item */
    NSString                    *_description;
    /*! @var _content Stores the content of the item */
    NSString                    *_content;
    /*! @var _category Stores the category of the item */
    NSString                    *_category;
    /*! @var _startdateString Stores the start date of the item */
    NSString                    *_startdateString;
    /*! @var _starttimeString Stores the start time of the item */
    NSString                    *_starttimeString;
    /*! @var _pubDate Stores the publishing date of the item */
    NSDate                      *_pubDate;
}

@property (nonatomic, retain) NSString                    *_title;
@property (nonatomic, retain) NSString                    *_link;
@property (nonatomic, retain) NSString                    *_description;
@property (nonatomic, retain) NSString                    *_content;
@property (nonatomic, retain) NSString                    *_category;
@property (nonatomic, retain) NSString                    *_startdateString;
@property (nonatomic, retain) NSString                    *_starttimeString;
@property (nonatomic, retain) NSDate                      *_pubDate;

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
-(id)             init : (NSString *) newTitle
               withLink: (NSString *) newLink
        withDescription: (NSString *) newDescription
            withContent: (NSString *) newContent
           withCategory: (NSString *) newCategory
    withStartdateString: (NSString *) newStartdateString
    withStarttimeString: (NSString *) newStarttimeString
            withPubDate: (NSDate   *) newPubDate;

@end
