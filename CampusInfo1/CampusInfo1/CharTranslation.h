/*
 CharTranslation.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header CharTranslation.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Provides methods to replace chars with utf8 chars and chars with html chars. </li>
 *  </ul>
 * </li> *
 * </ul>
 */

#import <Foundation/Foundation.h>

@interface CharTranslation : NSObject

/*!
 @function replaceSpecialCharsHTML
 Replaces all chars with chars in html format of given string.
 @param inputString
 */
-(NSString *)replaceSpecialCharsHTML:(NSString *)inputString;

/*!
 @function replaceSpecialCharsUTF8
 Replaces all chars with chars in utf8 format of given string.
 @param inputString
 */
-(NSString *)replaceSpecialCharsUTF8:(NSString *)inputString;


@end
