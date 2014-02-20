//
//  Entity.h
//  Timugin
//
//  Created by demo on 26.01.14.
//
//

#import <Foundation/Foundation.h>

@class Component;
@class Bitset;

@interface Entity : NSObject

+ (Entity*)entity;

/**
 * Добавляет компоненту compoentn в сущность
 * @param component Добавляемая в сущность компонента
 */
- (void)addComponent:(Component*)component;

/**
 * Удаляет компоненту compoentn из сущности
 * @param component Удаляемая из сущности компонента
 */
- (void)removeComponent:(Component*)component;

/**
 * Проверка, есть ли такая сущность
 * @param component Проверяемя компонента
 * @return YES если компонента включена в сущность
 */
- (BOOL)haveComponent:(Component*)component;

- (Bitset*)bitset;

@end
