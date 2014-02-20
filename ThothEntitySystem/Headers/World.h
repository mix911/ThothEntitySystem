//
//  World.h
//  Timugin
//
//  Created by demo on 26.01.14.
//
//

#import <Foundation/Foundation.h>

@class System;
@class Entity;
@class Component;

/*
 * Мир, управляет системами и компонентами.
 */
@interface World : NSObject

/** Обновление мира
 */
- (void)update;

/** 
 * Добавляет систему в мир
 * @param system Дабавляемая в мир система
 */
- (void)addSystem:(System*)system;

/** 
 * Удаляет систему из мира
 * @param system Удаляемая из мира система
 */
- (void)removeSystem:(System*)system;

/** 
 * Добавляет компоненту compoentn в сущность entity
 * @param component Добавляемая в сущность entity компонента
 * @param entity Сущность, в которую добавляется компонента component
 */
- (void)addComponent:(Component*)component inEntity:(Entity*)entity;

/**
 * Удаляет компоненту component из сущности entity
 * @param component Удаляемая компонента
 * @param entity Сущность, из которой удаляется компонента component
 */
- (void)removeComponent:(Component*)component fromEntity:(Entity*)entity;

/**
 * Добавляет сущность
 * @param entity Добавляемая сущность
 */
- (void)addEntity:(Entity*)entity;

/**
 * Удаляет сущность
 * @param entity Удаляемая сущность
 */
- (void)removeEntity:(Entity*)entity;

/**
 * Каждая компонента имеет уникальное имя. Каждое имя компоненты должно быть зарегистрировано в World.
 * @param name Регистрируемое уникальное имя компоненты.
 *
 * @return NSUInteger Уникальный идентификатор сущности.
 */
- (NSUInteger)registerComponentName:(NSString*)name;

@end
