//
//  MockUserDefaultsTests.m
//  MockUserDefaultsTests
//
//  Created by 417.72KI on 2019/04/12.
//  Copyright © 2019 417.72KI. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MockUserDefaults.h"

@interface MockUserDefaultsTests : XCTestCase
@property (nonatomic) NSUserDefaults *userDefaults;
@end

NSString *const testKey = @"MockUserDefaultsTestKey";
NSDictionary *standardDictionaryRepresentation;

@implementation MockUserDefaultsTests

+ (void)setUp
{
    [super setUp];
    standardDictionaryRepresentation = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] copy];
}

- (void)setUp
{
    [super setUp];
    self.userDefaults = [NSUserDefaults mockedUserDefaults];
}

- (void)tearDown
{
    [NSUserDefaults resetMockedUserDefaults];
    XCTAssertNotEqualObjects([[NSUserDefaults standardUserDefaults] dictionaryRepresentation], [[NSUserDefaults mockedUserDefaults] dictionaryRepresentation]);
    XCTAssertEqualObjects([[NSUserDefaults standardUserDefaults] dictionaryRepresentation], standardDictionaryRepresentation);
    [super tearDown];
}

- (void)testObject
{
    // XCTAssertNil([self.userDefaults objectForKey:testKey]);

    [self.userDefaults setObject:@"string" forKey:testKey];
    XCTAssertEqualObjects([self.userDefaults objectForKey:testKey], @"string");

    [self.userDefaults setObject:@10 forKey:testKey];
    XCTAssertNotEqualObjects([self.userDefaults objectForKey:testKey], @"string");
    XCTAssertEqualObjects([self.userDefaults objectForKey:testKey], @10);
}

- (void)testString
{
    // XCTAssertNil([self.userDefaults stringForKey:testKey]);

    [self.userDefaults setObject:@"string" forKey:testKey];
    XCTAssertEqualObjects([self.userDefaults stringForKey:testKey], @"string");

    [self.userDefaults setObject:@10 forKey:testKey];
    XCTAssertNil([self.userDefaults stringForKey:testKey]);
}

- (void)testInteger
{
    // XCTAssertEqual([self.userDefaults integerForKey:testKey], 0);

    [self.userDefaults setInteger:43 forKey:testKey];
    XCTAssertEqual([self.userDefaults integerForKey:testKey], 43);
}

- (void)testBool
{
    // XCTAssertEqual([self.userDefaults boolForKey:testKey], NO);

    [self.userDefaults setBool:YES forKey:testKey];
    XCTAssertEqual([self.userDefaults boolForKey:testKey], YES);
}

- (void)testDouble
{
    // XCTAssertEqual([self.userDefaults doubleForKey:testKey], 0);

    [self.userDefaults setDouble:0.42 forKey:testKey];
    XCTAssertEqualWithAccuracy([self.userDefaults doubleForKey:testKey], 0.42, 0.01);
}

- (void)testFloat
{
    // XCTAssertEqual([self.userDefaults doubleForKey:testKey], 0);

    [self.userDefaults setFloat:0.42 forKey:testKey];
    XCTAssertEqualWithAccuracy([self.userDefaults floatForKey:testKey], 0.42, 0.01);
}

- (void)testArray
{
    // XCTAssertNil([self.userDefaults arrayForKey:testKey]);

    [self.userDefaults setObject:@[] forKey:testKey];
    XCTAssertEqualObjects([self.userDefaults arrayForKey:testKey], @[]);

    [self.userDefaults setObject:@[@"string", @10] forKey:testKey];
    XCTAssertEqualObjects([self.userDefaults arrayForKey:testKey], (@[@"string", @10]));

    [self.userDefaults setObject:@"not an array" forKey:testKey];
    XCTAssertNil([self.userDefaults arrayForKey:testKey]);
}

- (void)testDictionary
{
    // XCTAssertNil([self.userDefaults dictionaryForKey:testKey]);

    [self.userDefaults setObject:@{} forKey:testKey];
    XCTAssertEqualObjects([self.userDefaults dictionaryForKey:testKey], @{});

    [self.userDefaults setObject:@{@"string" : @"string", @"int" : @10} forKey:testKey];
    XCTAssertEqualObjects([self.userDefaults dictionaryForKey:testKey], (@{@"string": @"string", @"int" : @10}));

    [self.userDefaults setObject:@"not a dictionary" forKey:testKey];
    XCTAssertNil([self.userDefaults dictionaryForKey:testKey]);
}

- (void)testStringArray
{
    // XCTAssertNil([self.userDefaults stringArrayForKey:testKey]);

    [self.userDefaults setObject:@[] forKey:testKey];
    XCTAssertEqualObjects([self.userDefaults stringArrayForKey:testKey], @[]);

    [self.userDefaults setObject:@[@"string"] forKey:testKey];
    XCTAssertEqualObjects([self.userDefaults stringArrayForKey:testKey], @[@"string"]);

    [self.userDefaults setObject:@[@"string", @10] forKey:testKey];
    XCTAssertNil([self.userDefaults stringArrayForKey:testKey]);

    [self.userDefaults setObject:@"not an array" forKey:testKey];
    XCTAssertNil([self.userDefaults stringArrayForKey:testKey]);
}

