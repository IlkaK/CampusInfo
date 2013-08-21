//
//  PEffect.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 21.08.13.
//
//

#import <Foundation/Foundation.h>
typedef void (^EffectBlock)(UIView *view, CGContextRef context);

@interface PEffect : NSObject
+(PEffect *)border:(CGPathRef) path color:(UIColor*) color width:(CGFloat)width;
+(PEffect *)gradientColor:(NSArray*)colors locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
+(PEffect *)innerShadowPath:(CGPathRef)path color:(UIColor*)color radius:(CGFloat)radius offset:(CGSize)offset;
+(PEffect *)outerShadowPath:(CGPathRef)path color:(UIColor*)color radius:(CGFloat)radius offset:(CGSize)offset;

+(PEffect *)halfHighlight;
+(PEffect *)outerShadow;
+(PEffect *)innerShadow;
+(PEffect *)innerGlow;

+(PEffect *)effectWithZIndex:(int)zIndex block:(EffectBlock)block;

@property (nonatomic, assign) int zIndex;
@property (nonatomic, copy) EffectBlock effectBlock;
@end