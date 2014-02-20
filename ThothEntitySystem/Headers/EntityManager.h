//
//  EntityManager.h
//  Timugin
//
//  Created by demo on 27.01.14.
//
//

#import <Foundation/Foundation.h>

@class Entity;

@interface EntityManager : NSObject

- (BOOL) haveEntity:(Entity*)entity;
- (void) addEntity:(Entity*)entity;

- (NSArray*)entities;

@end