- (void)testData
{
    NSData*(^createData)(void) = ^() {
        NSString *base64String = @"iVBORw0KGgoAAAANSUhEUgAAAJcAAAA3CAMAAAA2XSilAAAAZlBMVEX///8AAAAYFhYPDQ6Kior5+fnz8/P29vbs7Ow/Pz/Pzs6Ojo4MCQrp6enm5ubR0dEeHR27u7utra1hYGGbm5tGRkbFxcXX19d3d3fg4OA1NTWDg4MwMDClpaVaWVpPT08mJSZubm7AnYNQAAADpklEQVRoge2X25arIAyGDbQqytRD8VS16vu/5E4AHa12bbtmdToX/hctAspnSEJ0nEOHDh06dOjvyi3yNE2Cy6c5Fjq3GQOj5lR9mmaUVwNIZsUBuuLTRFoJA7aQhPLTTKj6gYoEzdensYYNLDQZ8z+LVSIWevucidOlZO5i3iUN6zpMi/PvYKWE1eYlADfhyDmINIix9z6n6my0QkwbnKQLPHUTN6Vb15toHoLG64XoX30bnwwFaBl3uA2qTds6EwE9H8MT0mlaTrxaMsbJCCm92VNOyBvqlsBW8MBFb/MqF+0ib9Z36VjgY78PEomMvTrHqfASEscp6tMpNVx84uJrLtyCF7m0uVjsrgZKbcfWXg306F7lRZDU2OcSF66eIOb9LVxKc8E6wQtKs1yM9MiRzUYR6KT/OFzfwtXR8lCvByIDbA7LHHATN87NfD+Xc66i/ceba1Zfb6Nx/NHzQ1ysmw8KIRr/ojLkZZmoNZeacTUYgZj+vAwn+mfiKina+2QnV0FcstsaSuDbkoM1h2fkOOT/fqhjFKNhIC4Z30jYg1w0junEpcSouTgFDqLl+7jM4qfnyHqXnCtykeVsBsMG+puvNBdeX4nLhqvlwl/iiqUcuUxmzLaWWivVXOHWUDUz5X3kopfmlusrUiX2i1YlMy65zQWpew7pf191Z7g2a4dgi8vYw3Bdln4v+4zE5DYXzYpxbN9G5jp73raG2tk+kn/RZit1gjnX0zyxzTW6w/9VPY9Hk0GM69VTPPo/4Sp3c7mm1tpwMEtsAjunJ+vsc/mpvXZmCp2l2GMmxHJfcD1gajB97jTua/bCcW/J1eBYtI9LVznr1/gS2lxTZqvp0axM2xIe/N6Uj1tcmGcTOXEF1up7i01gPGh7iSVXZb3M/coH+xHyjRuPiWARjxfT2624MjAZS/KH/LWZwrekQHZ+ENON99GEY/HKm28D9mMBJnVeBXNednrJO3LJiUsiV2ozHZh8L80L4b078z2qIc9p6QHR1DN+e8ydQQmT7PsSHbrve/Jr53wFne9DiC1XxmK6Tem5t/TOGXKxJs+0+fZFoxYWDpBUyVBORcVgvyQfy4xLlCR5pQsWc0rqziAvPOfsuq6pZDxs0b8b4VyHBrDtembiVj56qhR47DvnaDoh7PfRorz/hNDFuAqKyccN134XfZsS4zljSTk8PzR/WfgRxtmcC/bm5XcrEQt7hb/08bpDxXQWVfnfoTp06NChQ4ferX934i4mmb5idQAAAABJRU5ErkJggg==";
        return [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    };

    XCTAssertNil([self.userDefaults dataForKey:testKey]);
    NSData* data = createData();
    XCTAssertNotNil(data);
    [self.userDefaults setObject:data forKey:testKey];
    XCTAssertEqualObjects([self.userDefaults dataForKey:testKey], createData());
}

- (void)testURL
{
    XCTAssertNil([self.userDefaults URLForKey:testKey]);
    NSURL *url = [NSURL URLWithString:@"https://github.com/"];
    XCTAssertNotNil(url);
    [self.userDefaults setURL:url forKey:testKey];
    XCTAssertEqualObjects([self.userDefaults URLForKey:testKey], [NSURL URLWithString:@"https://github.com/"]);
}

- (void)testRemove
{
    XCTAssertNil([self.userDefaults objectForKey:testKey]);
    [self.userDefaults setObject:@"Object" forKey:testKey];
    XCTAssertNotNil([self.userDefaults objectForKey:testKey]);

    [self.userDefaults removeObjectForKey:testKey];
    XCTAssertNil([self.userDefaults objectForKey:testKey]);
}

- (void)testSynchronize
{
    @try {
        [self.userDefaults synchronize];
    } @catch (NSException *exception) {
        XCTFail(@"Something happen in synchronize with expection: %@", exception);
    }
}

- (void)testDictionaryRepresentation
{
    NSDictionary *expected = @{
                               @"a": @"b",
                               @"b": @1,
                               @"c": @3.14,
                               @"d": @YES,
                               @"e": @[@1, @2, @3],
                               @"f": @{@"hoge": @"fuga", @"foo": @"bar"}
                               };
    [self.userDefaults setObject:@"b" forKey:@"a"];
    [self.userDefaults setInteger:1 forKey:@"b"];
    [self.userDefaults setDouble:3.14 forKey:@"c"];
    [self.userDefaults setBool:YES forKey:@"d"];
    [self.userDefaults setObject:@[@1, @2, @3] forKey:@"e"];
    [self.userDefaults setObject:@{@"hoge": @"fuga", @"foo": @"bar"} forKey:@"f"];

    XCTAssertEqualObjects([self.userDefaults dictionaryRepresentation], expected);
}
@end
