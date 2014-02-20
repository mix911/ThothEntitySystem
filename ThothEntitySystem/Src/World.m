//
//  World.m
//  Timugin
//
//  Created by demo on 26.01.14.
//
//

#import "World.h"

#import "System.h"
#import "Entity.h"
#import "Component.h"
#import "SystemManager.h"
#import "EntityManager.h"

enum EWorldUpdate
{
    ADD_COMPONENT,
    UPD_COMPONENT,
    REM_COMPONENT,
    
    ADD_ENTITY,
    REM_ENTITY,
    DEL_ENTITY,
    
    ADD_SYSTEM,
    UPD_SYSTEM,
    REM_SYSTEM,
    
    SET_GROUP,
};

@interface World()
{
    NSMutableArray* systemsAdditions_;
    NSMutableArray* updateOrder_;
    NSMutableArray* systemRemovals_;
    NSMutableArray* componentAdditions_;
    NSMutableArray* componentRemovals_;
    NSMutableArray* entityAdditions_;
    NSMutableArray* entityRemovals_;
    
    SystemManager* systemManager_;
    EntityManager* entityManager_;
}

@end

@implementation World

/*
 * Инициализация
 */
- (id)init
{
    self = [super init];
    if (self) {
        updateOrder_ = [[NSMutableArray alloc] init];
        
        systemsAdditions_ = [[NSMutableArray alloc] init];
        systemRemovals_ = [[NSMutableArray alloc] init];
        componentAdditions_ = [[NSMutableArray alloc] init];
        componentRemovals_ = [[NSMutableArray alloc] init];
        entityAdditions_ = [[NSMutableArray alloc] init];
        entityRemovals_ = [[NSMutableArray alloc] init];
        
        systemManager_ = [[SystemManager alloc] initWithWorld:self];
        entityManager_ = [[EntityManager alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [updateOrder_ release];
    
    [systemsAdditions_ release];
    [systemRemovals_ release];
    [componentAdditions_ release];
    [componentRemovals_ release];
    [entityAdditions_ release];
    [entityRemovals_ release];
    
    [systemManager_ release];
    [entityRemovals_ release];
    
    [super dealloc];
}

- (void)executeAddComponent
{
    NSAssert([componentAdditions_ count], @"Empty componentAdditions_");
    
    NSDictionary* info = [componentAdditions_ objectAtIndex:0];
    
    Entity* entity = info[@"entity"];
    Component* component = info[@"component"];
    
    [entity addComponent:component];
    if ([entityManager_ haveEntity:entity]) {
        [systemManager_ addComponent:component inEntity:entity];
    }
    
    [componentAdditions_ removeObjectAtIndex:0];
}

- (void)executeRemComponent
{
    
}

- (void)executeUpdComponent
{
    
}

- (void)executeAddEntity
{
    NSAssert([entityAdditions_ count], @"Empty entityAdditions_");
    
    Entity* entity = [entityAdditions_ objectAtIndex:0];
    
    [entityManager_ addEntity:entity];
    [systemManager_ addEntity:entity];
    
    [entityAdditions_ removeObjectAtIndex:0];
}

- (void)executeRemEntity
{
    
}

- (void)executeDelEntity
{
    
}

- (void)executeAddSystem
{
    NSAssert([systemsAdditions_ count], @"Empty systemsAdditions_");
    
    System* system = [systemsAdditions_ objectAtIndex:0];
    
    NSArray* entities = [entityManager_ entities];
    [systemManager_ addSystem:system withEntities:entities];
    
    [systemsAdditions_ removeObjectAtIndex:0];
}

- (void)executeRemSystem
{
    
}

- (void)executeUpdSystem
{
    
}

- (void)executeSetGroup
{
    
}

- (void)executeUpdate:(enum EWorldUpdate)type
{
    switch (type) {
        case ADD_COMPONENT:
            [self executeAddComponent];
            break;
            
        case REM_COMPONENT:
            [self executeRemComponent];
            break;
            
        case UPD_COMPONENT:
            [self executeUpdComponent];
            break;
            
        case ADD_ENTITY:
            [self executeAddEntity];
            break;
            
        case REM_ENTITY:
            [self executeRemEntity];
            break;
            
        case DEL_ENTITY:
            [self executeDelEntity];
            break;
            
        case ADD_SYSTEM:
            [self executeAddSystem];
            break;
            
        case REM_SYSTEM:
            [self executeRemSystem];
            break;
            
        case UPD_SYSTEM:
            [self executeUpdSystem];
            break;
            
        case SET_GROUP:
            [self executeSetGroup];
            break;
            
        default:
            break;
    }
}

- (void)update
{
    for (NSNumber* num in updateOrder_) {
        [self executeUpdate:(enum EWorldUpdate)[num intValue]];
    }
    
    [updateOrder_ removeAllObjects];
    
    [systemManager_ update];
}

- (void)addSystem:(System *)system
{
    [systemsAdditions_ addObject:system];
    [updateOrder_ addObject:@(ADD_SYSTEM)];
}

- (void)removeSystem:(System *)system
{
    [systemRemovals_ addObject:system];
    [updateOrder_ addObject:@(REM_SYSTEM)];
}

- (void)addComponent:(Component *)component inEntity:(Entity *)entity
{
    component.world = self;
    component.bitType = [self registerComponentName:component.name];
    NSDictionary *into = @{@"entity":entity, @"component":component};
    [componentAdditions_ addObject:into];
    [updateOrder_ addObject:@(ADD_COMPONENT)];
}

- (void)removeComponent:(Component *)component fromEntity:(Entity *)entity
{
    NSDictionary* info = @{@"entity":entity, @"component":component};
    [componentRemovals_ addObject:info];
    [updateOrder_ addObject:@(REM_COMPONENT)];
}

- (void)addEntity:(Entity *)entity
{
    if ([entityManager_ haveEntity:entity]) {
        return;
    }
    [entityAdditions_ addObject:entity];
    [updateOrder_ addObject:@(ADD_ENTITY)];
}

- (void)removeEntity:(Entity *)entity
{
    [entityRemovals_ addObject:entity];
    [updateOrder_ addObject:@(REM_ENTITY)];
}

- (NSUInteger)registerComponentName:(NSString *)name
{
    return [systemManager_ registerComponentName:name];
}

@end
