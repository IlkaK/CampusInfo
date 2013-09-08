//
//  NewsItemDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 15.08.13.
//
//

#import <Foundation/Foundation.h>

@interface NewsItemDto : NSObject
{
    NSString                    *_title;
    NSString                    *_link;
    NSString                    *_description;
    NSString                    *_content;
    NSString                    *_category;
    NSString                    *_startdateString;
    NSString                    *_starttimeString;
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

-(id)             init : (NSString *) newTitle
               withLink: (NSString *) newLink
        withDescription: (NSString *) newDescription
            withContent: (NSString *) newContent
           withCategory: (NSString *) newCategory
    withStartdateString: (NSString *) newStartdateString
    withStarttimeString: (NSString *) newStarttimeString
            withPubDate: (NSDate   *) newPubDate;

@end
