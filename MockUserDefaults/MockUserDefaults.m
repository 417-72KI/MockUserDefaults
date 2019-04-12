//
//  MockUserDefaults.m
//  MockUserDefaults
//
//  Created by 417.72KI on 2019/04/12.
//  Copyright © 2019 417.72KI. All rights reserved.
//

#import "MockUserDefaults.h"

@implementation NSUserDefaults (Mock)
+ (NSUserDefaults *)mockedUserDefaults
{
    static NSUserDefaults *userDefaluts;
    if (!userDefaluts) {
        userDefaluts = (id)[[MockUserDefualts alloc] init];
    }
    return userDefaluts;
}
@end

NSMutableDictionary* mockDictionary;

@implementation MockUserDefualts
+ (void)initialize
{
    mockDictionary = [NSMutableDictionary dictionary];
}

+ (void)resetMockedUserDefaults
{
    [mockDictionary removeAllObjects];
}

- (nullable id)objectForKey:(NSString *)defaultName
{
    return mockDictionary[defaultName];
}

- (void)setObject:(nullable id)value forKey:(NSString *)defaultName
{
    mockDictionary[defaultName] = value;
}

- (void)removeObjectForKey:(NSString *)defaultName
{
    [mockDictionary removeObjectForKey:defaultName];
}

- (nullable NSString *)stringForKey:(NSString *)defaultName
{
    id obj = mockDictionary[defaultName];
    if (![obj isKindOfClass:[NSString class]]) {
        return nil;
    }
    return obj;
}

- (nullable NSArray *)arrayForKey:(NSString *)defaultName
{
    id obj = mockDictionary[defaultName];
    if (![obj isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return obj;
}

- (nullable NSDictionary<NSString *, id> *)dictionaryForKey:(NSString *)defaultName
{
    id obj = mockDictionary[defaultName];
    if (![obj isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return obj;
}

- (nullable NSData *)dataForKey:(NSString *)defaultName
{
    id obj = mockDictionary[defaultName];
    if (![obj isKindOfClass:[NSData class]]) {
        return nil;
    }
    return obj;
}

- (nullable NSArray<NSString *> *)stringArrayForKey:(NSString *)defaultName
{
    id obj = mockDictionary[defaultName];
    if (![obj isKindOfClass:[NSArray class]]) {
        return nil;
    }
    for (id item in obj) {
        if (![item isKindOfClass:[NSString class]]) {
            return nil;
        }
    }
    return obj;
}
- (NSInteger)integerForKey:(NSString *)defaultName
{
    return [mockDictionary[defaultName] integerValue];
}

- (float)floatForKey:(NSString *)defaultName
{
    return [mockDictionary[defaultName] floatValue];
}

- (double)doubleForKey:(NSString *)defaultName
{
    return [mockDictionary[defaultName] doubleValue];
}

- (BOOL)boolForKey:(NSString *)defaultName
{
    return [mockDictionary[defaultName] boolValue];
}

- (nullable NSURL *)URLForKey:(NSString *)defaultName
{
    id obj = mockDictionary[defaultName];
    if (![obj isKindOfClass:[NSURL class]]) {
        return nil;
    }
    return obj;
}

- (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName
{
    mockDictionary[defaultName] = @(value);
}

- (void)setFloat:(float)value forKey:(NSString *)defaultName
{
    mockDictionary[defaultName] = @(value);
}

- (void)setDouble:(double)value forKey:(NSString *)defaultName
{
    mockDictionary[defaultName] = @(value);
}

- (void)setBool:(BOOL)value forKey:(NSString *)defaultName
{
    mockDictionary[defaultName] = @(value);
}

- (void)setURL:(nullable NSURL *)url forKey:(NSString *)defaultName
{
    mockDictionary[defaultName] = url;
}

- (void)synchronize
{
}
@end
