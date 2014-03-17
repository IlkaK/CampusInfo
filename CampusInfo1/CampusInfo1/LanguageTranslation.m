/*
 LanguageTranslation.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header LanguageTranslation.m
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

#import "LanguageTranslation.h"
#import "UIConstantStrings.h"

@implementation LanguageTranslation

/*!
 @function getDisplayLanguageTypeTranslation
 Transfers the acronym type from English to display language.
 @param acronymType
 */
- (NSString *)getDisplayLanguageTypeTranslation:(NSString*)acronymType
{
    NSString *_localTranslation;
    if ([acronymType isEqualToString:TimeTableTypeClassEnglishPlural])
    {
        _localTranslation = NSLocalizedString(@"TimeTableTypeClass", nil);
    }
    if ([acronymType isEqualToString:TimeTableTypeStudentEnglishPlural])
    {
        _localTranslation = NSLocalizedString(@"TimeTableTypeStudent", nil);
    }
    if ([acronymType isEqualToString:TimeTableTypeRoomEnglishPlural])
    {
        _localTranslation = NSLocalizedString(@"TimeTableTypeRoom", nil);
    }
    if ([acronymType isEqualToString:TimeTableTypeLecturerEnglishPlural])
    {
        _localTranslation = NSLocalizedString(@"TimeTableTypeTeacher", nil);
    }
    if ([acronymType isEqualToString:TimeTableTypeCourseEnglishPlural])
    {
        _localTranslation = NSLocalizedString(@"TimeTableTypeCourse", nil);
    }
    return _localTranslation;
}

/*!
 @function getEnglishTypeTranslation
 Transfers the acronym type from German to English.
 @param acronymType
 */
- (NSString *)getEnglishTypeTranslation:(NSString*)acronymType
{
    NSString *_localTranslation;
    if ([acronymType isEqualToString:NSLocalizedString(@"TimeTableTypeClass", nil)])
    {
        _localTranslation = TimeTableTypeClassEnglishPlural;
    }
    if ([acronymType isEqualToString:NSLocalizedString(@"TimeTableTypeStudent", nil)])
    {
        _localTranslation = TimeTableTypeStudentEnglishPlural;
    }
    if ([acronymType isEqualToString:NSLocalizedString(@"TimeTableTypeRoom", nil)])
    {
        _localTranslation = TimeTableTypeRoomEnglishPlural;
    }
    if ([acronymType isEqualToString:NSLocalizedString(@"TimeTableTypeTeacher", nil)])
    {
        _localTranslation = TimeTableTypeLecturerEnglishPlural;
    }
    if ([acronymType isEqualToString:NSLocalizedString(@"TimeTableTypeCourse", nil)])
    {
        _localTranslation = TimeTableTypeCourseEnglishPlural;
    }
    return _localTranslation;
}

/*!
 @function getDisplayLanguageErrorMessageTranslation
 Transfers the given error message into display language.
 @param errorMessage
 */
- (NSString *)getDisplayLanguageErrorMessageTranslation:(NSString *)errorMessage
{
    NSString *_localTranslation = @"";
    if ([errorMessage isEqualToString:TimeTableCourseError])
    {
        _localTranslation = NSLocalizedString(@"TimeTableOverVCCourseError", nil);
    }
    if ([errorMessage isEqualToString:TimeTableTeacherError])
    {
        _localTranslation = NSLocalizedString(@"TimeTableOverVCTeacherError", nil);
    }
    if ([errorMessage isEqualToString:TimeTableRoomError])
    {
        _localTranslation = NSLocalizedString(@"TimeTableOverVCRoomError", nil);
    }
    if ([errorMessage isEqualToString:TimeTableClassError])
    {
        _localTranslation = NSLocalizedString(@"TimeTableOverVCClassError", nil);
    }
    if ([errorMessage isEqualToString:TimeTableStudentError])
    {
        _localTranslation = NSLocalizedString(@"TimeTableOverVCStudentIdError", nil);
    }
    return _localTranslation;
}

/*!
 @function getDisplayLanguageGastronomyTypeTranslation
 Transfers the given gastronomy type into display language.
 @param gastronomyType
 */
- (NSString *)getDisplayLanguageGastronomyTypeTranslation:(NSString*)gastronomyType
{
    NSString *_localTranslation;
    if ([gastronomyType isEqualToString:MensaTypeCafeteria])
    {
        _localTranslation = NSLocalizedString(@"MensaVCTypeMensa", nil);
    }
    if ([gastronomyType isEqualToString:MensaTypeCanteen])
    {
        _localTranslation = NSLocalizedString(@"MensaVCTypeCafeteria", nil);
    }
    return _localTranslation;
}

/*!
 @function getDisplayLanguageWeekdayTranslation
 Transfers the given weekday into display language.
 @param englishWeekday
 */
-(NSString *)getDisplayLanguageWeekdayTranslation:(NSString *)englishWeekday
{
    NSString *_localTranslation;
    if ([englishWeekday isEqualToString:MondayEnglish])
    {
        _localTranslation = NSLocalizedString(@"Monday", nil);
    }
    if ([englishWeekday isEqualToString:TuesdayEnglish])
    {
        _localTranslation = NSLocalizedString(@"Tuesday", nil);
    }
    if ([englishWeekday isEqualToString:WednesdayEnglish])
    {
        _localTranslation = NSLocalizedString(@"Wednesday", nil);
    }
    if ([englishWeekday isEqualToString:ThursdayEnglish])
    {
        _localTranslation = NSLocalizedString(@"Thursday", nil);
    }
    if ([englishWeekday isEqualToString:FridayEnglish])
    {
        _localTranslation = NSLocalizedString(@"Friday", nil);
    }
    if ([englishWeekday isEqualToString:SaturdayEnglish])
    {
        _localTranslation = NSLocalizedString(@"Saturday", nil);
    }
    if ([englishWeekday isEqualToString:SundayEnglish])
    {
        _localTranslation = NSLocalizedString(@"Sunday", nil);
    }
    return _localTranslation;
}

@end
