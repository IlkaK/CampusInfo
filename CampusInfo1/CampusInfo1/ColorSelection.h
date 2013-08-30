//
//  ColorSelection.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 26.08.13.
//
//

#import <Foundation/Foundation.h>

@interface ColorSelection : NSObject
{
    UIColor *_zhawOriginalBlue;
    UIColor *_zhawLighterBlue;
    UIColor *_zhawLightestBlue;
    UIColor *_zhawWhite;
    UIColor *_zhawLightGrey;
    UIColor *_zhawRed;
    UIColor *_zhawDarkGrey;
}

@property (nonatomic, retain) UIColor *_zhawOriginalBlue;
@property (nonatomic, retain) UIColor *_zhawWhite;
@property (nonatomic, retain) UIColor *_zhawLightGrey;
@property (nonatomic, retain) UIColor *_zhawLighterBlue;
@property (nonatomic, retain) UIColor *_zhawRed;
@property (nonatomic, retain) UIColor *_zhawLightestBlue;
@property (nonatomic, retain) UIColor *_zhawDarkGrey;

@end
