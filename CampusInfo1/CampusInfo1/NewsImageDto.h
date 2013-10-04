/*
 NewsImageDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header NewsImageDto.h
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


#import <Foundation/Foundation.h>

@interface NewsImageDto : NSObject
{
    /*! @var _title Stores the title of the image */
    NSString                    *_title;
    /*! @var _link Stores the link of the image */
    NSString                    *_link;
    /*! @var _description Stores the description of the image */
    NSString                    *_description;
    /*! @var _imgURL Stores the url of the image */
    NSString                    *_imgURL;
    /*! @var _width Stores the width of the image */
    int                         _width;
    /*! @var _height Stores the height of the image */
    int                         _height;
}

@property (nonatomic, retain) NSString                       *_title;
@property (nonatomic, retain) NSString                       *_link;
@property (nonatomic, retain) NSString                       *_description;
@property (nonatomic, retain) NSString                       *_imgURL;
@property (nonatomic, assign) int                            _width;
@property (nonatomic, assign) int                            _height;

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
           :(int)newHeight;


@end
