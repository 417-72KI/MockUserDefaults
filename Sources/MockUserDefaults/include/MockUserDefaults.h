//
//  MockUserDefaults.h
//  MockUserDefaults
//
//  Created by 417.72KI on 2019/04/12.
//  Copyright © 2019 417.72KI. All rights reserved.
//

@import Foundation;

FOUNDATION_EXPORT double MockUserDefaultsVersionNumber;
FOUNDATION_EXPORT const unsigned char MockUserDefaultsVersionString[];

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (Mock)

/** Mock object for `NSUserDefaults` */
@property (class, readonly) NSUserDefaults *mockedUserDefaults NS_SWIFT_NAME(mock);

/** Backward compatibility for Swift. Will be removed on next major version. */
@property (class, readonly) NSUserDefaults *deprecatedMockedUserDefaults NS_SWIFT_NAME(mocked) DEPRECATED_MSG_ATTRIBUTE("Renamed to `mock`");

/** Clear all data inside mock. */
+ (void)resetMockedUserDefaults NS_SWIFT_NAME(resetMock());

@end

NS_ASSUME_NONNULL_END
