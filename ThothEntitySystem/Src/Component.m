//
//  Component.m
//  Timugin
//
//  Created by demo on 26.01.14.
//
//

#import "Component.h"

#import "World.h"
#import "Entity.h"

@interface Component()
{
    NSString* name_;
    NSObject* value_;
}

@end

@implementation Component

@synthesize world, bitType, owner;
@synthesize name = name_;
@synthesize value = value_;

+ (Component*)componentWithName:(NSString *)name value:(NSObject *)value
{
    return [[[Component alloc] initWithName:name value:value] autorelease];
}

- (id)initWithName:(NSString *)name value:(NSObject*)value
{
    self = [super init];
    if (self) {
        name_ = [NSString stringWithString:name];
        value_ = [value retain];
    }
    return self;
}

- (void)dealloc
{
    [name_ release];
    [value_ release];
    
    [super dealloc];
}

@end
