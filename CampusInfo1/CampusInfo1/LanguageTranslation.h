//
//  LanguageTranslation.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 09.07.13.
//
//

#import <Foundation/Foundation.h>

@interface LanguageTranslation : NSObject

- (NSString *)getGermanTypeTranslation:(NSString*)acronymType;

- (NSString *)getEnglishTypeTranslation:(NSString*)acronymType;

- (NSString *)getGermanErrorMessageTranslation:(NSString *)errorMessage;

- (NSString *)getGermanGastronomyTypeTranslation:(NSString*)gastronomyType;

-(NSString *)getGermanWeekdayTranslation:(NSString *)englishWeekday;

@end
