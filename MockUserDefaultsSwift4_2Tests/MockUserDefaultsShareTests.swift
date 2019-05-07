//
//  MockUserDefaultsShareTests.swift
//  MockUserDefaultsSwift4_2Tests
//
//  Created by 417.72KI on 2019/04/13.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import XCTest
import MockUserDefaults

private let testKey = "MockUserDefaultsTestKey"

class MockUserDefaultsShareTests: XCTestCase {

    private var test1Repository: Test1Repository!
    private var test2Repository: Test2Repository!

    override func setUp() {
        UserDefaults.resetMock()

        test1Repository = .init()
        test2Repository = .init()
    }

    func testObject() {
        test1Repository.object = "hoge"
        XCTAssertEqual(test2Repository.object as? String, "hoge")

        test2Repository.object = 10
        XCTAssertEqual(test1Repository.object as? Int, 10)
    }

    func testString() {
        test1Repository.string = "hoge"
        XCTAssertEqual(test2Repository.string, "hoge")

        test2Repository.string = "fuga"
        XCTAssertEqual(test1Repository.string, "fuga")
    }

    func testInteger() {
        test1Repository.integer = 10
        XCTAssertEqual(test2Repository.integer, 10)

        test2Repository.integer = 417
        XCTAssertEqual(test1Repository.integer, 417)
    }

    func testBool() {
        test1Repository.bool = true
        XCTAssertTrue(test2Repository.bool)

        test2Repository.bool = false
        XCTAssertFalse(test1Repository.bool)
    }

    func testDouble() {
        test1Repository.double = 0.42
        XCTAssertEqual(test2Repository.double, 0.42, accuracy: 0.01)

        test2Repository.double = 4.17
        XCTAssertEqual(test1Repository.double, 4.17, accuracy: 0.01)
    }

    func testFloat() {
        test1Repository.float = 0.42
        XCTAssertEqual(test2Repository.float, 0.42, accuracy: 0.01)

        test2Repository.float = 4.17
        XCTAssertEqual(test1Repository.float, 4.17, accuracy: 0.01)
    }

    func testArray() {
        test1Repository.array = []
        XCTAssertNotNil(test2Repository.array)
        XCTAssertEqual(test2Repository.array?.isEmpty, true)

        test2Repository.array = ["string", 10]
        XCTAssertNotNil(test1Repository.array)
        XCTAssertEqual(test1Repository.array?.count, 2)
        XCTAssertEqual(test1Repository.array?.first as? String, "string")
        XCTAssertEqual(test1Repository.array?.last as? Int, 10)
    }

    func testDictionary() {
        test1Repository.dictionary = [:]
        XCTAssertNotNil(test2Repository.dictionary)
        XCTAssertEqual(test2Repository.dictionary?.isEmpty, true)

        test2Repository.dictionary = ["stringKey" :"string", "integerKey": 10]
        XCTAssertNotNil(test1Repository.dictionary)
        XCTAssertEqual(test1Repository.dictionary?.count, 2)
        XCTAssertEqual(test1Repository.dictionary?["stringKey"] as? String, "string")
        XCTAssertEqual(test1Repository.dictionary?["integerKey"] as? Int, 10)
    }

    func testStringArray() {
        test1Repository.stringArray = []
        XCTAssertNotNil(test2Repository.stringArray)
        XCTAssertEqual(test2Repository.stringArray?.isEmpty, true)

        test2Repository.stringArray = ["string", "array"]
        XCTAssertNotNil(test1Repository.stringArray)
        XCTAssertEqual(test1Repository.stringArray?.count, 2)
        XCTAssertEqual(test1Repository.stringArray?.first, "string")
        XCTAssertEqual(test1Repository.stringArray?.last, "array")
    }

