//
//  Bitset.h
//  Timugin
//
//  Created by demo on 26.01.14.
//
//

#import <Foundation/Foundation.h>

@interface Bitset : NSObject

+ (Bitset*)bitset;

- (void)set:(NSUInteger)bit value:(BOOL)value;
- (BOOL)bitValue:(NSUInteger)bit;
- (BOOL)isSubsetOfBitset:(Bitset*)bitset;

@end
