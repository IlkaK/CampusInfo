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
 *      <li> Provides methods to transfer specific strings from English to display language and vice versa. </li>
 *  </ul>
 * </li>
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives strings to transfer to English/display language. </li>
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
 @function getDisplayLanguageTypeTranslation
 Transfers the acronym type from English to display language.
 @param acronymType
 */
- (NSString *)getDisplayLanguageTypeTranslation:(NSString*)acronymType;

/*!
 @function getEnglishTypeTranslation
 Transfers the acronym type from display language to English.
 @param acronymType
 */
- (NSString *)getEnglishTypeTranslation:(NSString*)acronymType;

/*!
 @function getDisplayLanguageErrorMessageTranslation
 Transfers the given error message into display language.
 @param errorMessage
 */
- (NSString *)getDisplayLanguageErrorMessageTranslation:(NSString *)errorMessage;

/*!
 @function getDisplayLanguageGastronomyTypeTranslation
 Transfers the given gastronomy type into display language.
 @param gastronomyType
 */
- (NSString *)getDisplayLanguageGastronomyTypeTranslation:(NSString*)gastronomyType;

/*!
 @function getDisplayLanguageWeekdayTranslation
 Transfers the given weekday into display language.
 @param englishWeekday
 */
-(NSString *)getDisplayLanguageWeekdayTranslation:(NSString *)englishWeekday;

@end
