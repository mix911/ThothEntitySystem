//
//  Bitset.m
//  Timugin
//
//  Created by demo on 26.01.14.
//
//

#import "Bitset.h"

const size_t MAX_COMPONENT_COUNT = 2048;
const size_t BIT_SET_SIZE = MAX_COMPONENT_COUNT / 8;

@interface Bitset()
{
    unsigned char* bitset_;
}

@end

@implementation Bitset

+ (Bitset*)bitset
{
    return [[[Bitset alloc] init] autorelease];
}

- (id)init
{
    self = [super init];
    if (self) {
        bitset_ = malloc(BIT_SET_SIZE);
        memset(bitset_, 0, BIT_SET_SIZE);
    }
    return self;
}

- (void) dealloc
{
    free(bitset_);
    [super dealloc];
}

- (void)set:(NSUInteger)bit value:(BOOL)value
{
    size_t byteNumber = bit / 8;
    size_t bitInByteNumber = bit % 8;
    
    Byte mask = 1 << bitInByteNumber;
    if (value) {
        
        bitset_[byteNumber] |= mask;
    }
    else {
        bitset_[byteNumber] &= ~(1 << bitInByteNumber);
    }
}

- (BOOL)bitValue:(NSUInteger)bit
{
    NSUInteger byteNumber = bit / 8;
    size_t bitInByteNumber = bit % 8;
    Byte byte = bitset_[byteNumber];
    Byte mask = 1 << bitInByteNumber;
    return (byte & mask) != 0;
}

- (BOOL)isSubsetOfBitset:(Bitset *)bitset
{
    for (NSUInteger i = 0; i < BIT_SET_SIZE; ++i) {
        BOOL bit = [self bitValue:i];
        if (bit == NO) {
            continue;
        }
        
        if ([bitset bitValue:i] == NO) {
            return NO;
        }
    }
    return YES;
}

@end
