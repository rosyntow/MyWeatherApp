//
//  SerializibleObject.h
//  GoalManager
//
//  Created by Rosina Otchere-Nyarko on 7/31/13.
//  Copyright (c) 2013 xperttech. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SerializibleObject <NSObject>

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)dictionaryRepresentation;

@end
