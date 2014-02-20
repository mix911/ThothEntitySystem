//
//  SystemsManager.h
//  Timugin
//
//  Created by demo on 26.01.14.
//
//

#import <Foundation/Foundation.h>

@class Entity;
@class Component;
@class System;
@class World;

@interface SystemManager : NSObject

- (id)initWithWorld:(World*)world;

- (NSUInteger)registerComponentName:(NSString*)name;
- (void)addComponent:(Component*)component inEntity:(Entity *)entity;
- (void)addEntity:(Entity*)entity;
- (void)addSystem:(System*)system withEntities:(NSArray*)entities;
- (void)update;

@end
