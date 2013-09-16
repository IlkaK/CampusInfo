//
//  CharTranslation.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 16.09.13.
//
//

#import "CharTranslation.h"

@implementation CharTranslation

-(NSString *)replaceSpecialChars:(NSString *)inputString
{
    NSString *_replacedString = inputString;
    
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"(" withString:@"%28"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@")" withString:@"%29"];
    
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"*" withString:@"%2A"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"-" withString:@"%2D"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"." withString:@"%2E"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
    
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@";" withString:@"%3B"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"<" withString:@"%3C"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@">" withString:@"%3E"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
    
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"\\" withString:@"%5C"];
    
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"ä" withString:@"&auml;"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"Ä" withString:@"&Auml;"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"ö" withString:@"&ouml;"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"Ö" withString:@"&Ouml;"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"ü" withString:@"&uuml;"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"Ü" withString:@"&Uuml;"];
    _replacedString = [_replacedString stringByReplacingOccurrencesOfString:@"ß" withString:@"&szlig;"];
    
    
    return _replacedString;
}

@end
