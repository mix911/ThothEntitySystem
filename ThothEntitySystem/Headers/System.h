//
//  System.h
//  Timugin
//
//  Created by demo on 26.01.14.
//
//

#import <Foundation/Foundation.h>

@class Entity;
@class World;
@class Bitset;

@protocol ISystem <NSObject>

- (void)initializeSystem;
- (void)updateEntities:(NSArray*)entities tick:(NSUInteger)tick;
- (void)updateEntity:(Entity*)entity tick:(NSUInteger)tick;

@end

@interface System : NSObject <ISystem>

- (id)initWithWorld:(World*)world;
- (void)setWorld:(World*)world;

- (void)initializeSystem;
- (void)updateEntities:(NSArray*)entities tick:(NSUInteger)tick;
- (void)updateEntity:(Entity*)entity tick:(NSUInteger)tick;

- (void)addHandledComponent:(NSString*)name;

// Protected:
- (void)addEntity:(Entity*)entity;
- (Bitset*)bitset;
- (void)updateInternal;

@end
