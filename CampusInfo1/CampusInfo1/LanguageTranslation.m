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

#import "LanguageTranslation.h"
#import "UIConstantStrings.h"

@implementation LanguageTranslation

/*!
 @function getGermanTypeTranslation
 Transfers the acronym type from English to German.
 @param acronymType
 */
- (NSString *)getGermanTypeTranslation:(NSString*)acronymType
{
    NSString *_localTranslation;
    if ([acronymType isEqualToString:TimeTableTypeClassEnglishPlural])
    {
        _localTranslation = TimeTableTypeKlasse;
    }
    if ([acronymType isEqualToString:TimeTableTypeStudentEnglishPlural])
    {
        _localTranslation = TimeTableTypeStudent;
    }
    if ([acronymType isEqualToString:TimeTableTypeRoomEnglishPlural])
    {
        _localTranslation = TimeTableTypeRaum;
    }
    if ([acronymType isEqualToString:TimeTableTypeLecturerEnglishPlural])
    {
        _localTranslation = TimeTableTypeDozent;
    }
    if ([acronymType isEqualToString:TimeTableTypeCourseEnglishPlural])
    {
        _localTranslation = TimeTableTypeKurs;
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
    if ([acronymType isEqualToString:TimeTableTypeKlasse])
    {
        _localTranslation = TimeTableTypeClassEnglishPlural;
    }
    if ([acronymType isEqualToString:TimeTableTypeStudent])
    {
        _localTranslation = TimeTableTypeStudentEnglishPlural;
    }
    if ([acronymType isEqualToString:TimeTableTypeRaum])
    {
        _localTranslation = TimeTableTypeRoomEnglishPlural;
    }
    if ([acronymType isEqualToString:TimeTableTypeDozent])
    {
        _localTranslation = TimeTableTypeLecturerEnglishPlural;
    }
    if ([acronymType isEqualToString:TimeTableTypeKurs])
    {
        _localTranslation = TimeTableTypeCourseEnglishPlural;
    }
    return _localTranslation;
}

/*!
 @function getGermanErrorMessageTranslation
 Transfers the given error message into German.
 @param errorMessage
 */
- (NSString *)getGermanErrorMessageTranslation:(NSString *)errorMessage
{
    NSString *_localTranslation = @"";
    if ([errorMessage isEqualToString:@"Schedule for given course name could not be found."])
    {
        _localTranslation = @"Der Stundenplan für den gesuchten Kurs konnte nicht gefunden werden. Bitte Schreibweise beachten (z.B. t.MARI-V) und kein Datum wählen, welches zu weit in der Zukunft oder in der Vergangenheit liegt.";
    }
    if ([errorMessage isEqualToString:@"Schedule for given lecturer id could not be found."])
    {
        _localTranslation = @"Der Stundenplan für den gesuchten Dozenten konnte nicht gefunden werden. Bitte Schreibweise beachten (z.B. huhp, rege) und kein Datum wählen, welches zu weit in der Zukunft oder in der Vergangenheit liegt.";
    }
    if ([errorMessage isEqualToString:@"Schedule for given room name could not be found."])
    {
        _localTranslation = @"Der Stundenplan für den gesuchten Raum konnte nicht gefunden werden. Bitte Schreibweise beachten (z.B. te 223, th 344) und kein Datum wählen, welches zu weit in der Zukunft oder in der Vergangenheit liegt.";
    }
    if ([errorMessage isEqualToString:@"Schedule for given school class could not be found."])
    {
        _localTranslation = @"Der Stundenplan für die gesuchte Klasse konnte nicht gefunden werden. Bitte Schreibweise beachten (z.B. T_WI11a.BA) und kein Datum wählen, welches zu weit in der Zukunft oder in der Vergangenheit liegt.";
    }
    if ([errorMessage isEqualToString:@"Schedule for given students id could not be found."])
    {
        _localTranslation = @"Der Stundenplan für den gesuchten Studenten konnte nicht gefunden werden. Bitte Schreibweise beachten und kein Datum wählen, welches zu weit in der Zukunft oder in der Vergangenheit liegt.";
    }
    return _localTranslation;
}

/*!
 @function getGermanGastronomyTypeTranslation
 Transfers the given gastronomy type into German.
 @param gastronomyType
 */
- (NSString *)getGermanGastronomyTypeTranslation:(NSString*)gastronomyType
{
    NSString *_localTranslation;
    if ([gastronomyType isEqualToString:@"Cafeteria"])
    {
        _localTranslation = @"Cafeteria";
    }
    if ([gastronomyType isEqualToString:@"Canteen"])
    {
        _localTranslation = @"Mensa";
    }
    return _localTranslation;
}

/*!
 @function getGermanWeekdayTranslation
 Transfers the given weekday into German.
 @param englishWeekday
 */
-(NSString *)getGermanWeekdayTranslation:(NSString *)englishWeekday
{
    NSString *_localTranslation;
    if ([englishWeekday isEqualToString:MondayEnglish])
    {
        _localTranslation = MondayGerman;
    }
    if ([englishWeekday isEqualToString:TuesdayEnglish])
    {
        _localTranslation = TuesdayGerman;
    }
    if ([englishWeekday isEqualToString:WednesdayEnglish])
    {
        _localTranslation = WednesdayGerman;
    }
    if ([englishWeekday isEqualToString:ThursdayEnglish])
    {
        _localTranslation = ThursdayGerman;
    }
    if ([englishWeekday isEqualToString:FridayEnglish])
    {
        _localTranslation = FridayGerman;
    }
    if ([englishWeekday isEqualToString:SaturdayEnglish])
    {
        _localTranslation = SaturdayGerman;
    }
    if ([englishWeekday isEqualToString:SundayEnglish])
    {
        _localTranslation = SundayGerman;
    }
    return _localTranslation;
}

@end
