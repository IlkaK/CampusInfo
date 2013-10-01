//
//  CharTranslation.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 16.09.13.
//
//

#import <Foundation/Foundation.h>

@interface CharTranslation : NSObject


-(NSString *)replaceSpecialCharsHTML:(NSString *)inputString;
-(NSString *)replaceSpecialCharsUTF8:(NSString *)inputString;


@end
