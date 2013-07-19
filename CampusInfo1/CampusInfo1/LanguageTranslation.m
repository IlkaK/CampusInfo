//
//  LanguageTranslation.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 09.07.13.
//
//

#import "LanguageTranslation.h"

@implementation LanguageTranslation

- (NSString *)getGermanTypeTranslation:(NSString*)acronymType
{
    NSString *_localTranslation;
    
    if ([acronymType isEqualToString:@"classes"])
    {
        _localTranslation = @"Klasse";
    }
    if ([acronymType isEqualToString:@"students"])
    {
        _localTranslation = @"Student";
    }
    if ([acronymType isEqualToString:@"rooms"])
    {
        _localTranslation = @"Raum";
    }
    if ([acronymType isEqualToString:@"lecturers"])
    {
        _localTranslation = @"Dozent";
    }
    if ([acronymType isEqualToString:@"courses"])
    {
        _localTranslation = @"Kurs";
    }
    return _localTranslation;
}

- (NSString *)getEnglishTypeTranslation:(NSString*)acronymType
{
    NSString *_localTranslation;
    
    if ([acronymType isEqualToString:@"Klasse"])
    {
        _localTranslation = @"classes";
    }
    if ([acronymType isEqualToString:@"Student"])
    {
        _localTranslation = @"students";
    }
    if ([acronymType isEqualToString:@"Raum"])
    {
        _localTranslation = @"rooms";
    }
    if ([acronymType isEqualToString:@"Dozent"])
    {
        _localTranslation = @"lecturers";
    }
    if ([acronymType isEqualToString:@"Kurs"])
    {
        _localTranslation = @"courses";
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



@end
