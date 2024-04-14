//
//  MockUserDefaults.m
//  MockUserDefaults
//
//  Created by 417.72KI on 2019/04/12.
//  Copyright © 2019 417.72KI. All rights reserved.
//

#import "MockUserDefaults.h"

NS_ASSUME_NONNULL_BEGIN

@interface MockUserDefaults: NSObject

- (nullable id)objectForKey:(NSString *)defaultName;
- (void)setObject:(nullable id)value forKey:(NSString *)defaultName;
- (void)removeObjectForKey:(NSString *)defaultName;
- (nullable NSString *)stringForKey:(NSString *)defaultName;
- (nullable NSArray *)arrayForKey:(NSString *)defaultName;
- (nullable NSDictionary<NSString *, id> *)dictionaryForKey:(NSString *)defaultName;
- (nullable NSData *)dataForKey:(NSString *)defaultName;
- (nullable NSArray<NSString *> *)stringArrayForKey:(NSString *)defaultName;
- (NSInteger)integerForKey:(NSString *)defaultName;
- (float)floatForKey:(NSString *)defaultName;
- (double)doubleForKey:(NSString *)defaultName;
- (BOOL)boolForKey:(NSString *)defaultName;
- (nullable NSURL *)URLForKey:(NSString *)defaultName API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
- (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName;
- (void)setFloat:(float)value forKey:(NSString *)defaultName;
- (void)setDouble:(double)value forKey:(NSString *)defaultName;
- (void)setBool:(BOOL)value forKey:(NSString *)defaultName;
- (void)setURL:(nullable NSURL *)url forKey:(NSString *)defaultName API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
- (NSDictionary<NSString *, id> *)dictionaryRepresentation;
- (BOOL)synchronize;
@end

NS_ASSUME_NONNULL_END

// MARK: -
NSMutableDictionary *mockDictionary;

@implementation MockUserDefaults
+ (void)initialize
{
    mockDictionary = [NSMutableDictionary dictionary];
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

- (NSDictionary<NSString *,id> *)dictionaryRepresentation
{
    return [mockDictionary copy];
}

- (BOOL)synchronize
{
    return NO;
}
@end

// MARK: -
@implementation NSUserDefaults (Mock)
+ (NSUserDefaults *)mockedUserDefaults
{
    static id userDefaluts;
    if (!userDefaluts) {
        userDefaluts = [MockUserDefaults new];
    }
    return userDefaluts;
}

+ (NSUserDefaults *)deprecatedMockedUserDefaults
{
    return [self mockedUserDefaults];
}

+ (void)resetMockedUserDefaults
{
    [mockDictionary removeAllObjects];
}
@end
