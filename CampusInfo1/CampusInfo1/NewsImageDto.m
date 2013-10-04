/*
 NewsImageDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header NewsImageDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds data for news image in NewsDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives a title, link, description, imgUrl, width and height to be initally set. </li>
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

#import "NewsImageDto.h"

@implementation NewsImageDto
@synthesize _description;
@synthesize _height;
@synthesize _imgURL;
@synthesize _link;
@synthesize _title;
@synthesize _width;

/*!
 @function init
 Needs to be called initally, when instance of NewsImageDto is created.
 @param newTitle
 @param newLink
 @param newDescription
 @param newImgURL
 @param newWidth
 @param newHeight
 */
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
