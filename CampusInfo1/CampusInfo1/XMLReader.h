//
//  XMLReader.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import <Foundation/Foundation.h>

@interface XMLReader : NSObject
{
    NSMutableArray      *_dictionaryStack;
    NSMutableString     *_textInProgress;
    NSError             *_errorPointer;
}

@property (nonatomic, retain) NSMutableArray    *_dictionaryStack;
@property (nonatomic, retain) NSMutableString   *_textInProgress;
@property (nonatomic, retain) NSError           *_errorPointer;

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data;

+ (NSDictionary *)dictionaryForXMLString:(NSString *)string;

@end
