//
//  MockUserDefaultsSwiftTests.swift
//  MockUserDefaultsSwiftTests
//
//  Created by 417.72KI on 2019/04/12.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import XCTest
import MockUserDefaults

private let testKey = "MockUserDefaultsTestKey"

private var standardDictionaryRepresentation: [String: Any]!

class MockUserDefaultsSwiftTests: XCTestCase {
    private let userDefaults: UserDefaults = .mocked

    override static func setUp() {
        super.setUp()
        standardDictionaryRepresentation = UserDefaults.standard.dictionaryRepresentation()
    }

    override func tearDown() {
        UserDefaults.resetMock()
        super.tearDown()
    }

    override static func tearDown() {
        XCTAssertNotEqual(UserDefaults.standard.dictionaryRepresentation() as NSDictionary,
                          UserDefaults.mocked.dictionaryRepresentation() as NSDictionary)
        XCTAssertEqualWithoutXCTKeys(UserDefaults.standard.dictionaryRepresentation(),
                                     standardDictionaryRepresentation)
        super.tearDown()
    }

    func testObject() {
        XCTAssertNil(userDefaults.object(forKey: testKey))

        userDefaults.set("string", forKey: testKey)
        XCTAssertEqual(userDefaults.object(forKey: testKey) as? String, "string")

        userDefaults.set(10, forKey: testKey)
        XCTAssertEqual(userDefaults.object(forKey: testKey) as? Int, 10)
    }

    func testString() {
        XCTAssertNil(userDefaults.string(forKey: testKey))

        userDefaults.set("string", forKey: testKey)
        XCTAssertEqual(userDefaults.string(forKey: testKey), "string")

        userDefaults.set(10, forKey: testKey)
        XCTAssertNil(userDefaults.string(forKey: testKey))
    }

    func testInteger() {
        // XCTAssertEqual(userDefaults.integer(forKey: testKey), 0)

        userDefaults.set(43, forKey:testKey)
        XCTAssertEqual(userDefaults.integer(forKey: testKey), 43)

        userDefaults.set(0.42, forKey: testKey)
        XCTAssertEqual(userDefaults.integer(forKey: testKey), 0)
    }

    func testBool() {
        // XCTAssertFalse(userDefaults.bool(forKey: testKey))

        userDefaults.set(true, forKey:testKey)
        XCTAssertTrue(userDefaults.bool(forKey: testKey))
    }

    func testDouble() {
        // XCTAssertEqual(userDefaults.double(forKey: testKey), 0)

        userDefaults.set(0.42, forKey:testKey)
        XCTAssertEqual(userDefaults.double(forKey: testKey), 0.42, accuracy: 0.01)
    }

    func testFloat() {
        // XCTAssertEqual(userDefaults.float(forKey: testKey), 0)

        userDefaults.set(Float(0.42), forKey:testKey)
        XCTAssertEqual(userDefaults.float(forKey: testKey), 0.42, accuracy: 0.01)
    }

    func testArray() {
        XCTAssertNil(userDefaults.array(forKey: testKey))

        userDefaults.set([] as [Any], forKey: testKey)
        XCTAssertEqual(userDefaults.array(forKey: testKey)?.isEmpty, true)

        userDefaults.set(["string", 10] as [Any], forKey:testKey)
        XCTAssertEqual(userDefaults.array(forKey: testKey)?.count, 2)
        XCTAssertEqual(userDefaults.array(forKey: testKey)?[0] as? String, "string")
        XCTAssertEqual(userDefaults.array(forKey: testKey)?[1] as? Int, 10)

        userDefaults.set("not an array", forKey:testKey)
        XCTAssertNil(userDefaults.array(forKey: testKey))
    }

    func testDictionary() {
        XCTAssertNil(userDefaults.dictionary(forKey: testKey))

        userDefaults.set([:] as [AnyHashable: Any], forKey:testKey)
        XCTAssertEqual(userDefaults.dictionary(forKey: testKey)?.isEmpty, true)

        userDefaults.set(["string": "string", "int" : 10] as [AnyHashable: Any], forKey:testKey)
        XCTAssertEqual(userDefaults.dictionary(forKey: testKey)?.count, 2)
        XCTAssertEqual(userDefaults.dictionary(forKey: testKey)?["string"] as? String, "string")
        XCTAssertEqual(userDefaults.dictionary(forKey: testKey)?["int"] as? Int, 10)

        userDefaults.set("not a dictionary", forKey:testKey)
        XCTAssertNil(userDefaults.dictionary(forKey: testKey))
    }

    func testStringArray() {
        XCTAssertNil(userDefaults.stringArray(forKey: testKey))

        userDefaults.set([] as [Any], forKey: testKey)
        XCTAssertEqual(userDefaults.stringArray(forKey: testKey), [])

        userDefaults.set(["string"], forKey:testKey)
        XCTAssertEqual(userDefaults.stringArray(forKey: testKey), ["string"])

        userDefaults.set(["string", 10] as [Any], forKey:testKey)
        XCTAssertNil(userDefaults.stringArray(forKey: testKey))

        userDefaults.set("not an array", forKey: testKey)
        XCTAssertNil(userDefaults.stringArray(forKey: testKey))
    }

