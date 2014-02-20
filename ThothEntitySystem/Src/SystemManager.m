//
//  SystemsManager.m
//  Timugin
//
//  Created by demo on 26.01.14.
//
//

#import "SystemManager.h"

#import "Entity.h"
#import "Component.h"
#import "System.h"
#import "Bitset.h"
#import "World.h"

@interface SystemManager()
{
    NSMutableDictionary* bitNumberMap_;
    NSUInteger nextBitNumber_;
    NSMutableArray* systems_;
    World* world_;
}

@end

@implementation SystemManager

- (id)initWithWorld:(World*)world
{
    self = [super init];
    if (self) {
        bitNumberMap_ = [[NSMutableDictionary alloc] init];
        systems_ = [[NSMutableArray alloc] init];
        nextBitNumber_ = 0;
        world_ = world;
    }
    return self;
}

- (void)dealloc
{
    [bitNumberMap_ release];
    [systems_ release];
    [super dealloc];
}

- (NSUInteger)registerComponentName:(NSString *)name
{
    for (NSString* key in [bitNumberMap_ keyEnumerator]) {
        if ([key isEqualToString:name]) {
            return [bitNumberMap_[key] unsignedIntegerValue];
        }
    }
    
    bitNumberMap_[name] = @(nextBitNumber_);
    
    return nextBitNumber_++;
}

- (void)addComponent:(Component *)component inEntity:(Entity *)entity
{
    Bitset* componentBitset = [Bitset bitset];
    [componentBitset set:component.bitType value:YES];
    
    for (System* system in systems_) {
        Bitset* bitset = [system bitset];
        
        if ([bitset isSubsetOfBitset:[entity bitset]] && [componentBitset isSubsetOfBitset:bitset]) {
            [system addEntity:entity];
        }
    }
}

- (void)addEntity:(Entity *)entity
{
    for (System* system in systems_) {
        if ([[system bitset] isSubsetOfBitset:[entity bitset]]) {
            [system addEntity:entity];
        }
    }
}

- (void)addSystem:(System*)system withEntities:(NSArray *)entities
{
    [system setWorld:world_];
    [system initializeSystem];
    
    [systems_ addObject:system];
    Bitset* bitset = [system bitset];
    for (Entity* entity in entities) {
        if ([bitset isSubsetOfBitset:[entity bitset]]) {
            [system addEntity:entity];
        }
    }
}

- (void)update
{
    for (System* system in systems_) {
        [system updateInternal];
    }
}

@end
