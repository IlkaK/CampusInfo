//
//  LanguageTranslation.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 09.07.13.
//
//

#import "LanguageTranslation.h"
#import "UIConstantStrings.h"

@implementation LanguageTranslation

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

- (NSString *)getEnglishTypeTranslation:(NSString*)acronymType
{
    NSString *_localTranslation;
    
    if ([acronymType isEqualToString:TimeTableTypeKlasse])
    {
        _localTranslation = TimeTableTypeClassEnglishPlural;
    }
    if ([acronymType isEqualToString:TimeTableTypeStudent])
    {
        _localTranslation = TimeTableTypeStudentEnglish;
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

-(NSString *)getGermanWeekdayTranslation:(NSString *)englishWeekday
{
    NSString *_localTranslation;
    
    if ([englishWeekday isEqualToString:@"monday"])
    {
        _localTranslation = @"Montag";
    }
    if ([englishWeekday isEqualToString:@"tuesday"])
    {
        _localTranslation = @"Dienstag";
    }
    if ([englishWeekday isEqualToString:@"wednesday"])
    {
        _localTranslation = @"Mittwoch";
    }
    if ([englishWeekday isEqualToString:@"thursday"])
    {
        _localTranslation = @"Donnerstag";
    }
    if ([englishWeekday isEqualToString:@"friday"])
    {
        _localTranslation = @"Freitag";
    }
    if ([englishWeekday isEqualToString:@"saturday"])
    {
        _localTranslation = @"Samstag";
    }
    if ([englishWeekday isEqualToString:@"sunday"])
    {
        _localTranslation = @"Sonntag";
    }
    return _localTranslation;
    
}

@end