    func testData() {
        func createData() -> Data? {
            let base64 = "iVBORw0KGgoAAAANSUhEUgAAAJcAAAA3CAMAAAA2XSilAAAAZlBMVEX///8AAAAYFhYPDQ6Kior5+fnz8/P29vbs7Ow/Pz/Pzs6Ojo4MCQrp6enm5ubR0dEeHR27u7utra1hYGGbm5tGRkbFxcXX19d3d3fg4OA1NTWDg4MwMDClpaVaWVpPT08mJSZubm7AnYNQAAADpklEQVRoge2X25arIAyGDbQqytRD8VS16vu/5E4AHa12bbtmdToX/hctAspnSEJ0nEOHDh06dOjvyi3yNE2Cy6c5Fjq3GQOj5lR9mmaUVwNIZsUBuuLTRFoJA7aQhPLTTKj6gYoEzdensYYNLDQZ8z+LVSIWevucidOlZO5i3iUN6zpMi/PvYKWE1eYlADfhyDmINIix9z6n6my0QkwbnKQLPHUTN6Vb15toHoLG64XoX30bnwwFaBl3uA2qTds6EwE9H8MT0mlaTrxaMsbJCCm92VNOyBvqlsBW8MBFb/MqF+0ib9Z36VjgY78PEomMvTrHqfASEscp6tMpNVx84uJrLtyCF7m0uVjsrgZKbcfWXg306F7lRZDU2OcSF66eIOb9LVxKc8E6wQtKs1yM9MiRzUYR6KT/OFzfwtXR8lCvByIDbA7LHHATN87NfD+Xc66i/ceba1Zfb6Nx/NHzQ1ysmw8KIRr/ojLkZZmoNZeacTUYgZj+vAwn+mfiKina+2QnV0FcstsaSuDbkoM1h2fkOOT/fqhjFKNhIC4Z30jYg1w0junEpcSouTgFDqLl+7jM4qfnyHqXnCtykeVsBsMG+puvNBdeX4nLhqvlwl/iiqUcuUxmzLaWWivVXOHWUDUz5X3kopfmlusrUiX2i1YlMy65zQWpew7pf191Z7g2a4dgi8vYw3Bdln4v+4zE5DYXzYpxbN9G5jp73raG2tk+kn/RZit1gjnX0zyxzTW6w/9VPY9Hk0GM69VTPPo/4Sp3c7mm1tpwMEtsAjunJ+vsc/mpvXZmCp2l2GMmxHJfcD1gajB97jTua/bCcW/J1eBYtI9LVznr1/gS2lxTZqvp0axM2xIe/N6Uj1tcmGcTOXEF1up7i01gPGh7iSVXZb3M/coH+xHyjRuPiWARjxfT2624MjAZS/KH/LWZwrekQHZ+ENON99GEY/HKm28D9mMBJnVeBXNednrJO3LJiUsiV2ozHZh8L80L4b078z2qIc9p6QHR1DN+e8ydQQmT7PsSHbrve/Jr53wFne9DiC1XxmK6Tem5t/TOGXKxJs+0+fZFoxYWDpBUyVBORcVgvyQfy4xLlCR5pQsWc0rqziAvPOfsuq6pZDxs0b8b4VyHBrDtembiVj56qhR47DvnaDoh7PfRorz/hNDFuAqKyccN134XfZsS4zljSTk8PzR/WfgRxtmcC/bm5XcrEQt7hb/08bpDxXQWVfnfoTp06NChQ4ferX934i4mmb5idQAAAABJRU5ErkJggg=="
            return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
        }

        XCTAssertNil(userDefaults.data(forKey: testKey))

        let data = createData()
        XCTAssertNotNil(data)
        userDefaults.set(data, forKey: testKey)
        XCTAssertEqual(userDefaults.data(forKey: testKey), createData())

        userDefaults.set("github", forKey: testKey)
        XCTAssertNil(userDefaults.data(forKey: testKey))
    }

    func testUrl() {
        XCTAssertNil(userDefaults.url(forKey: testKey))

        let url = URL(string: "https://github.com/")
        XCTAssertNotNil(url)
        userDefaults.set(url, forKey: testKey)
        XCTAssertEqual(userDefaults.url(forKey: testKey), URL(string: "https://github.com/"))

        userDefaults.set("https://github.com/", forKey: testKey)
        XCTAssertNil(userDefaults.url(forKey: testKey))
    }

    func testRemove() {
        XCTAssertNil(userDefaults.object(forKey: testKey))
        userDefaults.set("object", forKey:testKey)
        XCTAssertNotNil(userDefaults.object(forKey: testKey))

        userDefaults.removeObject(forKey: testKey)
        XCTAssertNil(userDefaults.object(forKey: testKey))
    }

    func testSync() {
        XCTAssertFalse(userDefaults.synchronize())
        // XCTAssertTrue(UserDefaults.standard.synchronize())
    }
}

private func XCTAssertEqualWithoutXCTKeys(_ a: [String: Any], _ b: [String: Any], file: StaticString = #file, line: UInt = #line) {
    func removedXCTKeys(_ dic: [String: Any]) -> [String: Any] {
        var dic = dic
        dic.keys.filter { $0.starts(with: "XCT") }
            .forEach { dic.removeValue(forKey: $0) }
        return dic
    }

    XCTAssertEqual(removedXCTKeys(a) as NSDictionary, removedXCTKeys(b) as NSDictionary, file: file, line: line)
}
