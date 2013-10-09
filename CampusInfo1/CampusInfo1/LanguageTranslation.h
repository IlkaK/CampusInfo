/*
 LanguageTranslation.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header LanguageTranslation.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Provides methods to transfer specific strings from English to German and vice versa. </li>
 *  </ul>
 * </li>
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives strings to transfer to English/German. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It sends back the transferred strings. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */


#import <Foundation/Foundation.h>

@interface LanguageTranslation : NSObject

/*!
 @function getGermanTypeTranslation
 Transfers the acronym type from English to German.
 @param acronymType
 */
- (NSString *)getGermanTypeTranslation:(NSString*)acronymType;

/*!
 @function getEnglishTypeTranslation
 Transfers the acronym type from German to English.
 @param acronymType
 */
- (NSString *)getEnglishTypeTranslation:(NSString*)acronymType;

/*!
 @function getGermanErrorMessageTranslation
 Transfers the given error message into German.
 @param errorMessage
 */
- (NSString *)getGermanErrorMessageTranslation:(NSString *)errorMessage;

/*!
 @function getGermanGastronomyTypeTranslation
 Transfers the given gastronomy type into German.
 @param gastronomyType
 */
- (NSString *)getGermanGastronomyTypeTranslation:(NSString*)gastronomyType;

/*!
 @function getGermanWeekdayTranslation
 Transfers the given weekday into German.
 @param englishWeekday
 */
-(NSString *)getGermanWeekdayTranslation:(NSString *)englishWeekday;

@end
