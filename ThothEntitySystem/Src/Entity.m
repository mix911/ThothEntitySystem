//
//  Entity.m
//  Timugin
//
//  Created by demo on 26.01.14.
//
//

#import "Entity.h"

#import "Component.h"
#import "Bitset.h"

@interface Entity()
{
    Bitset* bitset_;
    NSMutableArray* components_;
}

@end

@implementation Entity

+ (Entity*)entity
{
    return [[[Entity alloc] init] autorelease];
}

- (id)init
{
    self = [super init];
    if (self) {
        bitset_ = [[Bitset alloc] init];
        components_ = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [bitset_ release];
    [components_ release];
    
    [super dealloc];
}

- (void)addComponent:(Component *)component
{
    component.owner = self;
    [bitset_ set:component.bitType value:YES];
    [components_ addObject:component];
}

- (void)removeComponent:(Component *)component
{
    NSUInteger i = 0;
    for (; i < [components_ count]; ++i) {
        if (component == [components_ objectAtIndex:i]) {
            break;
        }
    }
    
    if (i < [components_ count]) {
        [bitset_ set:component.bitType value:NO];
        [component setOwner:nil];
        [components_ removeObjectAtIndex:i];
    }
}

- (Component*)getComponentById:(NSUInteger)componentId
{
    for (Component* component in components_) {
        if (component.bitType == componentId) {
            return component;
        }
    }
    
    return nil;
}

- (BOOL)haveComponent:(Component *)component
{
    return [self getComponentById:component.bitType] != nil;
}

- (Bitset*)bitset
{
    return bitset_;
}

@end
