//
//  EntityManager.m
//  Timugin
//
//  Created by demo on 27.01.14.
//
//

#import "EntityManager.h"

#import "Entity.h"

@interface EntityManager()
{
    NSMutableSet* entities_;
}

@end

@implementation EntityManager

- (id)init
{
    self = [super init];
    if (self) {
        entities_ = [[NSMutableSet alloc] init];
    }
    return self;
}

// TODO: хорошо бы удостовериться, что сущности не повторяться
- (void)addEntity:(Entity *)entity
{
    [entities_ addObject:entity];
}

- (BOOL)haveEntity:(Entity*)entity
{
    return [entities_ containsObject:entity];
}

- (void)dealloc
{
    [entities_ release];
    [super dealloc];
}

- (NSArray*)entities
{
    NSMutableArray* res = [NSMutableArray arrayWithCapacity:entities_.count];
    for (Entity* entity in entities_) {
        [res addObject:entity];
    }
    return res;
}

@end
