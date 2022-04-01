//
//  UseCaseTests.swift
//  MockUserDefaultsDemoTests
//
//  Created by 417.72KI on 2019/07/07.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import XCTest
import MockUserDefaults

@testable import MockUserDefaultsDemoLib

class UseCaseTests: XCTestCase, UsesUseCase {
    let useCase: UseCase = TestUseCase()

    override func setUp() {
        UserDefaults.resetMock()
    }

    func testExample() async {
        let expected = [
            Model(key: "1", value: "高海千歌"),
            Model(key: "2", value: "桜内梨子"),
            Model(key: "3", value: "松浦果南"),
            Model(key: "4", value: "黒澤ダイヤ"),
            Model(key: "5", value: "渡辺曜"),
            Model(key: "6", value: "津島善子"),
            Model(key: "7", value: "国木田花丸"),
            Model(key: "8", value: "小原鞠莉"),
            Model(key: "9", value: "黒澤ルビィ")
        ]
        expected.forEach(useCase.save)

        let actual = await useCase.fetchAll()
        XCTAssertEqual(actual, expected)
    }
}

private final class TestUseCase: UseCase {
    let userDefaults: UserDefaults = .mocked
}
