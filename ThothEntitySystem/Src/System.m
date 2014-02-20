//
//  System.m
//  Timugin
//
//  Created by demo on 26.01.14.
//
//

#import "System.h"

#import "Entity.h"
#import "Bitset.h"
#import "World.h"

@interface System()
{
    Bitset* bitset_;
    World* world_;
    NSMutableArray* entities_;
}

@end

@implementation System

- (id)initWithWorld:(World *)world
{
    self = [super init];
    if (self) {
        bitset_ = [[Bitset alloc] init];
        world_ = world;
        entities_ = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [entities_ release];
    [super dealloc];
}

- (void)addHandledComponent:(NSString *)name
{
    [bitset_ set:[world_ registerComponentName:name] value:YES];
}

- (void)initializeSystem
{
    
}

- (void)updateEntities:(NSArray*)entities tick:(NSUInteger)tick
{
    for (Entity* entity in entities) {
        [self updateEntity:entity tick:tick];
    }
}

- (void)updateEntity:(Entity*)entity tick:(NSUInteger)tick
{
    
}

- (void)addEntity:(Entity *)entity
{
    for (Entity* e in entities_) {
        if (e == entity) {
            return;
        }
    }
    [entities_ addObject:entity];
}

- (Bitset*)bitset
{
    return bitset_;
}

- (void)updateInternal
{
    [self updateEntities:entities_ tick:0];
}

- (void)setWorld:(World *)world
{
    world_ = world;
}

@end
