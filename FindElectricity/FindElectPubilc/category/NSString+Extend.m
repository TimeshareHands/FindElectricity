//
//  NSString+Extend.m
//  CSDirectBank
//
//  Created by 彭小坚 on 15/8/16.
//  Copyright (c) 2015年 彭小坚. All rights reserved.
//

#import "NSString+Extend.h"
#import "DemonMarco.h"
@implementation NSString (Extend)

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    
    NSDictionary *dic = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}

- (NSString *)stringWithBase64 {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)decodeBase64StringToString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self
                                                      options:0];
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:data
                               encoding:NSUTF8StringEncoding];
    return base64Decoded;
}

- (CGSize)sizeWithAttributes:(NSDictionary *)attrs constrainedToSize:(CGSize)size
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

- (NSString *)trim
{
    if (self.length > 0) {
        return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return self;
}

- (NSString *)eliminateSpace
{
    if (self.length > 0) {
        return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""];
    }
    return self;
}

- (BOOL)isContainString:(NSString *)string
{
    BOOL judge = NO;
    if (!iOS8)
    {
        if([self rangeOfString:string].location != NSNotFound)
        {
            judge = YES;
        }
    }
    else
    {
        judge = [self containsString:string];
    }
    
    return judge;
}

+ (BOOL)isNilOrEmpty:(NSString *)str
{
    if (str == nil || [str isEqual:[NSNull null]])
    {
        return YES;
    }
    else
    {
        if (str.length > 0)
        {
            return NO;
        }
        else {
            return YES;
        }
    }
}

- (NSString *)permilString
{
    if (!self||[self floatValue] == 0.00)
    {
        return @"0.00";
    }
    else if ([self floatValue]<1.00)
    {
        return self;
    }
    else
    {
        NSNumberFormatter *form =[[NSNumberFormatter alloc] init];
        [form setPositiveFormat:@",###.00;"];
        NSString *string = [form stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
        return string;
    }
    
    return @"";
}

- (NSUInteger)characterLength
{
    NSUInteger totalLength = 0;
    NSUInteger length = self.length;
    for (NSUInteger i = 0; i < length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (isascii(ch)) {
            totalLength += 1;
        } else {
            totalLength += 2;
        }
    }
    return totalLength;
}

- (NSString *)substringToCharacterIndex:(NSUInteger)to
{
    NSUInteger totalLength = 0;
    NSUInteger length = self.length;
    for (NSUInteger i = 0; i < length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (isascii(ch)) {
            if (totalLength + 1 > to) {
                return [self substringToIndex:i];
            }
            totalLength += 1;
        } else {
            if (totalLength + 2 > to) {
                return [self substringToIndex:i];
            }
            totalLength += 2;
        }
    }
    return self;
}

- (NSString *)disable_emoji
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    return modifiedString;
}

-(NSString *)stringGetNumberString{
    if (!self) return @"0";
    NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    return [[self componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
}

-(NSString *)splitStringBetweenCharNumbers:(NSUInteger)charNumbers WithSplitStr:(NSString *)splitStr{
    /** 添加size个字符串和最后一个的字符串  存入tmpStrArr中
     ** self.length =10;  size=2 charNumbers =4; 
     ** (0,4),(4,8),(8,2)
     ** NSMakeRange(8,10%4) = NSMakeRange(8,2);
     ** 分割
     **/
    if (self.length<=0||self.length<=charNumbers) {//长度小于分割字符串的长度，返回原字符串
        return self;
    }
    NSUInteger size = (self.length / charNumbers);//分割字符串个数
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++)
    {
        
        [tmpStrArr addObject:[self substringWithRange:NSMakeRange(n*charNumbers, charNumbers)]];
    }
    //添加最后一组 分割字符串 self.length =10;  size=2 charNumbers =4; NSMakeRange(8,10%4) = NSMakeRange(8,2);
    if (self.length%charNumbers!=0) {
        [tmpStrArr addObject:[self substringWithRange:NSMakeRange(size*charNumbers, (self.length % charNumbers))]];
    }
    
    //分割数组 用分割字符串splitStr拼接
    return  [tmpStrArr componentsJoinedByString:splitStr];
}


-(NSString *)amountFormat{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
    return formattedNumberString;
}

+ (NSString *)randomStrWithLength:(NSInteger)length

{
    static NSString *kStringBase = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: length];
    for (int i = 0; i < length; i++) {
        [randomString appendFormat: @"%C", [kStringBase characterAtIndex:arc4random_uniform((u_int32_t)[kStringBase length])]];
    }
    
    return [randomString copy];
}
@end
