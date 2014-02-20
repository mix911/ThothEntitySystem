//
//  Component.h
//  Timugin
//
//  Created by demo on 26.01.14.
//
//

#import <Foundation/Foundation.h>

@class World;
@class Entity;

@interface Component : NSObject

+ (Component*)componentWithName:(NSString*)name value:(NSObject*)value;

- (id)initWithName:(NSString*)name value:(NSObject*)value;

// TODO: нужно разобраться, retain или assign
@property (assign)World* world;
@property (assign)Entity* owner;
@property (readonly)NSString* name;
@property (readonly)NSObject* value;

@property NSUInteger bitType;

@end
