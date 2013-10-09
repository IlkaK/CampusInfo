/*
 CharTranslation.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header CharTranslation.m
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

#import "CharTranslation.h"

@implementation CharTranslation

/*!
 @function replaceSpecialCharsGeneral
 Replaces all chars in general.
*/
-(NSString *)replaceSpecialCharsGeneral:(NSString *)inputString
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
    return _replacedString;
}

/*!
 @function replaceSpecialCharsUTF8
 Replaces all chars with chars in utf8 format of given string.
 @param inputString
 */
-(NSString *)replaceSpecialCharsUTF8:(NSString *)inputString
{
    NSString *_replacedString = inputString;
    _replacedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                   NULL,
                                                                                   (CFStringRef)_replacedString,
                                                                                   NULL,
                                                                                   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                   kCFStringEncodingUTF8 ));
    //NSLog(@"encodedString: %@", _replacedString);
    return _replacedString;
}

/*!
 @function replaceSpecialCharsHTML
 Replaces all chars with chars in html format of given string.
 @param inputString
 */
-(NSString *)replaceSpecialCharsHTML:(NSString *)inputString
{
    NSString *_replacedString = inputString;
    
    _replacedString = [self replaceSpecialCharsGeneral:_replacedString];
    
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