    func testData() {
        func createData() -> Data {
            let base64 = "iVBORw0KGgoAAAANSUhEUgAAAJcAAAA3CAMAAAA2XSilAAAAZlBMVEX///8AAAAYFhYPDQ6Kior5+fnz8/P29vbs7Ow/Pz/Pzs6Ojo4MCQrp6enm5ubR0dEeHR27u7utra1hYGGbm5tGRkbFxcXX19d3d3fg4OA1NTWDg4MwMDClpaVaWVpPT08mJSZubm7AnYNQAAADpklEQVRoge2X25arIAyGDbQqytRD8VS16vu/5E4AHa12bbtmdToX/hctAspnSEJ0nEOHDh06dOjvyi3yNE2Cy6c5Fjq3GQOj5lR9mmaUVwNIZsUBuuLTRFoJA7aQhPLTTKj6gYoEzdensYYNLDQZ8z+LVSIWevucidOlZO5i3iUN6zpMi/PvYKWE1eYlADfhyDmINIix9z6n6my0QkwbnKQLPHUTN6Vb15toHoLG64XoX30bnwwFaBl3uA2qTds6EwE9H8MT0mlaTrxaMsbJCCm92VNOyBvqlsBW8MBFb/MqF+0ib9Z36VjgY78PEomMvTrHqfASEscp6tMpNVx84uJrLtyCF7m0uVjsrgZKbcfWXg306F7lRZDU2OcSF66eIOb9LVxKc8E6wQtKs1yM9MiRzUYR6KT/OFzfwtXR8lCvByIDbA7LHHATN87NfD+Xc66i/ceba1Zfb6Nx/NHzQ1ysmw8KIRr/ojLkZZmoNZeacTUYgZj+vAwn+mfiKina+2QnV0FcstsaSuDbkoM1h2fkOOT/fqhjFKNhIC4Z30jYg1w0junEpcSouTgFDqLl+7jM4qfnyHqXnCtykeVsBsMG+puvNBdeX4nLhqvlwl/iiqUcuUxmzLaWWivVXOHWUDUz5X3kopfmlusrUiX2i1YlMy65zQWpew7pf191Z7g2a4dgi8vYw3Bdln4v+4zE5DYXzYpxbN9G5jp73raG2tk+kn/RZit1gjnX0zyxzTW6w/9VPY9Hk0GM69VTPPo/4Sp3c7mm1tpwMEtsAjunJ+vsc/mpvXZmCp2l2GMmxHJfcD1gajB97jTua/bCcW/J1eBYtI9LVznr1/gS2lxTZqvp0axM2xIe/N6Uj1tcmGcTOXEF1up7i01gPGh7iSVXZb3M/coH+xHyjRuPiWARjxfT2624MjAZS/KH/LWZwrekQHZ+ENON99GEY/HKm28D9mMBJnVeBXNednrJO3LJiUsiV2ozHZh8L80L4b078z2qIc9p6QHR1DN+e8ydQQmT7PsSHbrve/Jr53wFne9DiC1XxmK6Tem5t/TOGXKxJs+0+fZFoxYWDpBUyVBORcVgvyQfy4xLlCR5pQsWc0rqziAvPOfsuq6pZDxs0b8b4VyHBrDtembiVj56qhR47DvnaDoh7PfRorz/hNDFuAqKyccN134XfZsS4zljSTk8PzR/WfgRxtmcC/bm5XcrEQt7hb/08bpDxXQWVfnfoTp06NChQ4ferX934i4mmb5idQAAAABJRU5ErkJggg=="
            return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)!
        }

        let data = createData()
        test1Repository.data = data
        XCTAssertEqual(test2Repository.data, data)

        test2Repository.data = nil
        XCTAssertNil(test1Repository.data)
    }

    func testUrl() {
        let url = URL(string: "https://github.com/")!
        test1Repository.url = url
        XCTAssertEqual(test2Repository.url, url)

        test2Repository.url = nil
        XCTAssertNil(test1Repository.url)
    }
}

private protocol UsesUserDefaults {
    var userDefaults: UserDefaults { get }
}

private protocol TestRepository: UsesUserDefaults {
    var object: Any? { get set }
    var string: String? { get set }
    var integer: Int { get set }
    var bool: Bool { get set }
    var double: Double { get set }
    var float: Float { get set }
    var array: [Any]? { get set }
    var dictionary: [String: Any]? { get set }
    var stringArray: [String]? { get set }
    var data: Data? { get set }
    var url: URL? { get set }
}

private extension TestRepository {
    var object: Any? {
        get { return userDefaults.object(forKey: "object") }
        set { userDefaults.set(newValue, forKey: "object") }
    }
    var string: String? {
        get { return userDefaults.string(forKey: "string") }
        set { userDefaults.set(newValue, forKey: "string") }
    }
    var integer: Int {
        get { return userDefaults.integer(forKey: "integer") }
        set { userDefaults.set(newValue, forKey: "integer") }
    }
    var bool: Bool {
        get { return userDefaults.bool(forKey: "bool") }
        set { userDefaults.set(newValue, forKey: "bool") }
    }
    var double: Double {
        get { return userDefaults.double(forKey: "double") }
        set { userDefaults.set(newValue, forKey: "double") }
    }
    var float: Float {
        get { return userDefaults.float(forKey: "float") }
        set { userDefaults.set(newValue, forKey: "float") }
    }
    var array: [Any]? {
        get { return userDefaults.array(forKey: "array") }
        set { userDefaults.set(newValue, forKey: "array") }
    }
    var dictionary: [String: Any]? {
        get { return userDefaults.dictionary(forKey: "dictionary") }
        set { userDefaults.set(newValue, forKey: "dictionary") }
    }
    var stringArray: [String]? {
        get { return userDefaults.stringArray(forKey: "stringArray") }
        set { userDefaults.set(newValue, forKey: "stringArray") }
    }
    var data: Data? {
        get { return userDefaults.data(forKey: "data") }
        set { userDefaults.set(newValue, forKey: "data") }
    }
    var url: URL? {
        get { return userDefaults.url(forKey: "url") }
        set { userDefaults.set(newValue, forKey: "url") }
    }
}

private class Test1Repository: TestRepository {
    let userDefaults: UserDefaults = .mocked
}

private class Test2Repository: TestRepository {
    let userDefaults: UserDefaults = .mocked
}
