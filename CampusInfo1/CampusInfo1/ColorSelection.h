/*
 ColorSelection.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ColorSelection.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Stores all colors used in the application. </li>
 *      <li> There is no logic implemented, the class only holds the constants. </li>
 *  </ul>
 * </li> *
 * </ul>
 */

#import <Foundation/Foundation.h>

@interface ColorSelection : NSObject
{
    UIColor *_zhawOriginalBlue;
    UIColor *_zhawLighterBlue;
    UIColor *_zhawLightestBlue;
    UIColor *_zhawWhite;
    UIColor *_zhawLightGrey;
    UIColor *_zhawRed;
    UIColor *_zhawDarkGrey;
    UIColor *_zhawDarkerBlue;
    UIColor *_zhawFontGrey;
}

@property (nonatomic, retain) UIColor *_zhawOriginalBlue;
@property (nonatomic, retain) UIColor *_zhawWhite;
@property (nonatomic, retain) UIColor *_zhawLightGrey;
@property (nonatomic, retain) UIColor *_zhawLighterBlue;
@property (nonatomic, retain) UIColor *_zhawRed;
@property (nonatomic, retain) UIColor *_zhawLightestBlue;
@property (nonatomic, retain) UIColor *_zhawDarkGrey;
@property (nonatomic, retain) UIColor *_zhawDarkerBlue;
@property (nonatomic, retain) UIColor *_zhawFontGrey;


@end
